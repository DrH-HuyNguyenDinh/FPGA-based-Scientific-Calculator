module fmul (
   input  logic [31:0] i_a, i_b,  // fp a and b
   input  logic [ 1:0] i_rm,      // round mode
   output logic [31:0] o_s        // fp output
);

// ==========================================
// 1. DECODE & EXCEPTION LOGIC
// ==========================================
logic a_expo_is_00, b_expo_is_00;
logic a_expo_is_ff, b_expo_is_ff;
logic a_frac_is_00, b_frac_is_00;
logic a_is_inf, b_is_inf;
logic a_is_nan, b_is_nan;
logic a_is_0, b_is_0;
logic s_is_inf, s_is_nan;

assign a_expo_is_00 = ~|i_a[30:23]; 
assign b_expo_is_00 = ~|i_b[30:23];
assign a_expo_is_ff =  &i_a[30:23]; 
assign b_expo_is_ff =  &i_b[30:23];
assign a_frac_is_00 = ~|i_a[22:0];  
assign b_frac_is_00 = ~|i_b[22:0];

assign a_is_inf = a_expo_is_ff & a_frac_is_00;
assign b_is_inf = b_expo_is_ff & b_frac_is_00;
assign a_is_nan = a_expo_is_ff & ~a_frac_is_00;
assign b_is_nan = b_expo_is_ff & ~b_frac_is_00;
assign a_is_0   = a_expo_is_00 & a_frac_is_00;
assign b_is_0   = b_expo_is_00 & b_frac_is_00;

assign s_is_inf = a_is_inf | b_is_inf;
assign s_is_nan = a_is_nan | (a_is_inf & b_is_0) | b_is_nan | (b_is_inf & a_is_0);

// Thay thế "a[21:0] > b[21:0]" bằng phép trừ để kiểm tra bit dấu
logic [22:0] diff_ab;
logic [22:0] nan_frac;
logic [22:0] inf_nan_frac;

assign diff_ab = {1'b0, i_a[21:0]} - {1'b0, i_b[21:0]};

