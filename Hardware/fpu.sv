module fpu (
    input  logic        i_clk,
    input  logic        i_reset,
    
    input  logic        i_fpu_vld,  // 1 = FPU được kích hoạt
    input  logic [5:0]  i_fpu_op,   // Mã lệnh (0:Add, 1:Sub, 2:Mul, 3:Div, 4:Sqrt, 
                                    //          5:F2I, 6:I2F, 7:s(fs2), 8:-s(fs2), )
    input  logic [2:0]  i_rm,       // Chế độ làm tròn (Round Mode) lấy thẳng từ Lệnh

    input  logic [31:0] i_rs1_data, 
    input  logic [31:0] i_rs2_data,
	input  logic [31:0] i_integer_rs1,
    
    output logic [31:0] o_fpu_result_0, o_fpu_result_1, o_fpu_result_2,
    output logic        o_fpu_stall   
);

logic [31:0] res_add_sub, res_mul, res_div, res_sqrt, res_f2i, res_i2f, res_fmin, res_fmax;
logic o_eq, o_lt, o_le;

logic stall_add_sub, stall_mul, stall_div, stall_sqrt;

logic is_add, is_sub, en_add_sub;
assign is_add     = (i_fpu_op == 6'd0);
assign is_sub     = (i_fpu_op == 6'd1);
assign en_add_sub = i_fpu_vld & (is_add | is_sub);

// cordic 

fpu_comparator compare (
    .i_a (i_rs1_data),
    .i_b (i_rs2_data),
    .o_eq(o_eq),
    .o_lt(o_lt),
    .o_le(o_le)
);

pipelined_fadder u_fadder (
    .i_clk   (i_clk), 
    .i_reset (i_reset),
    .i_a     (i_rs1_data), 
    .i_b     (i_rs2_data), 
    .i_rm    (i_rm[1:0]),        // <--- Nối i_rm
    .i_sub   (is_sub),
    .i_e     (en_add_sub),  // <--- Cấp i_e để sinh o_stall
    .o_s     (res_add_sub),
    .o_stall (stall_add_sub)
);

logic en_mul;
assign en_mul = i_fpu_vld & (i_fpu_op == 6'd2);

pipelined_fmul u_fmul (
    .i_clk   (i_clk), 
    .i_reset (i_reset),
    .i_rm    (i_rm[1:0]),        // <--- Nối i_rm
    .i_e     (en_mul),      // <--- Cấp i_e để sinh o_stall
    .i_a     (i_rs1_data), 
    .i_b     (i_rs2_data),
    .o_s     (res_mul),
    .o_stall (stall_mul)
);

logic is_div;
assign is_div = (i_fpu_op == 6'd3);

fdiv_newton u_fdiv (
    .i_a      (i_rs1_data), 
    .i_b      (i_rs2_data),
    .i_rm     (i_rm[1:0]),       // <--- Nối i_rm
    .i_fdiv   (is_div),  
    .i_ena    (i_fpu_vld),
    .i_clk    (i_clk), 
    .i_reset  (i_reset),  
    .o_s      (res_div), 
    .o_stall  (stall_div)
);

logic is_sqrt;
assign is_sqrt = (i_fpu_op == 6'd4);

fsqrt_newton u_fsqrt (
    .i_d      (i_rs1_data), 
    .i_rm     (i_rm[1:0]),       // <--- Nối i_rm
    .i_fsqrt  (is_sqrt), 
    .i_ena    (i_fpu_vld),
    .i_clk    (i_clk), 
    .i_reset  (i_reset),  
    .o_s      (res_sqrt), 
    .o_stall  (stall_sqrt)
);

f2i u_f2i (
    .i_a       (i_rs1_data), // Float nạp vào rs1
    .o_d       (res_f2i)     // Int xuất ra
);

i2f u_i2f (
    .i_d       (i_rs1_data), // Int nạp vào rs1
    .o_a       (res_i2f)     // Float xuất ra
);

logic en_cordic;
assign en_cordic = i_fpu_vld & ((i_fpu_op == 6'd16) 
                              | (i_fpu_op == 6'd17) 
                              | (i_fpu_op == 6'd18) 
                              | (i_fpu_op == 6'd19) 
                              | (i_fpu_op == 6'd20));
logic mode, t;
logic stall_cordic;
logic [31:0] x, y, z;
logic [31:0] ox, oy, oz;

always @(*) begin
    case (i_fpu_op)
        6'd16, 6'd17: begin
            mode = 0;
            t    = 1;
            x    = 32'h3f800000;
            y    = 32'h0;
            z    = i_rs1_data;
        end

        6'd18, 6'd19: begin
            mode = 0;
            t    = 0;
            x    = 32'h3f800000;
            y    = 32'h0;
            z    = i_rs1_data;
        end

        6'd20: begin
            mode = 1;
            t    = 0;
            x    = 32'h3f800000;
            y    = i_rs1_data;
            z    = 32'h0;
        end

        default: begin
            mode = 0;
            t    = 0;
            x    = 32'h0;
            y    = 32'h0;
            z    = 32'h0;
        end
    endcase
end

cordic cordic (
    .i_clk   (i_clk),
    .i_reset (i_reset),
    .i_mode  (mode),
    .i_t     (t),
    .i_valid (en_cordic),
    .i_x     (x),
    .i_y     (y),
    .i_z     (z),

    .o_x     (ox),
    .o_y     (oy),
    .o_z     (oz),
    .o_stall (stall_cordic)
);

always @(*) begin
	if (o_lt)
		res_fmin = i_rs1_data;
	else
		res_fmin = i_rs2_data;
end

always @(*) begin
	if (o_lt)
		res_fmax = i_rs2_data;
	else
		res_fmax = i_rs1_data;
end

assign o_fpu_stall = stall_cordic | stall_add_sub | stall_mul | stall_div | stall_sqrt;

always @(*) begin
    if (i_fpu_vld & ~o_fpu_stall) begin
        case (i_fpu_op)
            6'd0, 6'd1: o_fpu_result_0 = res_add_sub;                                                // FADD, FSUB
            6'd2:       o_fpu_result_0 = res_mul;                                                    // FMUL
            6'd3:       o_fpu_result_0 = res_div;                                                    // FDIV
            6'd4:       o_fpu_result_0 = res_sqrt;                                                   // FSQRT
            6'd5:       o_fpu_result_0 = res_f2i;                                                    // fcvt.w.s
            6'd6:       o_fpu_result_0 = res_i2f;                                                    // fcvt.s.w
            6'd7:       o_fpu_result_0 = { i_rs2_data[31], i_rs1_data[30:0]};                        // fsgnj
            6'd8:       o_fpu_result_0 = {~i_rs2_data[31], i_rs1_data[30:0]};                        // fsgnjn
            6'd9:       o_fpu_result_0 = {(i_rs2_data[31] ^ i_rs1_data[31]), i_rs1_data[30:0]};      // fsgnjx
			6'd10: 		o_fpu_result_0 = res_fmin;													 // fmin
			6'd11: 		o_fpu_result_0 = res_fmax;													 // fmax
			6'd12: 		o_fpu_result_0 = {31'b0, o_eq};												 // feq
			6'd13: 		o_fpu_result_0 = {31'b0, o_lt};												 // flt
			6'd14: 		o_fpu_result_0 = {31'b0, o_le};												 // fle
			6'd15: 		o_fpu_result_0 = i_integer_rs1;												 // fmv.x.w
            6'd16:      o_fpu_result_0 = ox;                                                         // fcos
            6'd17:      o_fpu_result_0 = oy;                                                         // fsin
            6'd18:      o_fpu_result_0 = ox;                                                         // fcosh
            6'd19:      o_fpu_result_0 = oy;                                                         // fsinh
            6'd20:      o_fpu_result_0 = oz;                                                         // fatanh
            default:    o_fpu_result_0 = 32'b0;
        endcase
    end else begin
        o_fpu_result_0 = 32'b0;
    end
end

endmodule
