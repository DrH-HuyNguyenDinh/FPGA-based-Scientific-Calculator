module sig_gen (
   input  logic i_sign_y, i_sign_z,
   input  logic i_mode, i_t, // mode = 0: rotation mode
                             // mode = 1: vectoring mode
                             //    t = 1: circular coordinates system
                             //    t = 0: hyperbolic coordinates system
   
   output logic o_sel_y, o_sel_x
);

always @(*) begin
   if (i_mode)
      o_sel_y = ~i_sign_y;
   else
      o_sel_y = i_sign_z;
end

assign o_sel_x = o_sel_y ^ i_t;

endmodule

