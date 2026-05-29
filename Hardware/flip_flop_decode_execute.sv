module flip_flop_decode_execute (
   input logic         i_clk, i_reset, i_flush_execute, i_stall_execute,
   input logic  [31:0] i_pc_decode, i_instr_decode,
   input logic  [2:0]  i_br_sel_decode,
   input logic         i_pc_jump_sel_decode, i_rd_wren_decode,
   input logic         i_insn_vld_decode, i_br_un_decode, i_opa_sel_decode, i_opb_sel_decode,
   input logic  [5:0]  i_alu_op_decode,
   input logic         i_mem_wren_decode,
   input logic  [2:0]  i_wb_sel_decode,
   input logic  [2:0]  i_sl_sel_decode, i_bmask_decode,
   input logic  [31:0] i_immext_decode, i_rs1_data_decode, i_rs2_data_decode,
   input logic         i_ctrl_decode,
   input logic         i_fpu_rd_wren_decode, i_fpu_mem_wren_decode, i_fpu_vld_decode,
   input logic  [1:0]  i_fpu_data_sel_decode,
   input logic  [5:0]  i_fpu_op_decode,
   input logic  [2:0]  i_rm_decode,
   input logic  [31:0] i_f_rs1_data_decode, i_f_rs2_data_decode,
   input logic         i_rs1_is_float_decode, i_rs2_is_float_decode,
   
   output logic [31:0] o_pc_execute, 
   output logic [4:0]  o_rs1_addr_execute, o_rs2_addr_execute, o_rd_addr_execute,
   output logic [2:0]  o_br_sel_execute,
   output logic        o_pc_jump_sel_execute, o_rd_wren_execute,
   output logic        o_insn_vld_execute, o_br_un_execute, o_opa_sel_execute, o_opb_sel_execute,
   output logic [5:0]  o_alu_op_execute,
   output logic        o_mem_wren_execute,
   output logic [2:0]  o_wb_sel_execute,
   output logic [2:0]  o_sl_sel_execute, o_bmask_execute,
   output logic [31:0] o_immext_execute, o_rs1_data_execute, o_rs2_data_execute,
   output logic        o_ctrl_execute,
   output logic        o_fpu_rd_wren_execute, o_fpu_mem_wren_execute, o_fpu_vld_execute,
   output logic [1:0]  o_fpu_data_sel_execute,
   output logic [5:0]  o_fpu_op_execute,
   output logic [2:0]  o_rm_execute,
   output logic [31:0] o_f_rs1_data_execute, o_f_rs2_data_execute,
   output logic        o_rs1_is_float_execute, o_rs2_is_float_execute
);

