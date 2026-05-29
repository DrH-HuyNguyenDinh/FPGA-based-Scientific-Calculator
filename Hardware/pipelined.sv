module pipelined (
   input logic         i_clk,       // Global clock, active on the rising edge.
   input logic         i_reset,     // Global low active reset.
   input logic  [31:0] i_io_sw,     // Input for switches.
   input logic  [1:0]  i_io_key,    // Input for keys.
   
   output logic        o_ctrl,      // Control transfer instructions (branch or jump).
   output logic        o_mispred,   // Mispredict.
   output logic [31:0] o_pc_debug,  // Debug program counter.
   output logic        o_insn_vld,  // Instruction valid.
   output logic [31:0] o_io_ledr,   // Output for driving red LEDs.
   output logic [31:0] o_io_ledg,   // Output for driving green LEDs.
   output logic [6:0]  o_io_hex0,   // Output for driving 7-segment LED0 displays.
   output logic [6:0]  o_io_hex1,   // Output for driving 7-segment LED1 displays.
   output logic [6:0]  o_io_hex2,   // Output for driving 7-segment LED2 displays.
   output logic [6:0]  o_io_hex3,   // Output for driving 7-segment LED3 displays.
   output logic [6:0]  o_io_hex4,   // Output for driving 7-segment LED4 displays.
   output logic [6:0]  o_io_hex5,   // Output for driving 7-segment LED5 displays.
   output logic [6:0]  o_io_hex6,   // Output for driving 7-segment LED6 displays.
   output logic [6:0]  o_io_hex7,   // Output for driving 7-segment LED7 displays.
   output logic [31:0] o_io_lcd     // Output for driving the LCD register.
);

logic pc_sel;

logic stall_fetch, stall_decode, stall_execute, stall_memory, stall_writeback, stall_fpu;
logic flush_decode, flush_execute;
logic [1:0] foward_a_execute, foward_b_execute;

logic [31:0] pc_fetch, pc_four, pc_next;
logic [31:0] instr_decode;

logic [31:0] pc_decode;
logic [2:0] br_sel_decode;
logic pc_jump_sel_decode, rd_wren_decode;
logic [2:0] imm_sel_decode;
logic insn_vld_decode, br_un_decode, opa_sel_decode, opb_sel_decode;
logic [5:0] alu_op_decode;
logic mem_wren_decode;
logic [2:0] wb_sel_decode;
logic [2:0] sl_sel_decode, bmask_decode;
logic [31:0] immext_decode, rs1_data_decode, rs2_data_decode;
logic ctrl_decode;
logic fpu_vld_decode, fpu_mem_wren_decode, fpu_rd_wren_decode;
logic [1:0] fpu_data_sel_decode;  
logic [5:0] fpu_op_decode;
logic [31:0] f_rs1_data_decode, f_rs2_data_decode;
logic rs1_is_float_decode, rs2_is_float_decode;                           

logic [31:0] alu_data_execute;
logic [31:0] pc_execute, pc_four_execute;
logic [4:0] rs1_addr_execute, rs2_addr_execute, rd_addr_execute;
logic [2:0] br_sel_execute;
logic pc_jump_sel_execute, rd_wren_execute, insn_vld_execute, br_un_execute;
logic opa_sel_execute, opb_sel_execute;
logic [5:0] alu_op_execute;
logic mem_wren_execute;
logic [2:0] wb_sel_execute;
logic [2:0] sl_sel_execute, bmask_execute;
logic [31:0] immext_execute, rs1_data_execute, rs2_data_execute;
logic [31:0] pre_opa_execute, pre_opb_execute, operand_a_execute, operand_b_execute;
logic pc_br_sel_execute;
logic ctrl_execute;
logic [1:0] fpu_data_sel_execute;
logic fpu_rd_wren_execute, fpu_mem_wren_execute, fpu_vld_execute;
logic [5:0] fpu_op_execute;
logic [2:0] rm_execute;
logic [31:0] f_rs1_data_execute, f_rs2_data_execute;
logic [31:0] f_operand_a_execute, f_operand_b_execute;
logic [31:0] fpu_data_0_execute, fpu_data_1_execute, fpu_data_2_execute;
logic [31:0] fpu_data_execute;
logic rs1_is_float_execute, rs2_is_float_execute;
logic [31:0] pre_float_integer_execute, pre_integer_float_execute;