always @(*) begin
   // Nếu diff_ab âm (MSB=1), tức là a < b
   if (diff_ab[22]) begin
      nan_frac = {1'b1, i_b[21:0]};
   end else begin
      nan_frac = {1'b1, i_a[21:0]};
   end

   // Xử lý fraction cho trường hợp NaN
   if (s_is_nan) begin
      inf_nan_frac = nan_frac;
   end else begin
      inf_nan_frac = 23'h0;
   end
end

logic sign;
assign sign = i_a[31] ^ i_b[31];

logic [9:0] exp10;
assign exp10 = {2'h0, i_a[30:23]} + {2'h0, i_b[30:23]} - 10'h7f + 
               {9'b0, a_expo_is_00} + {9'b0, b_expo_is_00}; 

// ==========================================
// 2. MULTIPLICATION (Dùng toán tử '*' để gọi DSP)
// ==========================================
logic [23:0] a_frac24, b_frac24;
logic [47:0] z;

assign a_frac24 = {~a_expo_is_00, i_a[22:0]};
assign b_frac24 = {~b_expo_is_00, i_b[22:0]};

assign z = a_frac24 * b_frac24; // xx.xxxxxxxxxxxx...

// ==========================================
// 3. NORMALIZATION ZERO COUNTER
// ==========================================
logic [46:0] z5, z4, z3, z2, z1, z0; 
logic [ 5:0] zeros;

assign zeros[5] = ~|z[46:15]; 
assign zeros[4] = ~|z5[46:31]; 
assign zeros[3] = ~|z4[46:39]; 
assign zeros[2] = ~|z3[46:43]; 
assign zeros[1] = ~|z2[46:45]; 
assign zeros[0] = ~z1[46]; 

always @(*) begin
   if (zeros[5]) z5 = {z[14:0], 32'b0};
   else          z5 = z[46:0];

   if (zeros[4]) z4 = {z5[30:0], 16'b0};
   else          z4 = z5;

   if (zeros[3]) z3 = {z4[38:0],  8'b0};
   else          z3 = z4;

   if (zeros[2]) z2 = {z3[42:0],  4'b0};
   else          z2 = z3;

   if (zeros[1]) z1 = {z2[44:0],  2'b0};
   else          z1 = z2;

   if (zeros[0]) z0 = {z1[45:0],  1'b0};
   else          z0 = z1;
end

// Thay thế (exp10 > zeros) bằng phép trừ
logic [9:0] diff_exp_zeros;
logic       exp10_gt_zeros;
logic       exp10_not_zero;

assign diff_exp_zeros = {1'b0, exp10[8:0]} - {4'b0, zeros};
assign exp10_gt_zeros = (~diff_exp_zeros[9]) & (|diff_exp_zeros[8:0]);
assign exp10_not_zero = |exp10;

// ==========================================
// 4. BARREL SHIFTERS (Thay thế >> và <<)
// ==========================================
logic [9:0] shift_left_amt;
logic [9:0] shift_right_amt;
logic [46:0] l_stage0, l_stage1, l_stage2, l_stage3, l_stage4, frac_left_shifted;
logic [46:0] r_stage0, r_stage1, r_stage2, r_stage3, r_stage4, frac_right_shifted;

assign shift_left_amt  = exp10 - 10'h1;
assign shift_right_amt = 10'h1 - exp10;

always @(*) begin
   // Left Shifter
   if (shift_left_amt[0]) l_stage0 = {z[45:0], 1'b0};
   else                   l_stage0 = z[46:0];
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

   // Right Shifter
   if (shift_right_amt[0]) r_stage0 = {1'b0, z[46:1]};
   else                    r_stage0 = z[46:0];
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
end

// ==========================================
// 5. EXPONENT & FRACTION ADJUSTMENT
// ==========================================
logic [46:0] frac0; 
logic [ 9:0] exp0;  

always @(*) begin
   if (z[47]) begin 
      exp0  = exp10 + 10'h1;
      frac0 = z[47:1]; 
   end else begin
      if (~exp10[9] && exp10_gt_zeros && z0[46]) begin
         exp0  = exp10 - {4'b0, zeros};
         frac0 = z0; 
      end else begin 
         exp0 = 10'h0;
         if (~exp10[9] && exp10_not_zero) begin 
            frac0 = frac_left_shifted; 
         end else begin 
            frac0 = frac_right_shifted; 
         end
      end
   end
end

// ==========================================
// 6. ROUNDING
// ==========================================
logic [26:0] frac;
logic        frac_plus_1;
logic [24:0] frac_round;
logic [ 9:0] exp1;

assign frac = {frac0[46:21], |frac0[20:0]}; // x.xx...xx grs

assign frac_plus_1 = 
   ~i_rm[1] & ~i_rm[0] & frac0[2] & (frac0[1] | frac0[0]) |
   ~i_rm[1] & ~i_rm[0] & frac0[2] & ~frac0[1] & ~frac0[0] & frac0[3] |
   ~i_rm[1] &  i_rm[0] & (frac0[2] | frac0[1] | frac0[0]) & sign |
    i_rm[1] & ~i_rm[0] & (frac0[2] | frac0[1] | frac0[0]) & ~sign;

assign frac_round = {1'b0, frac[26:3]} + frac_plus_1;

always @(*) begin
   if (frac_round[24]) begin
      exp1 = exp0 + 10'h1;
   end else begin
      exp1 = exp0;
   end
end

// ==========================================
// 7. EXCEPTION & FINAL RESULT
// ==========================================
logic over_exp0, over_exp1, overflow;
logic [31:0] pre_result;

// Thay thế >= 10'h0ff bằng logic bitwise
assign over_exp0 = exp0[9] | exp0[8] | (&exp0[7:0]);
assign over_exp1 = exp1[9] | exp1[8] | (&exp1[7:0]);
assign overflow  = over_exp0 | over_exp1;

always @(*) begin
   casez ({overflow, i_rm, sign, s_is_nan, s_is_inf})
      6'b1_00_?_0_? : pre_result = {sign, 8'hff, 23'h000000}; // inf
      6'b1_01_0_0_? : pre_result = {sign, 8'hfe, 23'h7fffff}; // max
      6'b1_01_1_0_? : pre_result = {sign, 8'hff, 23'h000000}; // inf
      6'b1_10_0_0_? : pre_result = {sign, 8'hff, 23'h000000}; // inf
      6'b1_10_1_0_? : pre_result = {sign, 8'hfe, 23'h7fffff}; // max
      6'b1_11_?_0_? : pre_result = {sign, 8'hfe, 23'h7fffff}; // max
      6'b0_??_?_0_0 : pre_result = {sign, exp1[7:0], frac_round[22:0]}; // nor
      6'b?_??_?_1_? : pre_result = {1'b1, 8'hff, inf_nan_frac}; // nan
      6'b?_??_?_0_1 : pre_result = {sign, 8'hff, inf_nan_frac}; // inf
      default       : pre_result = {sign, 8'h00, 23'h000000}; // 0
   endcase
end

assign o_s = pre_result;

endmodule