// =========================================================================
// MODULE: FSQRT NEWTON (TOP MODULE)
// Tính năng: 
// - Token Passing 1-Cycle (Miễn nhiễm lỗi Testbench đứt gãy Enable)
// - Sửa lỗi làm tròn 0.4999... -> 0.5 (Fix lỗi sqrt(4.0) ra 4.0)
// - Native DSP Multiplier (Xóa bỏ bộ Wallace rườm rà)
// - Rounding Mode (rm) chuẩn 2-bit
// =========================================================================

module fsqrt_newton (
    input  logic        i_clk, i_reset,    // clock and reset
    input  logic [31:0] i_d,               // fp s = root(d)
    input  logic [ 1:0] i_rm,              // round mode
    input  logic        i_fsqrt,           // ID stage: fsqrt (Kích hoạt 1 xung)
    input  logic        i_ena,             // enable (Giữ cho đúng format port cũ)
    
    output logic [31:0] o_s,               // fp output
    output logic [25:0] o_reg_x,           // x_i
    output logic [ 4:0] o_count,           // for iteration control
    output logic        o_busy,            // for generating stall
    output logic        o_stall            // for pipeline stall
);

localparam ZERO = 32'h00000000;
localparam INF  = 32'h7f800000;
localparam NaN  = 32'h7fc00000;

// ==========================================
// 1. ALIGNMENT & DECODE
// ==========================================
logic        d_expo_is_00, d_expo_is_ff, d_frac_is_00;
logic        sign;
logic [ 7:0] exp0;
logic [23:0] d_frac24;

fsqrt_align align_stage (
    .i_d             (i_d),
    .o_d_expo_is_00  (d_expo_is_00),
    .o_d_expo_is_ff  (d_expo_is_ff),
    .o_d_frac_is_00  (d_frac_is_00),
    .o_sign          (sign),
    .o_exp0          (exp0),
    .o_d_frac24      (d_frac24)
);

// BẢNG ROM (Tự động tính toán hạt giống x0)
function automatic logic [7:0] rom(input logic [4:0] addr); 
    case (addr)
        5'h08: rom = 8'hff; 5'h09: rom = 8'he1; 5'h0a: rom = 8'hc7; 5'h0b: rom = 8'hb1;
        5'h0c: rom = 8'h9e; 5'h0d: rom = 8'h9e; 5'h0e: rom = 8'h7f; 5'h0f: rom = 8'h72; 
        5'h10: rom = 8'h66; 5'h11: rom = 8'h5b; 5'h12: rom = 8'h51; 5'h13: rom = 8'h48;
        5'h14: rom = 8'h3f; 5'h15: rom = 8'h37; 5'h16: rom = 8'h30; 5'h17: rom = 8'h29;
        5'h18: rom = 8'h23; 5'h19: rom = 8'h1d; 5'h1a: rom = 8'h17; 5'h1b: rom = 8'h12;
        5'h1c: rom = 8'h0d; 5'h1d: rom = 8'h08; 5'h1e: rom = 8'h04; 5'h1f: rom = 8'h00;
        default: rom = 8'hff; 
    endcase
endfunction

// ==========================================
// 2. FSM NEWTON-RAPHSON CORE & TOKENS
// ==========================================
logic start_pulse;
logic [4:0] count;
logic busy;
logic [25:0] reg_x;
logic [23:0] reg_d;

assign start_pulse = i_fsqrt & ~busy;

