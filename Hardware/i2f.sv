module i2f (
	input  logic [31:0] i_d,
	
	output logic [31:0] o_a,
	output logic 		  o_p_lost
);

logic sign;
logic [31:0] f5;
logic [31:0] f4, f3, f2, f1, f0;
logic [4:0] sa; // shift amount
logic [22:0] fraction;
logic [7:0] exponent;
logic is_zero;

assign sign = i_d[31];

always @(*) begin
	if (sign)
		f5 = -i_d;
	else
		f5 = i_d;
end

assign sa[4] = ~|f5[31:16];
always @(*) begin
	if (sa[4])
		f4 = {f5[15:0], 16'b0};
	else
		f4 = f5;
end

assign sa[3] = ~|f4[31:24];
always @(*) begin
	if (sa[3])
		f3 = {f4[23:0], 8'b0};
	else 
		f3 = f4;
end

assign sa[2] = ~|f3[31:28];
always @(*) begin
	if (sa[2])
		f2 = {f3[27:0], 4'b0};
	else 
		f2 = f3;
end

assign sa[1] = ~|f2[31:30];
always @(*) begin
	if (sa[1])
		f1 = {f2[29:0], 2'b0};
	else 
		f1 = f2;
end

assign sa[0] = ~f1[31];
always @(*) begin
	if (sa[0])
		f0 = {f1[30:0], 1'b0};
	else 
		f0 = f1;
end

assign o_p_lost = |f0[7:0];
assign fraction = f0[30:8];
assign exponent = 8'h9e - {3'h0, sa};
assign is_zero = ~(|i_d);

always @(*) begin
	if (is_zero)
		o_a = 32'b0;
	else
		o_a = {sign, exponent, fraction};
end
	
endmodule