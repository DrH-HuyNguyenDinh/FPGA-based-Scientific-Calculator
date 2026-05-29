module pipelined_fadder (
   input  logic        i_clk, i_reset,
   input  logic [31:0] i_a, i_b,
   input  logic [ 1:0] i_rm,
   input  logic        i_sub, i_e,
   
   output logic [31:0] o_s,
   output logic        o_stall
);

logic [26:0] a_small_frac; 
logic [23:0] a_large_frac; 
logic [22:0] a_inf_nan_frac;
logic [7:0] a_exp; 
logic a_is_nan, a_is_inf, a_sign, a_op_sub;

logic [26:0] c_small_frac; 
logic [23:0] c_large_frac; 
logic [22:0] c_inf_nan_frac;
logic [7:0] c_exp; 
logic [1:0] c_rm;
logic c_is_nan, c_is_inf, c_sign, c_op_sub; 
logic [27:0] c_frac;
logic c_e;

logic [27:0] n_frac; 
logic [22:0] n_inf_nan_frac; 
logic [7:0] n_exp;
logic [1:0] n_rm; 
logic n_is_nan, n_is_inf, n_sign;
logic n_e;

logic busy;
logic start_pulse;

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset)
        busy <= 1'b0;
    else if (start_pulse)
        busy <= 1'b1;   
    else if (n_e)
        busy <= 1'b0;   
end

assign start_pulse = i_e & ~busy;
assign o_stall = (i_e | busy) & ~n_e;

fadd_align alignment (
   .i_a            (i_a            ),
   .i_b            (i_b            ),
   .i_sub          (i_sub          ),
   
   .o_small_frac27 (a_small_frac  ),
   .o_large_frac24 (a_large_frac  ),
   .o_inf_nan_frac (a_inf_nan_frac),
   .o_temp_exp     (a_exp          ),
   .o_s_is_nan     (a_is_nan       ), 
   .o_s_is_inf     (a_is_inf       ), 
   .o_sign         (a_sign         ), 
   .o_op_sub       (a_op_sub       )
);

reg_align_cal reg_ac (
   .i_clk            (i_clk          ), 
   .i_reset          (i_reset        ),
   .i_e              (start_pulse    ), 
   .i_a_small_frac   (a_small_frac  ),
   .i_a_large_frac   (a_large_frac  ),
   .i_a_inf_nan_frac (a_inf_nan_frac),
   .i_a_exp          (a_exp          ),
   .i_a_rm           (i_rm          ),
   .i_a_is_nan       (a_is_nan       ), 
   .i_a_is_inf       (a_is_inf       ), 
   .i_a_sign         (a_sign         ), 
   .i_a_op_sub       (a_op_sub       ),
      
   .o_c_small_frac   (c_small_frac  ),
   .o_c_large_frac   (c_large_frac  ),
   .o_c_inf_nan_frac (c_inf_nan_frac),
   .o_c_exp          (c_exp          ),
   .o_c_rm           (c_rm          ),
   .o_c_is_nan       (c_is_nan       ), 
   .o_c_is_inf       (c_is_inf       ), 
   .o_c_sign         (c_sign         ), 
   .o_c_op_sub       (c_op_sub       ),
   .o_c_e            (c_e            )
);

fadd_cal calculation (
   .i_large_frac24(c_large_frac),
   .i_op_sub      (c_op_sub    ),
   .i_small_frac27(c_small_frac),
   
   .o_cal_frac    (c_frac      )
); 

