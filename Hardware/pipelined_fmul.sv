module pipelined_fmul (
   input  logic        i_clk, i_reset,
   input  logic [ 1:0] i_rm,
   input  logic        i_e,
   input  logic [31:0] i_a, i_b,
   
   output logic [31:0] o_s,
   output logic        o_stall
);

logic m_sign;
logic [9:0] m_exp10;
logic m_is_nan;
logic m_is_inf;
logic [22:0] m_inf_nan_frac;
logic [39:0] m_sum;
logic [39:0] m_carry;
logic [7:0] m_z8;

logic [1:0] a_rm;
logic a_sign;
logic [9:0] a_exp10;
logic a_is_nan;
logic a_is_inf;
logic [22:0] a_inf_nan_frac;
logic [39:0] a_sum;
logic [39:0] a_carry;
logic [7:0] a_z8;
logic [47:8] a_z40;
logic [47:0] a_z48;
logic a_e;

logic [1:0] n_rm;
logic n_sign;
logic [9:0] n_exp10;
logic n_is_nan;
logic n_is_inf;
logic [22:0] n_inf_nan_frac;
logic [47:0] n_z48;
logic n_e;

// =========================================================================
// THÊM LOGIC START_PULSE VÀ BUSY (Giống hệt fadd)
// =========================================================================
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
// =========================================================================


fmul_mul mul1 (
   .i_a            (i_a            ), 
   .i_b            (i_b            ),
   
   .o_z_sum        (m_sum          ), 
   .o_z_carry      (m_carry        ),
   .o_inf_nan_frac (m_inf_nan_frac ),
   .o_exp10        (m_exp10        ),
   .o_z8           (m_z8           ),
   .o_sign         (m_sign         ), 
   .o_s_is_nan     (m_is_nan       ), 
   .o_s_is_inf     (m_is_inf       )
);

reg_mul_add reg_ma(
   .i_clk            (i_clk          ),
   .i_reset          (i_reset        ),
   .i_e              (start_pulse    ), // <--- SỬA: Nối vào start_pulse thay vì i_e thô
   .i_m_sum          (m_sum          ), 
   .i_m_carry        (m_carry        ),
   .i_m_inf_nan_frac (m_inf_nan_frac ),
   .i_m_exp10        (m_exp10        ),
   .i_m_z8           (m_z8           ),
   .i_m_rm           (i_rm           ),
   .i_m_sign         (m_sign         ), 
   .i_m_is_nan       (m_is_nan       ), 
   .i_m_is_inf       (m_is_inf       ),
   
   .o_a_sum          (a_sum          ), 
   .o_a_carry        (a_carry        ),
   .o_a_inf_nan_frac (a_inf_nan_frac ),
   .o_a_exp10        (a_exp10        ),
   .o_a_z8           (a_z8           ),
   .o_a_rm           (a_rm           ),
   .o_a_sign         (a_sign         ), 
   .o_a_is_nan       (a_is_nan       ), 
   .o_a_is_inf       (a_is_inf       ),
   .o_a_e            (a_e            )
);

fmul_add mul2(
   .i_z_sum  (a_sum),
   .i_z_carry(a_carry),
   
   .o_z      (a_z40)
);

assign a_z48 = {a_z40,a_z8};

