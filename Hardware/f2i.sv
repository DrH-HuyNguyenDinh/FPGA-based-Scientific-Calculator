module f2i (
    input  logic  [31:0] i_a,

    output logic [31:0] o_d,
    output logic        o_p_lost,
    output logic        o_denorm,
    output logic        o_invalid
);

logic hidden_bit, frac_is_not_0, is_zero, sign;
logic signed [8:0] shift_right_bits;
logic [63:0] frac0, f_abs;
logic lost_bits;
logic [31:0] int32;
logic [8:0] diff_check;
logic is_shift_gt_32;
logic [63:0] stage0, stage1, stage2, stage3, stage4; 

assign hidden_bit    = |i_a[30:23];
assign frac_is_not_0 = |i_a[22:0];

assign o_denorm = ~hidden_bit &  frac_is_not_0;
assign is_zero =  ~hidden_bit & ~frac_is_not_0;

assign sign = i_a[31];
assign shift_right_bits = 9'd158 - {1'b0, i_a[30:23]};

assign frac0 = {8'h00, hidden_bit, i_a[22:0], 32'h0};

assign diff_check = 9'd32 - shift_right_bits;
assign is_shift_gt_32 = diff_check[8];

always @(*) begin
    if (is_shift_gt_32) begin
        f_abs = {32'd0, frac0[55:32]}; 
    end else begin
        if (shift_right_bits[0]) stage0 = {1'b0, frac0[63:1]};
        else                     stage0 = frac0;

        if (shift_right_bits[1]) stage1 = {2'b0, stage0[63:2]};
        else                     stage1 = stage0;

        if (shift_right_bits[2]) stage2 = {4'b0, stage1[63:4]};
        else                     stage2 = stage1;

        if (shift_right_bits[3]) stage3 = {8'b0, stage2[63:8]};
        else                     stage3 = stage2;

        if (shift_right_bits[4]) stage4 = {16'b0, stage3[63:16]};
        else                     stage4 = stage3;

        if (shift_right_bits[5]) f_abs = {32'b0, stage4[63:32]};
        else                     f_abs = stage4;
    end
end

assign lost_bits = |f_abs[23:0];

always @(*) begin
    if (sign) begin
        int32 = -f_abs[55:24];
    end else begin
        int32 = f_abs[55:24];
    end
end

always @(*) begin
    if (o_denorm) begin
        o_p_lost = 1;
        o_invalid = 0;
        o_d = 32'h0;
    end else begin
        if (shift_right_bits[8]) begin
            o_p_lost = 0;
            o_invalid = 1;
            o_d = 32'h80000000;
        end else begin
            if (shift_right_bits[7:0] > 8'h1f) begin
                if (is_zero) o_p_lost = 0;
                else         o_p_lost = 1;
                o_invalid = 0;
                o_d = 32'h0;
            end else begin
                if (sign != int32[31]) begin
                    o_p_lost = 0;
                    o_invalid = 1;
                    o_d = 32'h80000000;
                end else begin
                    if (lost_bits) o_p_lost = 1;
                    else           o_p_lost = 0;
                    o_invalid = 0;
                    o_d = int32;
                end
            end
        end
    end
end

endmodule