reg_cal_norm reg_cn (
   .i_clk            (i_clk          ), 
   .i_reset          (i_reset        ),
   .i_c_e            (c_e            ), 
   .i_c_frac         (c_frac         ),
   .i_c_inf_nan_frac (c_inf_nan_frac),
   .i_c_exp          (c_exp          ),
   .i_c_rm           (c_rm          ),
   .i_c_is_nan       (c_is_nan       ), 
   .i_c_is_inf       (c_is_inf       ), 
   .i_c_sign         (c_sign         ),
   
   .o_n_frac         (n_frac         ),
   .o_n_inf_nan_frac (n_inf_nan_frac),
   .o_n_exp          (n_exp          ),
   .o_n_rm           (n_rm          ),
   .o_n_is_nan       (n_is_nan       ), 
   .o_n_is_inf       (n_is_inf       ), 
   .o_n_sign         (n_sign         ),
   .o_n_e            (n_e            )
);

fadd_norm normalization (
   .i_cal_frac    (n_frac        ),
   .i_inf_nan_frac(n_inf_nan_frac),
   .i_temp_exp    (n_exp          ),
   .i_rm          (n_rm          ),
   .i_is_nan      (n_is_nan       ), 
   .i_is_inf      (n_is_inf       ),
   .i_sign        (n_sign         ),
   
   .o_s           (o_s            )
);

endmodule

module fadd_align (
   input  logic [31:0] i_a, i_b,
   input  logic        i_sub,
   
   output logic [26:0] o_small_frac27,
   output logic [23:0] o_large_frac24,
   output logic [22:0] o_inf_nan_frac,
   output logic [ 7:0] o_temp_exp,
   output logic        o_s_is_nan, o_s_is_inf, 
   output logic        o_sign, o_op_sub
);

logic [31:0] diff_check;
logic exchange;
logic [31:0] fp_large, fp_small;
logic fp_large_hidden_bit, fp_small_hidden_bit;
logic [23:0] small_frac24;
logic fp_large_expo_is_ff, fp_small_expo_is_ff;
logic fp_large_frac_is_00, fp_small_frac_is_00;
logic fp_large_is_inf, fp_small_is_inf;
logic fp_large_is_nan, fp_small_is_nan;
logic [22:0] nan_frac, diff_nan;
logic [7:0] exp_diff;
logic small_den_only;
logic [7:0] shift_amount;
logic [49:0] small_frac50;
logic [8:0] diff_25;
logic [49:0] stage0, stage1, stage2, stage3, stage4;

assign diff_check[31:0] = {1'b0, i_a[30:0]} - {1'b0, i_b[30:0]};
assign exchange = diff_check[31];

always @(*) begin
    if (exchange) begin
        fp_large = i_b;
        fp_small = i_a;
    end else begin
        fp_large = i_a;
        fp_small = i_b;
    end
end

assign fp_large_hidden_bit = |fp_large[30:23];
assign fp_small_hidden_bit = |fp_small[30:23];

assign o_large_frac24[23:0] = {fp_large_hidden_bit, fp_large[22:0]};
assign   small_frac24[23:0] = {fp_small_hidden_bit, fp_small[22:0]};

assign o_temp_exp = fp_large[30:23];
always @(*) begin
    if (exchange) begin
        o_sign = i_sub ^ i_b[31]; 
    end else begin
        o_sign = i_a[31];
    end
end

assign o_op_sub = i_sub ^ fp_large[31] ^ fp_small[31];

assign fp_large_expo_is_ff = &fp_large[30:23]; // exp == 0xff
assign fp_small_expo_is_ff = &fp_small[30:23];

assign fp_large_frac_is_00 = ~|fp_large[22:0]; // frac == 0x0
assign fp_small_frac_is_00 = ~|fp_small[22:0];

assign fp_large_is_inf = fp_large_expo_is_ff & fp_large_frac_is_00;
assign fp_small_is_inf = fp_small_expo_is_ff & fp_small_frac_is_00;

assign fp_large_is_nan = fp_large_expo_is_ff & ~fp_large_frac_is_00;
assign fp_small_is_nan = fp_small_expo_is_ff & ~fp_small_frac_is_00;

assign o_s_is_inf = fp_large_is_inf | fp_small_is_inf;

