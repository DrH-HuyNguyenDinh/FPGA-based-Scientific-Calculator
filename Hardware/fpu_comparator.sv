module fpu_comparator (
    input  logic [31:0] i_a, i_b,
    output logic        o_eq,  // A == B
    output logic        o_lt,  // A < B
    output logic        o_le   // A <= B
);

logic sign_a, sign_b;
logic [30:0] mag_a, mag_b;
logic is_zero_a, is_zero_b, both_zero;
logic is_nan_a, is_nan_b, has_nan;

assign sign_a = i_a[31];
assign sign_b = i_b[31];
assign mag_a  = i_a[30:0];
assign mag_b  = i_b[30:0];

assign is_zero_a = (mag_a == 31'b0);
assign is_zero_b = (mag_b == 31'b0);
assign both_zero = is_zero_a & is_zero_b; 

assign is_nan_a = (&i_a[30:23]) & (|i_a[22:0]); 
assign is_nan_b = (&i_b[30:23]) & (|i_b[22:0]);
assign has_nan  = is_nan_a | is_nan_b;

always @(*) begin
	if (has_nan) begin
		o_eq = 1'b0;
		o_lt = 1'b0;
		o_le = 1'b0;
	end else if (both_zero) begin
		o_eq = 1'b1;
		o_lt = 1'b0;
		o_le = 1'b1;
	end else if (sign_a != sign_b) begin
		o_eq = 1'b0;
		o_lt = sign_a; 
		o_le = sign_a;
	end else begin
		if (sign_a == 1'b0) begin
			 o_eq = (mag_a == mag_b);
			 o_lt = (mag_a <  mag_b);
			 o_le = (mag_a <= mag_b);
		end else begin
			 o_eq = (mag_a == mag_b);
			 o_lt = (mag_a >  mag_b); 
			 o_le = (mag_a >= mag_b);
		end
	end
end

endmodule