reg_add_norm reg_an (
   .i_clk            (i_clk          ), 
   .i_reset          (i_reset        ), 
   .i_e              (1'b0           ), // Bỏ xài port i_e thô này
   .i_a_z48          (a_z48          ),
   .i_a_inf_nan_frac (a_inf_nan_frac ),
   .i_a_exp10        (a_exp10        ),
   .i_a_rm           (a_rm           ),
   .i_a_sign         (a_sign         ), 
   .i_a_is_nan       (a_is_nan       ), 
   .i_a_is_inf       (a_is_inf       ),
   .i_a_e            (a_e            ), // <--- Đây là port Token truyền từ tầng trước sang
   
   .o_n_z48          (n_z48          ), 
   .o_n_inf_nan_frac (n_inf_nan_frac ),
   .o_n_exp10        (n_exp10        ),
   .o_n_rm           (n_rm           ),
   .o_n_sign         (n_sign         ), 
   .o_n_is_nan       (n_is_nan       ), 
   .o_n_is_inf       (n_is_inf       ),
   .o_n_e            (n_e            )
);

fmul_norm mul3 (
   .i_z            (n_z48          ),
   .i_inf_nan_frac (n_inf_nan_frac ),
   .i_exp10        (n_exp10        ),
   .i_rm           (n_rm           ),
   .i_sign         (n_sign         ), 
   .i_is_nan       (n_is_nan       ), 
   .i_is_inf       (n_is_inf       ),
   
   .o_s            (o_s            )
);

endmodule


// =========================================================================
// CÁC SUB-MODULE BÊN DƯỚI GIỮ NGUYÊN 100% NHƯ CỦA BẠN
// =========================================================================
module fmul_mul (
   input  logic [31:0] i_a, i_b,
   output logic [39:0] o_z_sum, o_z_carry,
   output logic [22:0] o_inf_nan_frac,
   output logic [ 9:0] o_exp10,
   output logic [ 7:0] o_z8,
   output logic        o_sign, o_s_is_nan, o_s_is_inf
);

logic a_expo_is_00, b_expo_is_00;
logic a_expo_is_ff, b_expo_is_ff;
logic a_frac_is_00, b_frac_is_00;
logic a_is_inf, b_is_inf;
logic a_is_nan, b_is_nan;
logic a_is_0, b_is_0;
logic [22:0] nan_frac;
logic [22:0] diff_ab;
logic [23:0] a_frac24, b_frac24;
logic [47:0] mult_comb;
logic [47:0] full_mult_result; 

assign a_expo_is_00 = ~|i_a[30:23]; 
assign b_expo_is_00 = ~|i_b[30:23];

assign a_expo_is_ff = &i_a[30:23]; 
assign b_expo_is_ff = &i_b[30:23];

assign a_frac_is_00 = ~|i_a[22:0]; 
assign b_frac_is_00 = ~|i_b[22:0];

assign a_is_inf = a_expo_is_ff & a_frac_is_00;
assign b_is_inf = b_expo_is_ff & b_frac_is_00;

assign a_is_nan = a_expo_is_ff & ~a_frac_is_00;
assign b_is_nan = b_expo_is_ff & ~b_frac_is_00;

assign a_is_0 = a_expo_is_00 & a_frac_is_00;
assign b_is_0 = b_expo_is_00 & b_frac_is_00;

assign o_s_is_inf = a_is_inf | b_is_inf;
assign o_s_is_nan = a_is_nan | (a_is_inf & b_is_0) | b_is_nan | (b_is_inf & a_is_0);

assign diff_ab = {1'b0, i_a[21:0]} - {1'b0, i_b[21:0]};

always @(*) begin
    if (~diff_ab[22]) 
        nan_frac = {1'b1, i_a[21:0]};
    else 
        nan_frac = {1'b1, i_b[21:0]};
end

always @(*) begin
   if (o_s_is_nan)
      o_inf_nan_frac = nan_frac;
   else
      o_inf_nan_frac = 23'h0;
end

assign o_sign = i_a[31] ^ i_b[31];

assign o_exp10 = {2'h0, i_a[30:23]} + {2'h0, i_b[30:23]} - 10'h7f + a_expo_is_00 + b_expo_is_00;

assign a_frac24[23:0] = {~a_expo_is_00, i_a[22:0]};
assign b_frac24[23:0] = {~b_expo_is_00, i_b[22:0]}; 

assign full_mult_result = a_frac24 * b_frac24;

assign o_z8 = full_mult_result[7:0];   
assign o_z_sum = full_mult_result[47:8];  
assign o_z_carry = 40'b0;

endmodule

module reg_mul_add (
   input  logic        i_clk, i_reset,
   input  logic        i_e, 
   input  logic [39:0] i_m_sum, 
   input  logic [39:0] i_m_carry,
   input  logic [22:0] i_m_inf_nan_frac,
   input  logic [ 9:0] i_m_exp10,
   input  logic [ 7:0] i_m_z8,
   input  logic [ 1:0] i_m_rm,
   input  logic        i_m_sign, i_m_is_nan, i_m_is_inf,
   
   output logic [39:0] o_a_sum, 
   output logic [39:0] o_a_carry,
   output logic [22:0] o_a_inf_nan_frac,
   output logic [ 9:0] o_a_exp10,
   output logic [ 7:0] o_a_z8,
   output logic [ 1:0] o_a_rm,
   output logic        o_a_sign, o_a_is_nan, o_a_is_inf, o_a_e
);

always_ff @(posedge i_clk or negedge i_reset) begin
   if (~i_reset) begin
      o_a_rm           <= 0;
      o_a_sign         <= 0;
      o_a_exp10        <= 0;
      o_a_is_nan       <= 0;
      o_a_is_inf       <= 0;
      o_a_inf_nan_frac <= 0;
      o_a_sum          <= 0;
      o_a_carry        <= 0;
      o_a_z8           <= 0;
      o_a_e            <= 0;
   end else if (i_e) begin
      o_a_rm           <= i_m_rm;
      o_a_sign         <= i_m_sign;
      o_a_exp10        <= i_m_exp10;
      o_a_is_nan       <= i_m_is_nan;
      o_a_is_inf       <= i_m_is_inf;
      o_a_inf_nan_frac <= i_m_inf_nan_frac;
      o_a_sum          <= i_m_sum;
      o_a_carry        <= i_m_carry;
      o_a_z8           <= i_m_z8;
      o_a_e            <= i_e;
   end else
      o_a_e            <= 0;
end

endmodule

module fmul_add (
   input  logic [39:0] i_z_sum,
   input  logic [39:0] i_z_carry,
   
   output logic [47:8] o_z
);

assign o_z = i_z_sum + i_z_carry;

endmodule

module reg_add_norm (
   input  logic        i_clk, i_reset, 
   input  logic        i_e, // Vẫn giữ nguyên nhưng code bên dưới đã không dùng nó chốt data nữa
   input  logic [47:0] i_a_z48, 
   input  logic [22:0] i_a_inf_nan_frac,
   input  logic [ 9:0] i_a_exp10,
   input  logic [ 1:0] i_a_rm,
   input  logic        i_a_sign, i_a_is_nan, i_a_is_inf, i_a_e,
   
   output logic [47:0] o_n_z48, 
   output logic [22:0] o_n_inf_nan_frac,
   output logic [ 9:0] o_n_exp10,
   output logic [ 1:0] o_n_rm,
   output logic        o_n_sign, o_n_is_nan, o_n_is_inf, o_n_e
);
always_ff @(posedge i_clk or negedge i_reset) begin
   if (~i_reset) begin
      o_n_rm           <= 0;
      o_n_sign         <= 0;
      o_n_exp10        <= 0;
      o_n_is_nan       <= 0;
      o_n_is_inf       <= 0;
      o_n_inf_nan_frac <= 0;
      o_n_z48          <= 0;
      o_n_e            <= 0;
   end else if (i_a_e) begin     // <--- ĐIỂM SỬA DUY NHẤT LÀ CHỖ NÀY ĐỂ MẠCH TỰ TRÔI
      o_n_rm           <= i_a_rm;
      o_n_sign         <= i_a_sign;
      o_n_exp10        <= i_a_exp10;
      o_n_is_nan       <= i_a_is_nan;
      o_n_is_inf       <= i_a_is_inf;
      o_n_inf_nan_frac <= i_a_inf_nan_frac;
      o_n_z48          <= i_a_z48;
      o_n_e            <= i_a_e;
   end else
      o_n_e            <= 0;
end

endmodule

module fmul_norm (
   input  logic [47:0] i_z, 
   input  logic [22:0] i_inf_nan_frac,
   input  logic [ 9:0] i_exp10,
   input  logic [ 1:0] i_rm,
   input  logic i_sign, i_is_nan, i_is_inf,
   
   output logic [31:0] o_s
);

logic [46:0] z5, z4, z3, z2, z1, z0; 
logic [5:0] zeros;
logic [46:0] frac0; 
logic [9:0] exp0; 
logic [9:0] diff_cmp;
logic exp_gt_zeros;
logic exp_not_zero;
logic [9:0] shift_left_amt;
logic [9:0] shift_right_amt;
logic [46:0] l_stage0, l_stage1, l_stage2, l_stage3, l_stage4, frac_left_shifted;
logic [46:0] r_stage0, r_stage1, r_stage2, r_stage3, r_stage4, frac_right_shifted;
logic [26:0] frac;
logic frac_plus_1;
logic [24:0] frac_round;
logic [9:0] exp1;
logic over_exp0;
logic over_exp1;
logic overflow;

assign zeros[5] = ~|i_z[46:15]; 
always @(*) begin
   if (zeros[5])
      z5 = {i_z[14:0], 32'b0};
   else
      z5 = i_z[46:0];
end

assign zeros[4] = ~|z5[46:31]; 
always @(*) begin
   if (zeros[4])
      z4 = {z5[30:0], 16'b0};
   else
      z4 = z5;
end

assign zeros[3] = ~|z4[46:39]; 
always @(*) begin
   if (zeros[3])
      z3 = {z4[38:0], 8'b0};
   else
      z3 = z4;
end

assign zeros[2] = ~|z3[46:43]; 
always @(*) begin
   if (zeros[2])
      z2 = {z3[42:0], 4'b0};
   else
      z2 = z3;
end

assign zeros[1] = ~|z2[46:45]; 
always @(*) begin
   if (zeros[1])
      z1 = {z2[44:0], 2'b0};
   else
      z1 = z2;
end

assign zeros[0] = ~z1[46]; 
always @(*) begin
   if (zeros[0])
      z0 = {z1[45:0], 1'b0};
   else
      z0 = z1;
end

assign diff_cmp = {1'b0, i_exp10[8:0]} - {1'b0, zeros};
assign exp_gt_zeros = (~diff_cmp[9]) & (|diff_cmp[8:0]);
assign exp_not_zero = |i_exp10;

assign shift_left_amt  = i_exp10 - 10'h1;
assign shift_right_amt = 10'h1 - i_exp10;

always @(*) begin
    if (shift_left_amt[0]) l_stage0 = {i_z[45:0], 1'b0};
    else                   l_stage0 = i_z[46:0];
    if (shift_left_amt[1]) l_stage1 = {l_stage0[44:0], 2'b0};
    else                   l_stage1 = l_stage0;
    if (shift_left_amt[2]) l_stage2 = {l_stage1[42:0], 4'b0};
    else                   l_stage2 = l_stage1;
    if (shift_left_amt[3]) l_stage3 = {l_stage2[38:0], 8'b0};
    else                   l_stage3 = l_stage2;
    if (shift_left_amt[4]) l_stage4 = {l_stage3[30:0], 16'b0};
    else                   l_stage4 = l_stage3;
    if (shift_left_amt[5]) frac_left_shifted = {l_stage4[14:0], 32'b0};
    else                   frac_left_shifted = l_stage4;

    if (shift_right_amt[0]) r_stage0 = {1'b0, i_z[46:1]};
    else                    r_stage0 = i_z[46:0];
    if (shift_right_amt[1]) r_stage1 = {2'b0, r_stage0[46:2]};
    else                    r_stage1 = r_stage0;
    if (shift_right_amt[2]) r_stage2 = {4'b0, r_stage1[46:4]};
    else                    r_stage2 = r_stage1;
    if (shift_right_amt[3]) r_stage3 = {8'b0, r_stage2[46:8]};
    else                    r_stage3 = r_stage2;
    if (shift_right_amt[4]) r_stage4 = {16'b0, r_stage3[46:16]};
    else                    r_stage4 = r_stage3;
    if (shift_right_amt[5]) frac_right_shifted = {32'b0, r_stage4[46:32]};
    else                    frac_right_shifted = r_stage4;

    if (i_z[47]) begin 
        exp0  = i_exp10 + 10'h1;
        frac0 = i_z[47:1]; 
    end else begin
        if (!i_exp10[9] && exp_gt_zeros && z0[46]) begin
            exp0  = i_exp10 - {1'b0, zeros}; 
            frac0 = z0; 
        end else begin
            exp0 = 10'h0;
            if (!i_exp10[9] && exp_not_zero) begin 
                frac0 = frac_left_shifted; 
            end else begin 
                frac0 = frac_right_shifted; 
            end
        end
    end
end

assign frac[26:0] = {frac0[46:21], |frac0[20:0]}; 
assign frac_plus_1 = ~i_rm[1] & ~i_rm[0] & frac0[2] & (frac0[1] | frac0[0]) |
                     ~i_rm[1] & ~i_rm[0] & frac0[2] & ~frac0[1] & ~frac0[0] & frac0[3] |
                     ~i_rm[1] &  i_rm[0] & (frac0[2] | frac0[1] | frac0[0]) & i_sign |
                      i_rm[1] & ~i_rm[0] & (frac0[2] | frac0[1] | frac0[0]) & ~i_sign;

assign frac_round[24:0] = {1'b0,frac[26:3]} + frac_plus_1;

always @(*) begin
   if (frac_round[24])
      exp1 = exp0 + 10'h1;
   else
      exp1 = exp0;
end

assign over_exp0 = exp0[9] | exp0[8] | (&exp0[7:0]);
assign over_exp1 = exp1[9] | exp1[8] | (&exp1[7:0]);
assign overflow  = over_exp0 | over_exp1; 

always @(*) begin
    casez ({overflow, i_rm, i_sign, i_is_nan, i_is_inf})
        6'b1_00_?_0_? : o_s = {i_sign, 8'hff, 23'h000000}; 
        6'b1_01_0_0_? : o_s = {i_sign, 8'hfe, 23'h7fffff}; 
        6'b1_01_1_0_? : o_s = {i_sign, 8'hff, 23'h000000}; 
        6'b1_10_0_0_? : o_s = {i_sign, 8'hff, 23'h000000}; 
        6'b1_10_1_0_? : o_s = {i_sign, 8'hfe, 23'h7fffff}; 
        6'b1_11_?_0_? : o_s = {i_sign, 8'hfe, 23'h7fffff}; 
        6'b0_??_?_0_0 : o_s = {i_sign, exp1[7:0], frac_round[22:0]}; 
        6'b?_??_?_1_? : o_s = {1'b1, 8'hff, i_inf_nan_frac}; 
        6'b?_??_?_0_1 : o_s = {i_sign, 8'hff, i_inf_nan_frac}; 
        default       : o_s = {i_sign, 8'h00, 23'h000000}; 
    endcase
end
          
endmodule