assign o_s_is_nan = fp_large_is_nan | fp_small_is_nan | 
                  ((i_sub ^ fp_small[31] ^ fp_large[31]) & 
                    fp_large_is_inf & fp_small_is_inf);

assign diff_nan = {1'b0, i_b[21:0]} - {1'b0, i_a[21:0]};
always @(*) begin
    if (diff_nan[22]) begin
        nan_frac = {1'b1, i_a[21:0]};
    end else begin
        nan_frac = {1'b1, i_b[21:0]};
    end
end

always @(*) begin
    if (o_s_is_nan) begin
        o_inf_nan_frac = nan_frac;
    end else begin
        o_inf_nan_frac = 23'h0;
    end
end

assign exp_diff[7:0] = fp_large[30:23] - fp_small[30:23];
assign small_den_only = (|fp_large[30:23]) & (~|fp_small[30:23]); // fp_large[30:23] != 0; fp_small[30:23] == 0

always @(*) begin
    if (small_den_only) begin
        shift_amount = exp_diff - 8'h1;
    end else begin
        shift_amount = exp_diff;
    end
end

assign diff_25[8:0] = 9'd25 - {1'b0, shift_amount};
always @(*) begin
    if (diff_25[8]) begin
        small_frac50 = {26'd0, small_frac24};
    end else begin
        stage0 = {small_frac24, 26'd0};

        if (shift_amount[0]) stage1 = {1'b0, stage0[49:1]};
        else                 stage1 = stage0;

        if (shift_amount[1]) stage2 = {2'b0, stage1[49:2]};
        else                 stage2 = stage1;

        if (shift_amount[2]) stage3 = {4'b0, stage2[49:4]};
        else                 stage3 = stage2;

        if (shift_amount[3]) stage4 = {8'b0, stage3[49:8]};
        else                 stage4 = stage3;

        if (shift_amount[4]) small_frac50 = {16'b0, stage4[49:16]};
        else                 small_frac50 = stage4;
    end
end

assign o_small_frac27 = {small_frac50[49:24], |small_frac50[23:0]};

endmodule

module reg_align_cal (
   input  logic        i_clk, i_reset,
   input  logic        i_e,
   input  logic [26:0] i_a_small_frac,
   input  logic [23:0] i_a_large_frac,
   input  logic [22:0] i_a_inf_nan_frac,
   input  logic [ 7:0] i_a_exp,
   input  logic [ 1:0] i_a_rm,
   input  logic        i_a_is_nan, i_a_is_inf, i_a_sign, i_a_op_sub,
   
   output logic [26:0] o_c_small_frac,
   output logic [23:0] o_c_large_frac,
   output logic [22:0] o_c_inf_nan_frac,
   output logic [ 7:0] o_c_exp,
   output logic [ 1:0] o_c_rm,
   output logic        o_c_is_nan, o_c_is_inf, o_c_sign, o_c_op_sub, o_c_e
);

always @(posedge i_clk or negedge i_reset) begin
   if (~i_reset) begin
      o_c_rm           <= 0;
      o_c_is_nan       <= 0;
      o_c_is_inf       <= 0;
      o_c_inf_nan_frac <= 0;
      o_c_sign         <= 0;
      o_c_exp          <= 0;
      o_c_op_sub       <= 0;
      o_c_large_frac   <= 0;
      o_c_small_frac   <= 0;
      o_c_e            <= 0;
   end else if (i_e) begin
      o_c_rm           <= i_a_rm;
      o_c_is_nan       <= i_a_is_nan;
      o_c_is_inf       <= i_a_is_inf;
      o_c_inf_nan_frac <= i_a_inf_nan_frac;
      o_c_sign         <= i_a_sign;
      o_c_exp          <= i_a_exp;
      o_c_op_sub       <= i_a_op_sub;
      o_c_large_frac   <= i_a_large_frac;
      o_c_small_frac   <= i_a_small_frac;
      o_c_e            <= i_e;
   end else
      o_c_e            <= 1'b0;
end
endmodule

module fadd_cal (
   input  logic [23:0] i_large_frac24,
   input  logic        i_op_sub,
   input  logic [26:0] i_small_frac27,
   
   output logic [27:0] o_cal_frac
);

logic [27:0] aligned_large_frac, aligned_small_frac;

assign aligned_large_frac[27:0] = {1'b0, i_large_frac24, 3'b0};
assign aligned_small_frac[27:0] = {1'b0, i_small_frac27};

always @(*) begin
   if (i_op_sub)
      o_cal_frac = aligned_large_frac - aligned_small_frac;
   else
      o_cal_frac = aligned_large_frac + aligned_small_frac;
end

endmodule

module reg_cal_norm (
   input  logic        i_clk, i_reset,
   input  logic        i_c_e,
   input  logic [27:0] i_c_frac,
   input  logic [22:0] i_c_inf_nan_frac,
   input  logic [ 7:0] i_c_exp,
   input  logic [ 1:0] i_c_rm,
   input  logic        i_c_is_nan, i_c_is_inf, i_c_sign,
   
   output logic [27:0] o_n_frac,
   output logic [22:0] o_n_inf_nan_frac,
   output logic [ 7:0] o_n_exp,
   output logic [ 1:0] o_n_rm,
   output logic        o_n_is_nan, o_n_is_inf, o_n_sign, o_n_e
);

always @(posedge i_clk or negedge i_reset) begin
   if (~i_reset) begin
      o_n_rm           <= 0;
      o_n_is_nan       <= 0;
      o_n_is_inf       <= 0;
      o_n_inf_nan_frac <= 0;
      o_n_sign         <= 0;
      o_n_exp          <= 0;
      o_n_frac         <= 0;
      o_n_e            <= 0;
   end else if (i_c_e) begin
      o_n_rm           <= i_c_rm;
      o_n_is_nan       <= i_c_is_nan;
      o_n_is_inf       <= i_c_is_inf;
      o_n_inf_nan_frac <= i_c_inf_nan_frac;
      o_n_sign         <= i_c_sign;
      o_n_exp          <= i_c_exp;
      o_n_frac         <= i_c_frac;
      o_n_e            <= i_c_e;
   end else
      o_n_e            <= 0;
end

endmodule

module fadd_norm (
   input  logic [27:0] i_cal_frac,
   input  logic [22:0] i_inf_nan_frac,
   input  logic [ 7:0] i_temp_exp,
   input  logic [ 1:0] i_rm,
   input  logic        i_is_nan, i_is_inf,
   input  logic        i_sign,
   
   output logic [31:0] o_s
);

logic [26:0] f4, f3, f2, f1, f0;
logic [4:0] zeros;
logic [26:0] frac0;
logic [7:0] exp0;
logic [8:0] diff_cmp; 
logic exp_gt_zeros;  
logic [7:0] shift_amt;    
logic [26:0] l_stage0, l_stage1, l_stage2, l_stage3;
logic [26:0] frac_shifted;
logic frac_plus_1;
logic [24:0] frac_round;
logic [7:0] exponent;
logic overflow;

assign zeros[4] = ~|i_cal_frac[26:11]; // 16-bit 0
always @(*) begin
   if (zeros[4])
      f4 = {i_cal_frac[10:0], 16'b0};
   else
      f4 = i_cal_frac[26:0];
end

assign zeros[3] = ~|f4[26:19]; // 8-bit 0
always @(*) begin
   if (zeros[3])
      f3 = {f4[18:0], 8'b0};
   else
      f3 = f4;
end

assign zeros[2] = ~|f3[26:23]; // 4-bit 0
always @(*) begin
   if (zeros[2])
      f2 = {f3[22:0], 4'b0};
   else
      f2 = f3;
end

assign zeros[1] = ~|f2[26:25]; // 2-bit 0
always @(*) begin
   if (zeros[1])
      f1 = {f2[24:0], 2'b0};
   else
      f1 = f2;
end

assign zeros[0] = ~f1[26]; // 1-bit 0
always @(*) begin
   if (zeros[0])
      f0 = {f1[25:0], 1'b0};
   else
      f0 = f1;
end

assign diff_cmp = {4'b0, zeros} - {1'b0, i_temp_exp};
assign exp_gt_zeros = diff_cmp[8];

assign shift_amt = i_temp_exp - 8'h1;

always @(*) begin
    if (shift_amt[0]) l_stage0 = {i_cal_frac[25:0], 1'b0};
    else              l_stage0 = i_cal_frac[26:0];

    if (shift_amt[1]) l_stage1 = {l_stage0[24:0], 2'b0};
    else              l_stage1 = l_stage0;

    if (shift_amt[2]) l_stage2 = {l_stage1[22:0], 4'b0};
    else              l_stage2 = l_stage1;

    if (shift_amt[3]) l_stage3 = {l_stage2[18:0], 8'b0};
    else              l_stage3 = l_stage2;

    if (shift_amt[4]) frac_shifted = {l_stage3[10:0], 16'b0};
    else              frac_shifted = l_stage3;

    if (i_cal_frac[27]) begin
        frac0 = i_cal_frac[27:1];
        exp0  = i_temp_exp + 8'h1;
    end else begin
        if (exp_gt_zeros && f0[26]) begin
            exp0  = i_temp_exp - {3'b0, zeros};
            frac0 = f0;
        end else begin
            exp0 = 8'h0;
            if (|i_temp_exp) begin
                frac0 = frac_shifted;
            end else begin
                frac0 = i_cal_frac[26:0];
            end
        end
    end
end

assign frac_plus_1 = ~i_rm[1] & ~i_rm[0] & frac0[2] & (frac0[1] | frac0[0]) |
                     ~i_rm[1] & ~i_rm[0] & frac0[2] & ~frac0[1] & ~frac0[0] & frac0[3] |
                     ~i_rm[1] &  i_rm[0] & (frac0[2] | frac0[1] | frac0[0]) & i_sign |
                      i_rm[1] & ~i_rm[0] & (frac0[2] | frac0[1] | frac0[0]) & ~i_sign;

assign frac_round[24:0] = {1'b0, frac0[26:3]} + frac_plus_1;

always @(*) begin
   if (frac_round[24])
      exponent = exp0 + 8'h1;
   else
      exponent = exp0;
end

assign overflow = &exp0 | &exponent;

always @(*) begin
    casez ({overflow, i_rm, i_sign, i_is_nan, i_is_inf})
        6'b1_00_?_0_? : o_s = {i_sign, 8'hff, 23'h000000}; // Infinity
        6'b1_01_0_0_? : o_s = {i_sign, 8'hfe, 23'h7fffff}; // Max Normal
        6'b1_01_1_0_? : o_s = {i_sign, 8'hff, 23'h000000}; // Infinity
        6'b1_10_0_0_? : o_s = {i_sign, 8'hff, 23'h000000}; // Infinity
        6'b1_10_1_0_? : o_s = {i_sign, 8'hfe, 23'h7fffff}; // Max Normal
        6'b1_11_?_0_? : o_s = {i_sign, 8'hfe, 23'h7fffff}; // Max Normal
        6'b0_??_?_0_0 : o_s = {i_sign, exponent, frac_round[22:0]};
        6'b?_??_?_1_? : o_s = {1'b1, 8'hff, i_inf_nan_frac}; // NaN 
        6'b?_??_?_0_1 : o_s = {i_sign, 8'hff, i_inf_nan_frac}; // Infinity Payload (thường là 0)
        default       : o_s = {i_sign, 8'h00, 23'h000000}; // Zero
    endcase
end

endmodule
