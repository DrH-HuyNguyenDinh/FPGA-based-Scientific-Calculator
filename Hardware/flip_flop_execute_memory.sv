module flip_flop_execute_memory (
   input logic         i_clk, i_reset,
   input logic  [31:0] i_pc_execute, i_pc_four_execute,
   input logic         i_rd_wren_execute, i_insn_vld_execute, i_mem_wren_execute,
   input logic  [2:0]  i_wb_sel_execute,
   input logic  [2:0]  i_sl_sel_execute, i_bmask_execute,
   input logic  [31:0] i_alu_data_execute,
   input logic  [4:0]  i_rd_addr_execute,
   input logic  [31:0] i_pre_opb_execute,
   input logic         i_ctrl_execute, i_stall_memory,
   input logic         i_fpu_rd_wren_execute, i_fpu_mem_wren_execute,
   input logic  [31:0] i_fpu_data_execute, i_f_operand_b_execute,
   
   output logic [31:0] o_pc_memory, o_pc_four_memory,
   output logic        o_rd_wren_memory, o_insn_vld_memory, o_mem_wren_memory,
   output logic [2:0]  o_wb_sel_memory,
   output logic [2:0]  o_sl_sel_memory, o_bmask_memory,
   output logic [31:0] o_alu_data_memory,
   output logic [4:0]  o_rd_addr_memory,
   output logic [31:0] o_pre_opb_memory,
   output logic        o_ctrl_memory,
   output logic        o_fpu_rd_wren_memory, o_fpu_mem_wren_memory,
   output logic [31:0] o_fpu_data_memory, o_f_operand_b_memory
);

always_ff @(posedge i_clk or negedge i_reset) begin
   if (~i_reset) begin
      o_pc_memory           <= 0;
      o_pc_four_memory      <= 0;
      o_rd_wren_memory      <= 0;
      o_insn_vld_memory     <= 0;
      o_mem_wren_memory     <= 0;
      o_wb_sel_memory       <= 0;
      o_sl_sel_memory       <= 0;
      o_bmask_memory        <= 0;
      o_alu_data_memory     <= 0;
      o_rd_addr_memory      <= 0;
      o_pre_opb_memory      <= 0;
      o_ctrl_memory         <= 0;
      o_fpu_rd_wren_memory  <= 0; 
      o_fpu_mem_wren_memory <= 0;
      o_fpu_data_memory     <= 0;
      o_f_operand_b_memory  <= 0;
   end else if (i_stall_memory) begin
      o_pc_memory           <= o_pc_memory;
      o_pc_four_memory      <= o_pc_four_memory;
      o_rd_wren_memory      <= o_rd_wren_memory;
      o_insn_vld_memory     <= o_insn_vld_memory;
      o_mem_wren_memory     <= o_mem_wren_memory;
      o_wb_sel_memory       <= o_wb_sel_memory;
      o_sl_sel_memory       <= o_sl_sel_memory;
      o_bmask_memory        <= o_bmask_memory;
      o_alu_data_memory     <= o_alu_data_memory;
      o_rd_addr_memory      <= o_rd_addr_memory;
      o_pre_opb_memory      <= o_pre_opb_memory;
      o_ctrl_memory         <= o_ctrl_memory;
      o_fpu_rd_wren_memory  <= o_fpu_rd_wren_memory; 
      o_fpu_mem_wren_memory <= o_fpu_mem_wren_memory;
      o_fpu_data_memory     <= o_fpu_data_memory;
      o_f_operand_b_memory  <= o_f_operand_b_memory;
   end else begin
      o_pc_memory           <= i_pc_execute;
      o_pc_four_memory      <= i_pc_four_execute;
      o_rd_wren_memory      <= i_rd_wren_execute;
      o_insn_vld_memory     <= i_insn_vld_execute;
      o_mem_wren_memory     <= i_mem_wren_execute;
      o_wb_sel_memory       <= i_wb_sel_execute;
      o_sl_sel_memory       <= i_sl_sel_execute;
      o_bmask_memory        <= i_bmask_execute;
      o_alu_data_memory     <= i_alu_data_execute;
      o_rd_addr_memory      <= i_rd_addr_execute;
      o_pre_opb_memory      <= i_pre_opb_execute;
      o_ctrl_memory         <= i_ctrl_execute;
      o_fpu_rd_wren_memory  <= i_fpu_rd_wren_execute; 
      o_fpu_mem_wren_memory <= i_fpu_mem_wren_execute;
      o_fpu_data_memory     <= i_fpu_data_execute;
      o_f_operand_b_memory  <= i_f_operand_b_execute;
   end
end

endmodule
