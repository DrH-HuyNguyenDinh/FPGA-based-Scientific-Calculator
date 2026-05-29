module fadder (
	input  logic [31:0] i_a, i_b,
	input  logic [ 1:0] i_rm,		// round mode
	input  logic 		  i_sub,		// 1: sub; 0: add
	
	output logic [31:0] o_s
);

logic [31:0] diff;
logic exchange;
logic [31:0] fp_large, fp_small;
logic fp_large_hidden_bit, fp_small_hidden_bit;
logic [23:0] large_frac24, small_frac24;
logic [7:0] temp_exp;
logic sign, op_sub;
logic fp_large_expo_is_ff, fp_small_expo_is_ff;
logic fp_large_frac_is_00, fp_small_frac_is_00;
logic fp_large_is_inf, fp_small_is_inf;
logic fp_large_is_nan, fp_small_is_nan;
logic s_is_inf, s_is_nan;
logic [23:0] diff_frac;
logic [22:0] nan_frac, inf_nan_frac;
logic [7:0] exp_diff;
logic small_den_only;
logic [7:0] shift_amount;
logic [8:0] diff_25;
logic [49:0] small_frac50;
logic [26:0] small_frac27;
logic [27:0] aligned_large_frac, aligned_small_frac;
logic [49:0] stage0, stage1, stage2, stage3, stage4;
logic [27:0] cal_frac;
logic [26:0] f4, f3, f2, f1, f0;
logic [4:0] zeros;
logic [7:0] exp0;
logic [26:0] frac0;
logic [8:0] diff_zeros_exp;
logic exp_gt_zeros;
logic [7:0] shift_left_amt;
logic [26:0] l_stage0, l_stage1, l_stage2, l_stage3;
logic [26:0] frac_shifted;
logic frac_plus_1;
logic [24:0] frac_round;
logic [7:0] exponent;
logic overflow;

assign diff[31:0] = {1'b0, i_a[30:0]} - {1'b0, i_b[30:0]};
assign exchange = diff[31];

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

assign large_frac24[23:0] = {fp_large_hidden_bit,fp_large[22:0]};
assign small_frac24[23:0] = {fp_small_hidden_bit,fp_small[22:0]};
assign temp_exp[7:0] = fp_large[30:23];

always @(*) begin
    if (exchange) begin
        sign = i_sub ^ i_b[31]; 
    end else begin
        sign = i_a[31];
    end
end

assign op_sub = i_sub ^ fp_large[31] ^ fp_small[31];

assign fp_large_expo_is_ff =  &fp_large[30:23]; // exp == 0xff
assign fp_small_expo_is_ff =  &fp_small[30:23];
assign fp_large_frac_is_00 = ~|fp_large[22:0]; 	// frac == 0x0
assign fp_small_frac_is_00 = ~|fp_small[22:0];

assign fp_large_is_inf = fp_large_expo_is_ff &  fp_large_frac_is_00;
assign fp_small_is_inf = fp_small_expo_is_ff &  fp_small_frac_is_00;
assign fp_large_is_nan = fp_large_expo_is_ff & ~fp_large_frac_is_00;
assign fp_small_is_nan = fp_small_expo_is_ff & ~fp_small_frac_is_00;

assign s_is_inf = fp_large_is_inf | fp_small_is_inf;
assign s_is_nan = fp_large_is_nan | fp_small_is_nan | 
						((i_sub ^ fp_small[31] ^ fp_large[31]) & 
						fp_large_is_inf & fp_small_is_inf);
						