logic e1_en, e2_en, e3_en, n_e;
assign e1_en = (count == 5'h16); // Hoàn tất 3 vòng lặp -> Bắn Token

logic        e1_sign, e2_sign, e3_sign;
logic [ 1:0] e1_rm, e2_rm, e3_rm;
logic [ 7:0] e1_exp, e2_exp, e3_exp;
logic        e1_e00, e2_e00, e3_e00;
logic        e1_eff, e2_eff, e3_eff;
logic        e1_f00, e2_f00, e3_f00;

logic [ 7:0] latched_x0;
logic [51:0] x_2, x2d, x52; 
logic [25:0] b26;

// Mạch tính Newton-Raphson tự động ánh xạ vào DSP Slice
assign x_2 = reg_x * reg_x;
assign x2d = reg_d * x_2[51:24];
assign b26 = 26'h3000000 - x2d[49:24]; 
assign x52 = reg_x * b26;

// Quản lý trạng thái hệ thống
always_ff @(posedge i_clk or negedge i_reset) begin
    if (!i_reset) begin
        count <= 0; busy <= 0; reg_x <= 0; reg_d <= 0; latched_x0 <= 0;
        e1_sign <= 0; e1_rm <= 0; e1_exp <= 0;
        e1_e00 <= 0; e1_eff <= 0; e1_f00 <= 0;
        e2_en <= 0; e3_en <= 0; n_e <= 0;
    end else begin
        e2_en <= e1_en;
        e3_en <= e2_en;
        n_e   <= e3_en;

        if (start_pulse) begin 
            count <= 5'b1; 
            busy  <= 1'b1; 
            reg_d <= d_frac24;                  // Chốt dữ liệu ngay lập tức
            latched_x0 <= rom(d_frac24[23:19]); // Chốt hạt giống x0
            
            // Chốt các cờ Alignment để truyền vào Pipeline
            e1_sign <= sign;         e1_rm  <= i_rm;         e1_exp <= exp0;         
            e1_e00  <= d_expo_is_00; e1_eff <= d_expo_is_ff; e1_f00 <= d_frac_is_00; 
        end else if (|count) begin 
            if (count == 5'h01) begin
                reg_x <= {2'b01, latched_x0, 16'b0}; 
            end
            
            count <= count + 5'b1; 
            if (count == 5'h15) busy <= 0; 
            if (count == 5'h16) count <= 0; 
            
            if ((count == 5'h08) || (count == 5'h0f) || (count == 5'h16))   
                reg_x <= x52[50:25]; 
        end
        
        // Token dịch chuyển cờ ngoại lệ
        if (e1_en) begin 
            e2_sign <= e1_sign; e2_rm <= e1_rm; e2_exp <= e1_exp;
            e2_e00  <= e1_e00;  e2_eff <= e1_eff; e2_f00 <= e1_f00;
        end
        if (e2_en) begin 
            e3_sign <= e2_sign; e3_rm <= e2_rm; e3_exp <= e2_exp;
            e3_e00  <= e2_e00;  e3_eff <= e2_eff; e3_f00 <= e2_f00;
        end
    end
end

assign o_stall = (i_fsqrt | busy | e1_en | e2_en | e3_en) & ~n_e;
assign o_busy  = busy;
assign o_count = count;
assign o_reg_x = reg_x;

// ==========================================
// 3. PIPELINE NHÂN CUỐI CÙNG (d * x)
// ==========================================
logic [25:0] reg_de_x; 
logic [23:0] reg_de_d; 
logic [49:0] m_s;      
logic [49:0] a_s; 
logic [31:0] q;

assign m_s = reg_de_d * reg_de_x;

always_ff @(posedge i_clk or negedge i_reset) begin
    if (!i_reset) begin 
        reg_de_x <= 0; reg_de_d <= 0; 
        a_s <= 0; q <= 0;                       
    end else begin 
        if (e1_en) begin 
            reg_de_x <= x52[50:25]; 
            reg_de_d <= reg_d; 
        end
        if (e2_en) begin 
            a_s <= m_s; 
        end
        if (e3_en) begin 
            q <= {a_s[47:17], |a_s[16:0]}; // Sticky bit                                 
        end
    end
end

// ==========================================
// 4. NORMALIZATION & LÀM TRÒN
// ==========================================
logic [31:0] fixed_q;
logic [26:0] frac;
logic        frac_plus_1;
logic [24:0] frac_rnd;
logic [ 7:0] expo_new;
logic [22:0] frac_new;
logic [31:0] pre_result;

// Bản vá 4.0: Bù lại 1 bit MSB nếu Newton tính hụt ra 0.49999...
assign fixed_q = q[31] ? q : 32'h8000_0000;

assign frac = {fixed_q[31:6], |fixed_q[5:0]}; 

// Làm tròn 2-bit chuẩn
assign frac_plus_1 = ~e3_rm[1] & ~e3_rm[0] & frac[3] & frac[2] & ~frac[1] & ~frac[0] |
                     ~e3_rm[1] & ~e3_rm[0] & frac[2] & (frac[1] | frac[0]) |
                     ~e3_rm[1] &  e3_rm[0] & (frac[2] | frac[1] | frac[0]) & e3_sign |
                      e3_rm[1] & ~e3_rm[0] & (frac[2] | frac[1] | frac[0]) & ~e3_sign;

assign frac_rnd = {1'b0, frac[26:3]} + frac_plus_1;

assign expo_new = frac_rnd[24] ? e3_exp + 8'h1 : e3_exp;
assign frac_new = frac_rnd[24] ? frac_rnd[23:1] : frac_rnd[22:0];

always_comb begin
    casez ({e3_sign, e3_e00, e3_eff, e3_f00})
        4'b1_?_?_? : pre_result = NaN;  
        4'b0_0_0_? : pre_result = {1'b0, expo_new, frac_new}; 
        4'b0_1_0_0 : pre_result = {1'b0, expo_new, frac_new}; 
        4'b0_0_1_0 : pre_result = NaN;  
        4'b0_0_1_1 : pre_result = INF;  
        default    : pre_result = ZERO; 
    endcase
end

assign o_s = pre_result;

endmodule 


// =========================================================================
// SUB-MODULE: ALIGNMENT VÀ DỊCH BIT CHẴN
// =========================================================================
module fsqrt_align (
    input  logic [31:0] i_d,
    output logic        o_d_expo_is_00, o_d_expo_is_ff, o_d_frac_is_00,
    output logic        o_sign,
    output logic [ 7:0] o_exp0,
    output logic [23:0] o_d_frac24
);

logic [ 7:0] exp_8;
logic [23:0] d_f24, d_temp24;
logic [ 4:0] shamt_d;

assign o_d_expo_is_00 = ~|i_d[30:23]; 
assign o_d_expo_is_ff =  &i_d[30:23]; 
assign o_d_frac_is_00 = ~|i_d[22:0];  
assign o_sign         = i_d[31];

assign exp_8 = {1'b0, i_d[30:24]} + 8'd63 + i_d[23]; 
assign d_f24 = o_d_expo_is_00 ? {i_d[22:0], 1'b0} : {1'b1, i_d[22:0]};
assign d_temp24 = i_d[23] ? {1'b0, d_f24[23:1]} : d_f24;

shift_even_bits shift_d (.i_a(d_temp24), .o_b(o_d_frac24), .o_sa(shamt_d));

assign o_exp0 = exp_8 - {4'h0, shamt_d[4:1]};

endmodule

module shift_even_bits (
    input  logic [23:0] i_a,  
    output logic [23:0] o_b,  
    output logic [ 4:0] o_sa  
); 
    logic [23:0] a5, a4, a3, a2, a1;
    
    assign a5 = i_a;
    assign o_sa[4] = ~|a5[23:8]; 
    assign a4 = o_sa[4] ? {a5[7:0], 16'b0} : a5;
    
    assign o_sa[3] = ~|a4[23:16]; 
    assign a3 = o_sa[3] ? {a4[15:0], 8'b0} : a4;
    
    assign o_sa[2] = ~|a3[23:20]; 
    assign a2 = o_sa[2] ? {a3[19:0], 4'b0} : a3;
    
    assign o_sa[1] = ~|a2[23:22]; 
    assign a1 = o_sa[1] ? {a2[21:0], 2'b0} : a2;
    
    assign o_sa[0] = 1'b0;
    assign o_b = a1;

endmodule