always_ff @(posedge i_clk or negedge i_reset) begin
   if (~i_reset) begin
      o_pc_execute           <= 0;
      o_rs1_addr_execute     <= 0;
      o_rs2_addr_execute     <= 0;
      o_rd_addr_execute      <= 0;
      o_rs1_data_execute     <= 0;
      o_rs2_data_execute     <= 0;
      o_immext_execute       <= 0;
      o_br_sel_execute       <= 0;
      o_pc_jump_sel_execute  <= 0;
      o_rd_wren_execute      <= 0;
      o_insn_vld_execute     <= 0;
      o_br_un_execute        <= 0;
      o_opa_sel_execute      <= 0;
      o_opb_sel_execute      <= 0;
      o_alu_op_execute       <= 0;
      o_mem_wren_execute     <= 0;
      o_wb_sel_execute       <= 0;
      o_sl_sel_execute       <= 0;
      o_bmask_execute        <= 0;
      o_ctrl_execute         <= 0;
      o_fpu_rd_wren_execute  <= 0;
      o_fpu_mem_wren_execute <= 0;
      o_fpu_vld_execute      <= 0;
      o_fpu_data_sel_execute <= 0;
      o_fpu_op_execute       <= 0;
      o_rm_execute           <= 0;
      o_f_rs1_data_execute   <= 0;
      o_f_rs2_data_execute   <= 0;
      o_rs1_is_float_execute <= 0;
      o_rs2_is_float_execute <= 0;
   end else begin
      if (i_flush_execute) begin
         o_rd_wren_execute      <= 0; 
         o_mem_wren_execute     <= 0;
         o_insn_vld_execute     <= 0; 
         o_pc_jump_sel_execute  <= 0;
         o_pc_execute           <= 0;
         o_rs1_addr_execute     <= 0;
         o_rs2_addr_execute     <= 0;
         o_rd_addr_execute      <= 0;
         o_br_sel_execute       <= 0;
         o_br_un_execute        <= 0;
         o_opa_sel_execute      <= 0;
         o_opb_sel_execute      <= 0;
         o_alu_op_execute       <= 0;
         o_wb_sel_execute       <= 0;
         o_sl_sel_execute       <= 0;
         o_bmask_execute        <= 0;
         o_immext_execute       <= 0;
         o_rs1_data_execute     <= 0;
         o_rs2_data_execute     <= 0;
         o_ctrl_execute         <= 0;
         o_fpu_rd_wren_execute  <= 0;
         o_fpu_mem_wren_execute <= 0;
         o_fpu_vld_execute      <= 0;
         o_fpu_data_sel_execute <= 0;
         o_fpu_op_execute       <= 0;
         o_rm_execute           <= 0;
         o_f_rs1_data_execute   <= 0;
         o_f_rs2_data_execute   <= 0;
         o_rs1_is_float_execute <= 0;
         o_rs2_is_float_execute <= 0;
      end else if (i_stall_execute) begin
         o_rd_wren_execute      <= o_rd_wren_execute; 
         o_mem_wren_execute     <= o_mem_wren_execute;
         o_insn_vld_execute     <= o_insn_vld_execute; 
         o_pc_jump_sel_execute  <= o_pc_jump_sel_execute;
         o_pc_execute           <= o_pc_execute;
         o_rs1_addr_execute     <= o_rs1_addr_execute;
         o_rs2_addr_execute     <= o_rs2_addr_execute;
         o_rd_addr_execute      <= o_rd_addr_execute;
         o_br_sel_execute       <= o_br_sel_execute;
         o_br_un_execute        <= o_br_un_execute;
         o_opa_sel_execute      <= o_opa_sel_execute;
         o_opb_sel_execute      <= o_opb_sel_execute;
         o_alu_op_execute       <= o_alu_op_execute;
         o_wb_sel_execute       <= o_wb_sel_execute;
         o_sl_sel_execute       <= o_sl_sel_execute;
         o_bmask_execute        <= o_bmask_execute;
         o_immext_execute       <= o_immext_execute;
         o_rs1_data_execute     <= o_rs1_data_execute;
         o_rs2_data_execute     <= o_rs2_data_execute;
         o_ctrl_execute         <= o_ctrl_execute;
         o_fpu_rd_wren_execute  <= o_fpu_rd_wren_execute;
         o_fpu_mem_wren_execute <= o_fpu_mem_wren_execute;
         o_fpu_vld_execute      <= o_fpu_vld_execute;
         o_fpu_data_sel_execute <= o_fpu_data_sel_execute;
         o_fpu_op_execute       <= o_fpu_op_execute;
         o_rm_execute           <= o_rm_execute;
         o_f_rs1_data_execute   <= o_f_rs1_data_execute;
         o_f_rs2_data_execute   <= o_f_rs2_data_execute;
         o_rs1_is_float_execute <= o_rs1_is_float_execute;
         o_rs2_is_float_execute <= o_rs2_is_float_execute;
      end else begin
         o_pc_execute           <= i_pc_decode;
         o_rs1_addr_execute     <= i_instr_decode[19:15];
         o_rs2_addr_execute     <= i_instr_decode[24:20];
         o_rd_addr_execute      <= i_instr_decode[11:7];
         o_rs1_data_execute     <= i_rs1_data_decode;
         o_rs2_data_execute     <= i_rs2_data_decode;
         o_immext_execute       <= i_immext_decode;
         o_br_sel_execute       <= i_br_sel_decode;
         o_pc_jump_sel_execute  <= i_pc_jump_sel_decode;
         o_rd_wren_execute      <= i_rd_wren_decode;
         o_insn_vld_execute     <= i_insn_vld_decode;
         o_br_un_execute        <= i_br_un_decode;
         o_opa_sel_execute      <= i_opa_sel_decode;
         o_opb_sel_execute      <= i_opb_sel_decode;
         o_alu_op_execute       <= i_alu_op_decode;
         o_mem_wren_execute     <= i_mem_wren_decode;
         o_wb_sel_execute       <= i_wb_sel_decode;
         o_sl_sel_execute       <= i_sl_sel_decode;
         o_bmask_execute        <= i_bmask_decode;
         o_ctrl_execute         <= i_ctrl_decode;
         o_fpu_rd_wren_execute  <= i_fpu_rd_wren_decode;
         o_fpu_mem_wren_execute <= i_fpu_mem_wren_decode;
         o_fpu_vld_execute      <= i_fpu_vld_decode;
         o_fpu_data_sel_execute <= i_fpu_data_sel_decode;
         o_fpu_op_execute       <= i_fpu_op_decode;
         o_rm_execute           <= i_rm_decode;
         o_f_rs1_data_execute   <= i_f_rs1_data_decode;
         o_f_rs2_data_execute   <= i_f_rs2_data_decode;
         o_rs1_is_float_execute <= i_rs1_is_float_decode;
         o_rs2_is_float_execute <= i_rs2_is_float_decode;
      end
   end
end

endmodule
