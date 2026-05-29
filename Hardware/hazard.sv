module hazard (
   input logic [4:0] i_rs1_addr_execute, i_rs2_addr_execute,
   input logic [4:0] i_rd_addr_memory, i_rd_addr_writeback,
   
   input logic i_pc_sel, i_rd_wren_memory, i_rd_wren_writeback, i_out_loop, i_stall_fpu,
   input logic [2:0] i_wb_sel_execute,
   
   input logic i_rs1_is_float_execute, i_rs2_is_float_execute, 
   input logic i_fpu_rd_wren_memory, i_fpu_rd_wren_writeback,  
   
   output logic [1:0] o_foward_a_execution, o_foward_b_execution,
   output logic o_stall_fetch, o_stall_execute, o_stall_memory, o_stall_writeback,
   output logic o_stall_decode, o_flush_decode, 
   output logic o_flush_execute
);

always @(*) begin
   o_foward_a_execution = 2'b00; 
   
   if (~i_rs1_is_float_execute) begin 
 
       if (i_rs1_addr_execute != 5'd0) begin 
           if (i_rd_wren_memory && (i_rd_addr_memory == i_rs1_addr_execute))
               o_foward_a_execution = 2'b01; 
           else if (i_rd_wren_writeback && (i_rd_addr_writeback == i_rs1_addr_execute))
               o_foward_a_execution = 2'b10; 
       end
   end else begin 
       if (i_fpu_rd_wren_memory && (i_rd_addr_memory == i_rs1_addr_execute))
           o_foward_a_execution = 2'b01; 
       else if (i_fpu_rd_wren_writeback && (i_rd_addr_writeback == i_rs1_addr_execute))
           o_foward_a_execution = 2'b10; 
   end
end

always @(*) begin
   o_foward_b_execution = 2'b00; 
   
   if (~i_rs2_is_float_execute) begin 
   
       if (i_rs2_addr_execute != 5'd0) begin 
           if (i_rd_wren_memory && (i_rd_addr_memory == i_rs2_addr_execute))
               o_foward_b_execution = 2'b01;
           else if (i_rd_wren_writeback && (i_rd_addr_writeback == i_rs2_addr_execute))
               o_foward_b_execution = 2'b10;
       end
   end else begin 
       if (i_fpu_rd_wren_memory && (i_rd_addr_memory == i_rs2_addr_execute))
           o_foward_b_execution = 2'b01;
       else if (i_fpu_rd_wren_writeback && (i_rd_addr_writeback == i_rs2_addr_execute))
           o_foward_b_execution = 2'b10;
   end
end

assign o_stall_fetch     = i_wb_sel_execute[2] | i_stall_fpu;
assign o_stall_decode    = i_wb_sel_execute[2] | i_stall_fpu;
assign o_stall_execute   = i_stall_fpu;
assign o_stall_memory    = i_stall_fpu;
assign o_stall_writeback = i_stall_fpu;

assign o_flush_execute   = i_wb_sel_execute[2] | i_pc_sel | i_out_loop;
assign o_flush_decode    = i_pc_sel | i_out_loop;

endmodule