logic [31:0] alu_pc4_data_memory, pc_memory, pc_four_memory;
logic rd_wren_memory, insn_vld_memory, mem_wren_memory;
logic [2:0] wb_sel_memory;
logic [2:0] sl_sel_memory, bmask_memory;
logic [31:0] alu_data_memory, pre_opb_memory;
logic [4:0] rd_addr_memory;
logic [31:0] io_sw;
logic [1:0] io_key;
logic [31:0] ld_data;
logic ctrl_memory;
logic fpu_rd_wren_memory, fpu_mem_wren_memory;
logic [31:0] fpu_data_memory, f_rs2_data_memory;
logic lsu_wren_memory;
logic [31:0] st_data_memory;
logic [31:0] f_operand_b_memory;

logic [2:0] sl_sel_final;

logic [4:0] rd_addr_writeback;
logic rd_wren_writeback;
logic [31:0] wb_data, alu_pc4_data_writeback;
logic [2:0] wb_sel_writeback;
logic fpu_rd_wren_writeback;

logic btb_wren, check_pc_predict;
logic [31:0] pc_predict;
logic [31:0] btb_addr;
logic [31:0] pc_predict_1, pc_predict_2;
logic flush_out_loop;
logic taken;
logic [1:0] state, next_state, state1, state2;

//      ____                       _       _____                    _     ____         __  __           
//     | __ ) _ __ __ _ _ __   ___| |__   |_   _|_ _ _ __ __ _  ___| |_  | __ ) _   _ / _|/ _| ___ _ __ 
//     |  _ \| '__/ _` | '_ \ / __| '_ \    | |/ _` | '__/ _` |/ _ \ __| |  _ \| | | | |_| |_ / _ \ '__|
//     | |_) | | | (_| | | | | (__| | | |   | | (_| | | | (_| |  __/ |_  | |_) | |_| |  _|  _|  __/ |   
//     |____/|_|  \__,_|_| |_|\___|_| |_|   |_|\__,_|_|  \__, |\___|\__| |____/ \__,_|_| |_|  \___|_|   
//                                                       |___/                                       
//      ____                       _       _   _ _     _                     _____     _     _      
//     | __ ) _ __ __ _ _ __   ___| |__   | | | (_)___| |_ ___  _ __ _   _  |_   _|_ _| |__ | | ___ 
//     |  _ \| '__/ _` | '_ \ / __| '_ \  | |_| | / __| __/ _ \| '__| | | |   | |/ _` | '_ \| |/ _ \
//     | |_) | | | (_| | | | | (__| | | | |  _  | \__ \ || (_) | |  | |_| |   | | (_| | |_) | |  __/
//     |____/|_|  \__,_|_| |_|\___|_| |_| |_| |_|_|___/\__\___/|_|   \__, |   |_|\__,_|_.__/|_|\___|
//                                                                   |___/                         

always_ff @(posedge i_clk or negedge i_reset) begin
   if (~i_reset) begin
      pc_predict_1 <= 0;
      pc_predict_2 <= 0;
      state1       <= 0;
      state2       <= 0;
   end else begin
      pc_predict_1 <= pc_predict;
      pc_predict_2 <= pc_predict_1;
      state1       <= state;
      state2       <= state1;
   end
end

assign check_pc_predict = ~(& (~(alu_data_execute ^ pc_predict_2)));
                          
assign btb_wren = (pc_sel & check_pc_predict) | ctrl_execute;

always @(*) begin
   if (btb_wren)
      btb_addr = pc_execute;
   else
      btb_addr = pc_fetch;
end

bht bht1 (
   .i_enable        (ctrl_execute), 
   .i_branch        (pc_sel),
   .i_current_state (state2),

   .o_next_state    (next_state)
);

btb btb1 (
   .i_clk           (i_clk),       
   .i_btb_wren      (btb_wren), 
   .i_ctrl_execute  (ctrl_execute),
   .i_pc_four       (pc_four), 
   .i_btb_data      ({next_state, pc_execute[31:12], alu_data_execute}),
   .i_btb_addr      (btb_addr),
   
   .o_pc_predict    (pc_predict), 
   .o_predict_state (state)
);
          
assign flush_out_loop = ctrl_execute & ~pc_sel & ~check_pc_predict;