assign diff_frac[23:0] = {1'b0, i_b[22:0]} - {1'b0, i_a[22:0]};
always @(*) begin
    if (diff_frac[23]) begin
        nan_frac = {1'b1, i_a[21:0]};
    end else begin
        nan_frac = {1'b1, i_b[21:0]};
    end
end

always @(*) begin
    if (s_is_nan) begin
        inf_nan_frac = nan_frac;
    end else begin
        inf_nan_frac = 23'h0;
    end
end

assign exp_diff[7:0] = fp_large[30:23] - fp_small[30:23];

assign small_den_only = (|fp_large[30:23]) & (~|fp_small[30:23]);

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
        if (shift_amount[0]) 
            stage1 = {1'b0, stage0[49:1]};
        else                 
            stage1 = stage0;
        if (shift_amount[1]) 
            stage2 = {2'b0, stage1[49:2]};
        else                 
            stage2 = stage1;
        if (shift_amount[2]) 
            stage3 = {4'b0, stage2[49:4]};
        else                 
            stage3 = stage2;
        if (shift_amount[3]) 
            stage4 = {8'b0, stage3[49:8]};
        else                 
            stage4 = stage3;
        if (shift_amount[4]) 
            small_frac50 = {16'b0, stage4[49:16]};
        else                 
            small_frac50 = stage4;
    end
end

assign small_frac27[26:0] = {small_frac50[49:24], |small_frac50[23:0]};

assign aligned_large_frac[27:0] = {1'b0, large_frac24, 3'b0};
assign aligned_small_frac[27:0] = {1'b0, small_frac27};

always @(*) begin
    if (op_sub) begin
        cal_frac = aligned_large_frac - aligned_small_frac;
    end else begin
        cal_frac = aligned_large_frac + aligned_small_frac;
    end
end

assign zeros[4] = ~|cal_frac[26:11];	// 16-bit 0
always @(*) begin
    if (zeros[4]) begin
        f4 = {cal_frac[10:0], 16'b0};
    end else begin
        f4 = cal_frac[26:0];
    end
end

assign zeros[3] = ~|f4[26:19]; // 8-bit 0
always @(*) begin
    if (zeros[3]) begin
        f3 = {f4[18:0], 8'b0};
    end else begin
        f3 = f4;
    end
end
assign zeros[2] = ~|f3[26:23]; // 4-bit 0
always @(*) begin
    if (zeros[2]) begin
        f2 = {f3[22:0], 4'b0};
    end else begin
        f2 = f3;
    end
end

assign zeros[1] = ~|f2[26:25]; // 2-bit 0
always @(*) begin
    if (zeros[1]) begin
        f1 = {f2[24:0], 2'b0};
    end else begin
        f1 = f2;
    end
end

assign zeros[0] = ~f1[26]; // 1-bit 0
always @(*) begin
    if (zeros[0]) begin
        f0 = {f1[25:0], 1'b0};
    end else begin
        f0 = f1;
    end
end

assign diff_zeros_exp[8:0] = {4'b0, zeros} - {1'b0, temp_exp};
assign exp_gt_zeros = diff_zeros_exp[8];

assign shift_left_amt[7:0] = temp_exp - 8'h1;

always @(*) begin
    if (shift_left_amt[0]) l_stage0 = {cal_frac[25:0], 1'b0};
    else                   l_stage0 = cal_frac[26:0];

    if (shift_left_amt[1]) l_stage1 = {l_stage0[24:0], 2'b0};
    else                   l_stage1 = l_stage0;

    if (shift_left_amt[2]) l_stage2 = {l_stage1[22:0], 4'b0};
    else                   l_stage2 = l_stage1;

    if (shift_left_amt[3]) l_stage3 = {l_stage2[18:0], 8'b0};
    else                   l_stage3 = l_stage2;

    if (shift_left_amt[4]) frac_shifted = {l_stage3[10:0], 16'b0};
    else                   frac_shifted = l_stage3;

    if (cal_frac[27]) begin 
        frac0 = cal_frac[27:1]; 
        exp0 = temp_exp + 8'h1;
    end else begin
        if (exp_gt_zeros && f0[26]) begin 
            exp0 = temp_exp - {3'b0, zeros}; 
            frac0 = f0; 
        end else begin 
            exp0 = 8'h0; 
            
            if (|temp_exp) begin
                frac0 = frac_shifted;
            end else begin
                frac0 = cal_frac[26:0];
            end
        end
    end
end
							 
assign frac_plus_1 = (~i_rm[1] & ~i_rm[0] &  frac0[2] & (frac0[1] |  frac0[0])) |
                     (~i_rm[1] & ~i_rm[0] &  frac0[2] & ~frac0[1] & ~frac0[0]  & frac0[3]) |
                     (~i_rm[1] &  i_rm[0] & (frac0[2] |  frac0[1] |  frac0[0]) & sign) |
                     ( i_rm[1] & ~i_rm[0] & (frac0[2] |  frac0[1] |  frac0[0]) & ~sign);
						  
assign frac_round[24:0] = {1'b0,frac0[26:3]} + frac_plus_1;

always @(*) begin
    if (frac_round[24]) begin
        exponent = exp0 + 8'h1;
    end else begin
        exponent = exp0;
    end
end

assign overflow = &exp0 | &exponent;

always @(*) begin
    casex ({overflow, i_rm, sign, s_is_nan, s_is_inf})
        6'b1_00_?_0_? : o_s = {sign, 8'hFF, 23'h000000}; 

        6'b1_01_0_0_? : o_s = {sign, 8'hFE, 23'h7FFFFF}; 
        6'b1_01_1_0_? : o_s = {sign, 8'hFF, 23'h000000}; 

        6'b1_10_0_0_? : o_s = {sign, 8'hFF, 23'h000000}; 
        6'b1_10_1_0_? : o_s = {sign, 8'hFE, 23'h7FFFFF}; 

        6'b1_11_?_0_? : o_s = {sign, 8'hFE, 23'h7FFFFF}; 

        6'b0_??_?_0_0 : o_s = {sign, exponent, frac_round[22:0]}; 

        6'b?_??_?_1_? : o_s = {1'b1, 8'hFF, inf_nan_frac}; 

        6'b?_??_?_0_1 : o_s = {sign, 8'hFF, inf_nan_frac}; 

        default       : o_s = {sign, 8'h00, 23'h000000}; 
        
    endcase
end
endmodule