//      _   _                        _   ____       _            _   _             
//     | | | | __ _ ______ _ _ __ __| | |  _ \  ___| |_ ___  ___| |_(_) ___  _ __  
//     | |_| |/ _` |_  / _` | '__/ _` | | | | |/ _ \ __/ _ \/ __| __| |/ _ \| '_ \ 
//     |  _  | (_| |/ / (_| | | | (_| | | |_| |  __/ ||  __/ (__| |_| | (_) | | | |
//     |_|_|_|\__,_/___\__,_|_|  \__,_| |____/ \___|\__\___|\___|\__|_|\___/|_| |_|
//     |  ___|__  _ ____      ____ _ _ __ __| (_)_ __   __ _  | | | |_ __ (_) |_   
//     | |_ / _ \| '__\ \ /\ / / _` | '__/ _` | | '_ \ / _` | | | | | '_ \| | __|  
//     |  _| (_) | |   \ V  V / (_| | | | (_| | | | | | (_| | | |_| | | | | | |_   
//     |_|  \___/|_|    \_/\_/ \__,_|_|  \__,_|_|_| |_|\__, |  \___/|_| |_|_|\__|  
//                                                     |___/     

hazard hazard1 (
   .i_rs1_addr_execute      (rs1_addr_execute),   
   .i_rs2_addr_execute      (rs2_addr_execute),     
   .i_rd_addr_memory        (rd_addr_memory),
   .i_rd_addr_writeback     (rd_addr_writeback), 
   .i_pc_sel                (pc_sel & check_pc_predict),
   .i_wb_sel_execute        (wb_sel_execute),       
   .i_rd_wren_memory        (rd_wren_memory),
   .i_rd_wren_writeback     (rd_wren_writeback), 
   .i_out_loop              (flush_out_loop),
   .i_stall_fpu             (stall_fpu),
   .i_rs1_is_float_execute  (rs1_is_float_execute),
   .i_rs2_is_float_execute  (rs2_is_float_execute),
   .i_fpu_rd_wren_memory    (fpu_rd_wren_memory),
   .i_fpu_rd_wren_writeback (fpu_rd_wren_writeback),

   .o_foward_a_execution    (foward_a_execute), 
   .o_foward_b_execution    (foward_b_execute),
   .o_stall_fetch           (stall_fetch),             
   .o_stall_decode          (stall_decode), 
   .o_stall_execute         (stall_execute),
   .o_stall_memory          (stall_memory),
   .o_stall_writeback       (stall_writeback),
   .o_flush_decode          (flush_decode),           
   .o_flush_execute         (flush_execute)
);

//      _____    _       _     
//     |  ___|__| |_ ___| |__  
//     | |_ / _ \ __/ __| '_ \ 
//     |  _|  __/ || (__| | | |
//     |_|  \___|\__\___|_| |_|
//                             

always_ff @(posedge i_clk or negedge i_reset) begin
   if (~i_reset)
      pc_fetch <= 32'b0;
   else if (stall_fetch)
      pc_fetch <= pc_fetch;
   else 
      pc_fetch <= pc_next;
end

mux4to1 pcnextsel (
   .i_data_0 (pc_four_execute), 
   .i_data_1 (pc_predict), 
   .i_data_2 (pc_predict),      
   .i_data_3 (alu_data_execute),
   .i_sel    ({pc_sel, check_pc_predict}),     
                 
   .o_data   (pc_next)
);

fullAdder32b pcfour (
   .a   (pc_fetch), 
   .b   (32'h4), 
   .cin (1'b0), 
   .sum (pc_four)
); // pc_four

instrmem instr_mem (
   .i_clk          (i_clk),        
   .i_reset        (i_reset), 
   .i_stall_decode (stall_decode), 
   .i_flush_decode (flush_decode), 
   .i_pc           (pc_fetch), 
          
   .o_instr        (instr_decode)
); // instruction memory

//      ____                     _      
//     |  _ \  ___  ___ ___   __| | ___ 
//     | | | |/ _ \/ __/ _ \ / _` |/ _ \
//     | |_| |  __/ (_| (_) | (_| |  __/
//     |____/ \___|\___\___/ \__,_|\___|
//                                      

flip_flop_fetch_decode ffIFID (
   .i_clk          (i_clk),                 
   .i_reset        (i_reset), 
   .i_stall_decode (stall_decode), 
   .i_flush_decode (flush_decode),
   .i_pc_fetch     (pc_fetch), 
    
   .o_pc_decode    (pc_decode)
);

controlunit ctrlunit (
   .i_op           (instr_decode[6:0]),      
   .i_funct3       (instr_decode[14:12]),
   .i_funct7_5     (instr_decode[30]), 
   .i_funct7_0     (instr_decode[25]),
   .i_funct7       (instr_decode[31:25]),
   .i_rs2          (instr_decode[24:20]),
                      
   .o_pc_sel       (pc_jump_sel_decode), 
   .o_rd_wren      (rd_wren_decode), 
   .o_br_un        (br_un_decode),        
   .o_opa_sel      (opa_sel_decode), 
   .o_opb_sel      (opb_sel_decode),    
   .o_mem_wren     (mem_wren_decode), 
   .o_insn_vld     (insn_vld_decode),  
   .o_imm_sel      (imm_sel_decode), 
   .o_br_sel       (br_sel_decode),      
   .o_alu_op       (alu_op_decode),
   .o_wb_sel       (wb_sel_decode),      
   .o_sl_sel       (sl_sel_decode),
   .o_bmask        (bmask_decode), 
   .o_ctrl         (ctrl_decode),
   .o_fpu_vld      (fpu_vld_decode), 
   .o_fpu_mem_wren (fpu_mem_wren_decode), 
   .o_fpu_rd_wren  (fpu_rd_wren_decode), 
   .o_fpu_data_sel (fpu_data_sel_decode), 
   .o_fpu_op       (fpu_op_decode),
   .o_rs1_is_float (rs1_is_float_decode), 
   .o_rs2_is_float (rs2_is_float_decode)
); 

immgen imm_gen (
   .i_instr   (instr_decode[31:7]), 
   .i_imm_sel (imm_sel_decode), 

   .o_immext  (immext_decode));
                      
regfile registerfile (
   .i_clk      (i_clk),                    
   .i_reset    (i_reset),             
   .i_rs1_addr (instr_decode[19:15]), 
   .i_rs2_addr (instr_decode[24:20]),    
   .i_rd_addr  (rd_addr_writeback),    
   .i_rd_data  (wb_data), 
   .i_rd_wren  (rd_wren_writeback),
                      
   .o_rs1_data (rs1_data_decode),     
   .o_rs2_data (rs2_data_decode)
);

f_regfile fpu_registerfile (
   .i_clk      (i_clk),                    
   .i_reset    (i_reset),             
   .i_rs1_addr (instr_decode[19:15]), 
   .i_rs2_addr (instr_decode[24:20]),    
   .i_rd_addr  (rd_addr_writeback),    
   .i_rd_data  (wb_data), 
   .i_rd_wren  (fpu_rd_wren_writeback),
                      
   .o_rs1_data (f_rs1_data_decode),     
   .o_rs2_data (f_rs2_data_decode)
);

//      _____                     _       
//     | ____|_  _____  ___ _   _| |_ ___ 
//     |  _| \ \/ / _ \/ __| | | | __/ _ \
//     | |___ >  <  __/ (__| |_| | ||  __/
//     |_____/_/\_\___|\___|\__,_|\__\___|
//                                        

assign pc_sel = pc_br_sel_execute | pc_jump_sel_execute;

flip_flop_decode_execute ffIDEX (
   .i_clk                  (i_clk),                .i_reset                (i_reset), 
   .i_flush_execute        (flush_execute),        .i_pc_decode            (pc_decode), 
   .i_instr_decode         (instr_decode),         .i_br_sel_decode        (br_sel_decode),
   .i_pc_jump_sel_decode   (pc_jump_sel_decode),   .i_rd_wren_decode       (rd_wren_decode),
   .i_insn_vld_decode      (insn_vld_decode),      .i_br_un_decode         (br_un_decode), 
   .i_opa_sel_decode       (opa_sel_decode),       .i_opb_sel_decode       (opb_sel_decode),
   .i_alu_op_decode        (alu_op_decode),        .i_mem_wren_decode      (mem_wren_decode),
   .i_wb_sel_decode        (wb_sel_decode),        .i_sl_sel_decode        (sl_sel_decode), 
   .i_bmask_decode         (bmask_decode),         .i_immext_decode        (immext_decode), 
   .i_rs1_data_decode      (rs1_data_decode),      .i_rs2_data_decode      (rs2_data_decode),
   .i_ctrl_decode          (ctrl_decode),          .i_fpu_data_sel_decode  (fpu_data_sel_decode),
   .i_fpu_rd_wren_decode   (fpu_rd_wren_decode),   .i_fpu_mem_wren_decode  (fpu_mem_wren_decode),
   .i_fpu_op_decode        (fpu_op_decode),        .i_fpu_vld_decode       (fpu_vld_decode),
   .i_stall_execute        (stall_execute),        .i_rm_decode            (instr_decode[14:12]),
   .i_f_rs1_data_decode    (f_rs1_data_decode),    .i_f_rs2_data_decode    (f_rs2_data_decode),
   .i_rs1_is_float_decode  (rs1_is_float_decode),  .i_rs2_is_float_decode  (rs2_is_float_decode),                           
   
   .o_pc_execute           (pc_execute),           .o_rs1_addr_execute     (rs1_addr_execute), 
   .o_rs2_addr_execute     (rs2_addr_execute),     .o_rd_addr_execute      (rd_addr_execute),
   .o_br_sel_execute       (br_sel_execute),       .o_pc_jump_sel_execute  (pc_jump_sel_execute), 
   .o_rd_wren_execute      (rd_wren_execute),      .o_insn_vld_execute     (insn_vld_execute), 
   .o_br_un_execute        (br_un_execute),        .o_opa_sel_execute      (opa_sel_execute), 
   .o_opb_sel_execute      (opb_sel_execute),      .o_alu_op_execute       (alu_op_execute),
   .o_mem_wren_execute     (mem_wren_execute),     .o_wb_sel_execute       (wb_sel_execute),
   .o_sl_sel_execute       (sl_sel_execute),       .o_bmask_execute        (bmask_execute),
   .o_immext_execute       (immext_execute),       .o_rs1_data_execute     (rs1_data_execute),     
   .o_rs2_data_execute     (rs2_data_execute),     .o_ctrl_execute         (ctrl_execute),
   .o_fpu_data_sel_execute (fpu_data_sel_execute), .o_fpu_rd_wren_execute  (fpu_rd_wren_execute), 
   .o_fpu_mem_wren_execute (fpu_mem_wren_execute), .o_fpu_op_execute       (fpu_op_execute),       
   .o_fpu_vld_execute      (fpu_vld_execute),      .o_rm_execute           (rm_execute),
   .o_f_rs1_data_execute   (f_rs1_data_execute),   .o_f_rs2_data_execute   (f_rs2_data_execute),
   .o_rs1_is_float_execute (rs1_is_float_execute), .o_rs2_is_float_execute (rs2_is_float_execute)
);

mux4to1 fowardA_integer (
   .i_data_0 (rs1_data_execute), 
   .i_data_1 (alu_pc4_data_memory), 
   .i_data_2 (wb_data),          
   .i_data_3 (0),
   .i_sel    (foward_a_execute),     
                 
   .o_data   (pre_opa_execute)
);
                 
mux4to1 fowardB_integer (
   .i_data_0 (rs2_data_execute), 
   .i_data_1 (alu_pc4_data_memory), 
   .i_data_2 (wb_data),          
   .i_data_3 (0),
   .i_sel    (foward_b_execute),     
                 
   .o_data   (pre_opb_execute)
);

mux4to1 foward_integer_float (
   .i_data_0 (f_rs1_data_execute),
   .i_data_1 (alu_pc4_data_memory),
   .i_data_2 (wb_data),
   .i_data_3 (0),
   .i_sel    (foward_a_execute),

   .o_data   (pre_integer_float_execute)
);
                 
always @(*) begin
   if (opa_sel_execute)
      operand_a_execute = pc_execute;
   else 
      operand_a_execute = pre_opa_execute;
end

always @(*) begin
   if (opb_sel_execute)
      operand_b_execute = immext_execute;
   else 
      operand_b_execute = pre_opb_execute;
end

mux4to1 fowardA_float (
   .i_data_0 (f_rs1_data_execute), 
   .i_data_1 (alu_pc4_data_memory), 
   .i_data_2 (wb_data),          
   .i_data_3 (0),
   .i_sel    (foward_a_execute),     
                 
   .o_data   (f_operand_a_execute)
);
                 
mux4to1 fowardB_float (
   .i_data_0 (f_rs2_data_execute), 
   .i_data_1 (alu_pc4_data_memory), 
   .i_data_2 (wb_data),          
   .i_data_3 (0),
   .i_sel    (foward_b_execute),     
                 
   .o_data   (f_operand_b_execute)
);

mux4to1 foward_float_integer (
   .i_data_0 (rs1_data_execute), 
   .i_data_1 (alu_pc4_data_memory), 
   .i_data_2 (wb_data),          
   .i_data_3 (0),
   .i_sel    (foward_a_execute),     
                 
   .o_data   (pre_float_integer_execute)
);

alu alu1 (
   .i_operand_a (operand_a_execute), 
   .i_operand_b (operand_b_execute), 
   .i_alu_op    (alu_op_execute),
   .i_fpu_rs1   (pre_integer_float_execute),
          
   .o_alu_data  (alu_data_execute)
); // alu

brc brc1 (
   .i_rs1_data (pre_opa_execute), 
   .i_rs2_data (pre_opb_execute), 
   .i_br_un    (br_un_execute),      
   .i_br_sel   (br_sel_execute), 
          
   .o_pc_sel   (pc_br_sel_execute)
);

fullAdder32b pcfourexecute (
   .a   (pc_execute), 
   .b   (32'h4), 
   .cin (1'b0), 
   .sum (pc_four_execute)
); // pc_four_execute

fpu fpu1 (
   .i_clk          (i_clk),
   .i_reset        (i_reset),
   .i_fpu_vld      (fpu_vld_execute),  
   .i_fpu_op       (fpu_op_execute),   
   .i_rm           (rm_execute),       
   .i_rs1_data     (f_operand_a_execute), 
   .i_rs2_data     (f_operand_b_execute),
   .i_integer_rs1  (pre_float_integer_execute),
    
   .o_fpu_result_0 (fpu_data_0_execute), 
   .o_fpu_result_1 (fpu_data_1_execute), 
   .o_fpu_result_2 (fpu_data_2_execute),
   .o_fpu_stall    (stall_fpu)   
);

mux4to1 float_result (
   .i_data_0 (fpu_data_0_execute), 
   .i_data_1 (fpu_data_1_execute), 
   .i_data_2 (fpu_data_2_execute),          
   .i_data_3 (0),
   .i_sel    (fpu_data_sel_execute),     
                 
   .o_data   (fpu_data_execute)
);

//      __  __                                 
//     |  \/  | ___ _ __ ___   ___  _ __ _   _ 
//     | |\/| |/ _ \ '_ ` _ \ / _ \| '__| | | |
//     | |  | |  __/ | | | | | (_) | |  | |_| |
//     |_|  |_|\___|_| |_| |_|\___/|_|   \__, |
//                                       |___/ 

flip_flop_execute_memory ffEXMEM (
   .i_clk                  (i_clk),                .i_reset               (i_reset),
   .i_pc_execute           (pc_execute),           .i_pc_four_execute     (pc_four_execute),
   .i_rd_wren_execute      (rd_wren_execute),      .i_insn_vld_execute    (insn_vld_execute), 
   .i_mem_wren_execute     (mem_wren_execute),     .i_wb_sel_execute      (wb_sel_execute),
   .i_sl_sel_execute       (sl_sel_execute),       .i_bmask_execute       (bmask_execute),
   .i_alu_data_execute     (alu_data_execute),     .i_rd_addr_execute     (rd_addr_execute),
   .i_pre_opb_execute      (pre_opb_execute),      .i_ctrl_execute        (ctrl_execute),
   .i_stall_memory         (stall_memory),         .i_fpu_rd_wren_execute (fpu_rd_wren_execute),
   .i_fpu_mem_wren_execute (fpu_mem_wren_execute), .i_fpu_data_execute    (fpu_data_execute), 
   .i_f_operand_b_execute  (f_operand_b_execute),
   
   .o_pc_memory            (pc_memory),            .o_pc_four_memory      (pc_four_memory),
   .o_rd_wren_memory       (rd_wren_memory),       .o_insn_vld_memory     (insn_vld_memory), 
   .o_mem_wren_memory      (mem_wren_memory),      .o_wb_sel_memory       (wb_sel_memory),
   .o_sl_sel_memory        (sl_sel_memory),        .o_bmask_memory        (bmask_memory),
   .o_alu_data_memory      (alu_data_memory),      .o_rd_addr_memory      (rd_addr_memory),
   .o_pre_opb_memory       (pre_opb_memory),       .o_ctrl_memory         (ctrl_memory),
   .o_fpu_rd_wren_memory   (fpu_rd_wren_memory),   .o_fpu_mem_wren_memory (fpu_mem_wren_memory),                 
   .o_fpu_data_memory      (fpu_data_memory),      .o_f_operand_b_memory  (f_operand_b_memory)
);

always @(*) begin
   case (wb_sel_memory[1:0])
      2'b00  : alu_pc4_data_memory = pc_four_memory;
      2'b01  : alu_pc4_data_memory = alu_data_memory;
      2'b10  : alu_pc4_data_memory = fpu_data_memory;
      default: alu_pc4_data_memory = alu_data_memory;
   endcase
end

always_ff @(posedge i_clk or negedge i_reset) begin
   if (~i_reset)
      sl_sel_final <= 0;
   else
      sl_sel_final <= sl_sel_memory;
end

always @(*) begin
   case ({fpu_mem_wren_memory, mem_wren_memory})
      2'b00  : st_data_memory = pre_opb_memory;
      2'b10  : st_data_memory = f_operand_b_memory;
      default: st_data_memory = pre_opb_memory;
   endcase
end

assign lsu_wren_memory = mem_wren_memory | fpu_mem_wren_memory;

lsu lsu1 (
   .i_clk      (i_clk),           .i_reset   (i_reset), 
   .i_lsu_addr (alu_data_memory), .i_st_data (st_data_memory), 
   .i_lsu_wren (lsu_wren_memory), .i_sl_sel  (sl_sel_final),
   .i_io_sw    (io_sw),           .i_bmask   (bmask_memory), 
   .i_io_key   (io_key),
          
   .o_ld_data  (ld_data),         .o_io_ledr (o_io_ledr), 
   .o_io_ledg  (o_io_ledg),       .o_io_hex0 (o_io_hex0), 
   .o_io_hex1  (o_io_hex1),       .o_io_hex2 (o_io_hex2), 
   .o_io_hex3  (o_io_hex3),       .o_io_hex4 (o_io_hex4), 
   .o_io_hex5  (o_io_hex5),       .o_io_hex6 (o_io_hex6), 
   .o_io_hex7  (o_io_hex7),       .o_io_lcd  (o_io_lcd)
); // lsu

//     __        __    _ _         ____             _    
//     \ \      / / __(_) |_ ___  | __ )  __ _  ___| | __
//      \ \ /\ / / '__| | __/ _ \ |  _ \ / _` |/ __| |/ /
//       \ V  V /| |  | | ||  __/ | |_) | (_| | (__|   < 
//        \_/\_/ |_|  |_|\__\___| |____/ \__,_|\___|_|\_\
//                                                       

flip_flop_memory_writeback ffMEMWB (
      .i_clk                    (i_clk),                  .i_reset                 (i_reset),
      .i_rd_wren_memory         (rd_wren_memory),         .i_insn_vld_memory       (insn_vld_memory),
      .i_pc_memory              (pc_memory),              .i_wb_sel_memory         (wb_sel_memory),
      .i_alu_pc4_data_memory    (alu_pc4_data_memory),    .i_rd_addr_memory        (rd_addr_memory),
      .i_ctrl_memory            (ctrl_memory),            .i_io_sw                 (i_io_sw),
      .i_io_key                 (i_io_key),               .i_fpu_rd_wren_memory    (fpu_rd_wren_memory),
   
      .o_rd_wren_writeback      (rd_wren_writeback),      .o_insn_vld_writeback    (o_insn_vld),
      .o_pc_writeback           (o_pc_debug),             .o_wb_sel_writeback      (wb_sel_writeback),
      .o_alu_pc4_data_writeback (alu_pc4_data_writeback), .o_rd_addr_writeback     (rd_addr_writeback),
      .o_ctrl                   (o_ctrl),                 .o_io_sw                 (io_sw),
      .o_io_key                 (io_key),                 .o_fpu_rd_wren_writeback (fpu_rd_wren_writeback)
);
                  
always @(*) begin
   if (wb_sel_writeback[2])
      wb_data = ld_data;
   else
      wb_data = alu_pc4_data_writeback;
end

assign o_mispred = flush_decode & flush_execute;

endmodule
