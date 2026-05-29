module controlunit (
   input logic [6:0] i_op,
   input logic [14:12] i_funct3,
   input logic [24:20] i_rs2,
   input logic i_funct7_5,
   input logic i_funct7_0,
   input logic [31:25] i_funct7,
   
   output logic o_pc_sel, o_rd_wren, o_br_un, o_opa_sel, o_opb_sel, o_mem_wren, o_insn_vld,
   output logic [2:0] o_imm_sel, o_br_sel,
   output logic [5:0] o_alu_op, 
   output logic [2:0] o_wb_sel,
   output logic [2:0] o_sl_sel,
   output logic [2:0] o_bmask,
   output logic o_ctrl,
   
   output logic o_fpu_vld, o_fpu_mem_wren, o_fpu_rd_wren, o_rs1_is_float, o_rs2_is_float,
   output logic [1:0] o_fpu_data_sel, 
   output logic [5:0] o_fpu_op 
);

logic rs2_is_00000;
assign rs2_is_00000 = ~i_rs2[24] & ~i_rs2[23] & ~i_rs2[22] & ~i_rs2[21] & ~i_rs2[20];

logic rv32i;
logic R_type, S_type, B_type, J_type;
logic I_type_3, I_type_19, I_type_103;
logic U_type_23, U_type_55;

logic R_type_83, I_type_7, S_type_39;

logic fadd, fsub, fmul, fdiv, fsqrt;                        // R_type(83), rm = instr_decode[14:12], fmt = 00 (single precision)
logic fsgnj, fsgnjn, fsgnjx, fmin, fmax;                    // R_type(83)
logic feq, flt, fle;                                        // R_type(83)
logic fcos, fsin, fcosh, fsinh, fatanh;                     // R_type(83)

logic flw, fsw;                                             // I_type(7), S_type(39)
logic fcvt_w_s, fcvt_s_w, fmv_x_w, fmv_w_x;                 // R_type(83)

logic lb, lh, lw, lbu, lhu;                                 // I_type(3)
logic addi, slli, slti, sltiu, xori, srli, srai, ori, andi; // I_type(19)
logic auipc;                                                // U_type(23)
logic sb, sh, sw;                                           // S_type(35)
logic add, sub, sll, slt, sltu, XOR, srl, sra, OR, AND; 
//logic mul, mulh, mulhsu, mulhu, div, divu, rem, remu;     // R_type(51)
logic lui;                                                  // U_type(55)
logic beq, bne, blt, bge, bltu, bgeu;                       // B_type(99)
logic jalr;                                                 // I_type(103)
logic jal;                                                  // J_type(111)

//      ___           _                   _   _               _____                      
//     |_ _|_ __  ___| |_ _ __ _   _  ___| |_(_) ___  _ __   |_   _|   _ _ __   ___  ___ 
//      | || '_ \/ __| __| '__| | | |/ __| __| |/ _ \| '_ \    | || | | | '_ \ / _ \/ __|
//      | || | | \__ \ |_| |  | |_| | (__| |_| | (_) | | | |   | || |_| | |_) |  __/\__ \
//     |___|_| |_|___/\__|_|   \__,_|\___|\__|_|\___/|_| |_|   |_| \__, | .__/ \___||___/
//                                                                 |___/|_|              
assign rv32i      =  i_op[0] &  i_op[1];
assign I_type_3   = ~i_op[6] & ~i_op[5] & ~i_op[4] & ~i_op[3] & ~i_op[2] & rv32i;   // 0000011(3) 
assign I_type_19  = ~i_op[6] & ~i_op[5] &  i_op[4] & ~i_op[3] & ~i_op[2] & rv32i;   // 0010011(19)
assign I_type_103 =  i_op[6] &  i_op[5] & ~i_op[4] & ~i_op[3] &  i_op[2] & rv32i;   // 1100111(103)
assign S_type     = ~i_op[6] &  i_op[5] & ~i_op[4] & ~i_op[3] & ~i_op[2] & rv32i;   // 0100011(35)
assign R_type     = ~i_op[6] &  i_op[5] &  i_op[4] & ~i_op[3] & ~i_op[2] & rv32i;   // 0110011(51)
assign B_type     =  i_op[6] &  i_op[5] & ~i_op[4] & ~i_op[3] & ~i_op[2] & rv32i;   // 1100011(99)
assign U_type_23  = ~i_op[6] & ~i_op[5] &  i_op[4] & ~i_op[3] &  i_op[2] & rv32i;   // 0010111(23)
assign U_type_55  = ~i_op[6] &  i_op[5] &  i_op[4] & ~i_op[3] &  i_op[2] & rv32i;   // 0110111(55)
assign J_type     =  i_op[6] &  i_op[5] & ~i_op[4] &  i_op[3] &  i_op[2] & rv32i;   // 1101111(111)
assign R_type_83  =  i_op[6] & ~i_op[5] &  i_op[4] & ~i_op[3] & ~i_op[2] & rv32i;   // 1010011(83)
assign I_type_7   = ~i_op[6] & ~i_op[5] & ~i_op[4] & ~i_op[3] &  i_op[2] & rv32i;   // 0000111(7)
assign S_type_39  = ~i_op[6] &  i_op[5] & ~i_op[4] & ~i_op[3] &  i_op[2] & rv32i;   // 0100111(39)

//      ___       _                         ___           _                   _   _                 
//     |_ _|_ __ | |_ ___  __ _  ___ _ __  |_ _|_ __  ___| |_ _ __ _   _  ___| |_(_) ___  _ __  ___ 
//      | || '_ \| __/ _ \/ _` |/ _ \ '__|  | || '_ \/ __| __| '__| | | |/ __| __| |/ _ \| '_ \/ __|
//      | || | | | ||  __/ (_| |  __/ |     | || | | \__ \ |_| |  | |_| | (__| |_| | (_) | | | \__ \
//     |___|_| |_|\__\___|\__, |\___|_|    |___|_| |_|___/\__|_|   \__,_|\___|\__|_|\___/|_| |_|___/
//                        |___/  

// I_type(3)                                                                  
assign lb    =               ~i_funct3[14] & ~i_funct3[13] & ~i_funct3[12] & I_type_3;    // funct3 = 000
assign lh    =               ~i_funct3[14] & ~i_funct3[13] &  i_funct3[12] & I_type_3;    // funct3 = 001
assign lw    =               ~i_funct3[14] &  i_funct3[13] & ~i_funct3[12] & I_type_3;    // funct3 = 010
assign lbu   =                i_funct3[14] & ~i_funct3[13] & ~i_funct3[12] & I_type_3;    // funct3 = 100
assign lhu   =                i_funct3[14] & ~i_funct3[13] &  i_funct3[12] & I_type_3;    // funct3 = 101

// I_type(19)
assign addi  =               ~i_funct3[14] & ~i_funct3[13] & ~i_funct3[12] & I_type_19;   // funct3 = 000
assign slli  = ~i_funct7_5 & ~i_funct3[14] & ~i_funct3[13] &  i_funct3[12] & I_type_19;   // funct3 = 001, funct7[30] = 0
assign slti  =               ~i_funct3[14] &  i_funct3[13] & ~i_funct3[12] & I_type_19;   // funct3 = 010
assign sltiu =               ~i_funct3[14] &  i_funct3[13] &  i_funct3[12] & I_type_19;   // fucnt3 = 011
assign xori  =                i_funct3[14] & ~i_funct3[13] & ~i_funct3[12] & I_type_19;   // fucnt3 = 100
assign srli  = ~i_funct7_5 &  i_funct3[14] & ~i_funct3[13] &  i_funct3[12] & I_type_19;   // fucnt3 = 101, funct7[30] = 0
assign srai  =  i_funct7_5 &  i_funct3[14] & ~i_funct3[13] &  i_funct3[12] & I_type_19;   // fucnt3 = 101, funct7[30] = 1
assign ori   =                i_funct3[14] &  i_funct3[13] & ~i_funct3[12] & I_type_19;   // fucnt3 = 110
assign andi  =                i_funct3[14] &  i_funct3[13] &  i_funct3[12] & I_type_19;   // fucnt3 = 111

// U_type(23)
assign auipc = U_type_23;

// S_type(35)
assign sb    =               ~i_funct3[14] & ~i_funct3[13] & ~i_funct3[12] & S_type;      // funct3 = 000
assign sh    =               ~i_funct3[14] & ~i_funct3[13] &  i_funct3[12] & S_type;      // funct3 = 001
assign sw    =               ~i_funct3[14] &  i_funct3[13] & ~i_funct3[12] & S_type;      // funct3 = 010

// R_type(51)
assign add    = ~i_funct7_5 & ~i_funct3[14] & ~i_funct3[13] & ~i_funct3[12] & R_type;     // funct3 = 000, funct7[30] = 0
assign sub    =  i_funct7_5 & ~i_funct3[14] & ~i_funct3[13] & ~i_funct3[12] & R_type;     // funct3 = 000, funct7[30] = 1
assign sll    = ~i_funct7_5 & ~i_funct3[14] & ~i_funct3[13] &  i_funct3[12] & R_type;     // funct3 = 001, funct7[30] = 0
assign slt    = ~i_funct7_5 & ~i_funct3[14] &  i_funct3[13] & ~i_funct3[12] & R_type;     // funct3 = 010, funct7[30] = 0
assign sltu   = ~i_funct7_5 & ~i_funct3[14] &  i_funct3[13] &  i_funct3[12] & R_type;     // funct3 = 011, funct7[30] = 0 
assign XOR    = ~i_funct7_5 &  i_funct3[14] & ~i_funct3[13] & ~i_funct3[12] & R_type;     // funct3 = 100, funct7[30] = 0
assign srl    = ~i_funct7_5 &  i_funct3[14] & ~i_funct3[13] &  i_funct3[12] & R_type;     // funct3 = 101, funct7[30] = 0
assign sra    =  i_funct7_5 &  i_funct3[14] & ~i_funct3[13] &  i_funct3[12] & R_type;     // funct3 = 101, funct7[30] = 1
assign OR     = ~i_funct7_5 &  i_funct3[14] &  i_funct3[13] & ~i_funct3[12] & R_type;     // funct3 = 110, funct7[30] = 0
assign AND    = ~i_funct7_5 &  i_funct3[14] &  i_funct3[13] &  i_funct3[12] & R_type;     // funct3 = 111, funct7[30] = 0
//assign mul    =  i_funct7_0 & ~i_funct3[14] & ~i_funct3[13] & ~i_funct3[12] & R_type;      // funct3 = 000, funct7[25] = 1
//assign mulh   =  i_funct7_0 & ~i_funct3[14] & ~i_funct3[13] &  i_funct3[12] & R_type;      // funct3 = 001, funct7[25] = 1
//assign mulhsu =  i_funct7_0 & ~i_funct3[14] &  i_funct3[13] & ~i_funct3[12] & R_type;      // funct3 = 010, funct7[25] = 1
//assign mulhu  =  i_funct7_0 & ~i_funct3[14] &  i_funct3[13] &  i_funct3[12] & R_type;      // funct3 = 011, funct7[25] = 1
//assign div    =  i_funct7_0 &  i_funct3[14] & ~i_funct3[13] & ~i_funct3[12] & R_type;      // funct3 = 100, funct7[25] = 1
//assign divu   =  i_funct7_0 &  i_funct3[14] & ~i_funct3[13] &  i_funct3[12] & R_type;      // funct3 = 101, funct7[25] = 1
//assign rem    =  i_funct7_0 &  i_funct3[14] &  i_funct3[13] & ~i_funct3[12] & R_type;      // funct3 = 110, funct7[25] = 1
//assign remu   =  i_funct7_0 &  i_funct3[14] &  i_funct3[13] &  i_funct3[12] & R_type;      // funct3 = 111, funct7[25] = 1

// U_type(55)
assign lui   = U_type_55;

// B_type(99)
assign beq   =               ~i_funct3[14] & ~i_funct3[13] & ~i_funct3[12] & B_type;      // funct3 = 000
assign bne   =               ~i_funct3[14] & ~i_funct3[13] &  i_funct3[12] & B_type;      // funct3 = 001
assign blt   =                i_funct3[14] & ~i_funct3[13] & ~i_funct3[12] & B_type;      // funct3 = 100
assign bge   =                i_funct3[14] & ~i_funct3[13] &  i_funct3[12] & B_type;      // funct3 = 101
assign bltu  =                i_funct3[14] &  i_funct3[13] & ~i_funct3[12] & B_type;      // funct3 = 110
assign bgeu  =                i_funct3[14] &  i_funct3[13] &  i_funct3[12] & B_type;      // funct3 = 111

// I_type(103)
assign jalr  =               ~i_funct3[14] & ~i_funct3[13] & ~i_funct3[12] & I_type_103;  // funct3 = 000

// J_type(111) 
assign jal   = J_type;

// R_type(83)
assign fadd     = ~i_funct7[31] & ~i_funct7[30] & ~i_funct7[29] & ~i_funct7[28] &
                  ~i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] &  R_type_83;             // funct7 = 0000000
assign fsub     = ~i_funct7[31] & ~i_funct7[30] & ~i_funct7[29] & ~i_funct7[28] &
                   i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] &  R_type_83;             // funct7 = 0000100
assign fmul     = ~i_funct7[31] & ~i_funct7[30] & ~i_funct7[29] &  i_funct7[28] &
                  ~i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] &  R_type_83;             // funct7 = 0001000
assign fdiv     = ~i_funct7[31] & ~i_funct7[30] & ~i_funct7[29] &  i_funct7[28] &
                   i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] &  R_type_83;             // funct7 = 0001100
assign fsqrt    = ~i_funct7[31] &  i_funct7[30] & ~i_funct7[29] &  i_funct7[28] &
                   i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] &  R_type_83;             // funct7 = 0101100

assign fsgnj    = ~i_funct7[31] & ~i_funct7[30] &  i_funct7[29] & ~i_funct7[28] &
                  ~i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] & 
                  ~i_funct3[14] & ~i_funct3[13] & ~i_funct3[12] &  R_type_83;             // funct7 = 0010000, funct3 = 000

assign fsgnjn   = ~i_funct7[31] & ~i_funct7[30] &  i_funct7[29] & ~i_funct7[28] &
                  ~i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] & 
                  ~i_funct3[14] & ~i_funct3[13] &  i_funct3[12] &  R_type_83;             // funct7 = 0010000, funct3 = 001

assign fsgnjx   = ~i_funct7[31] & ~i_funct7[30] &  i_funct7[29] & ~i_funct7[28] &
                  ~i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] & 
                  ~i_funct3[14] &  i_funct3[13] & ~i_funct3[12] &  R_type_83;             // funct7 = 0010000, funct3 = 010

assign fmin     = ~i_funct7[31] & ~i_funct7[30] &  i_funct7[29] & ~i_funct7[28] &
                   i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] & 
                  ~i_funct3[14] & ~i_funct3[13] & ~i_funct3[12] &  R_type_83;             // funct7 = 0010100, funct3 = 000
                 
assign fmax     = ~i_funct7[31] & ~i_funct7[30] &  i_funct7[29] & ~i_funct7[28] &
                   i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] & 
                  ~i_funct3[14] & ~i_funct3[13] &  i_funct3[12] &  R_type_83;             // funct7 = 0010100, funct3 = 001
                 
assign feq      =  i_funct7[31] & ~i_funct7[30] &  i_funct7[29] & ~i_funct7[28] &
                  ~i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] & 
                  ~i_funct3[14] &  i_funct3[13] & ~i_funct3[12] &  R_type_83;             // funct7 = 1010000, funct3 = 010
                 
assign flt      =  i_funct7[31] & ~i_funct7[30] &  i_funct7[29] & ~i_funct7[28] &
                  ~i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] & 
                  ~i_funct3[14] & ~i_funct3[13] &  i_funct3[12] &  R_type_83;             // funct7 = 1010000, funct3 = 001

assign fle      =  i_funct7[31] & ~i_funct7[30] &  i_funct7[29] & ~i_funct7[28] &
                  ~i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] & 
                  ~i_funct3[14] & ~i_funct3[13] & ~i_funct3[12] &  R_type_83;             // funct7 = 1010000, funct3 = 000
   
assign flw      = ~i_funct3[14] &  i_funct3[13] & ~i_funct3[12] &  I_type_7;              // funct3 = 010
assign fsw      = ~i_funct3[14] &  i_funct3[13] & ~i_funct3[12] &  S_type_39;             // funct3 = 010

assign fcvt_w_s =  i_funct7[31] &  i_funct7[30] & ~i_funct7[29] & ~i_funct7[28] &
                  ~i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] &  R_type_83 & 
                   rs2_is_00000;                                                          // funct7 = 1100000
                  
assign fcvt_s_w =  i_funct7[31] &  i_funct7[30] & ~i_funct7[29] &  i_funct7[28] &
                  ~i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] &  R_type_83 &
                   rs2_is_00000;                                                          // funct7 = 1101000

assign fmv_x_w  =  i_funct7[31] &  i_funct7[30] &  i_funct7[29] & ~i_funct7[28] &
                  ~i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] & 
                  ~i_funct3[14] & ~i_funct3[13] & ~i_funct3[12] &  R_type_83 &
                   rs2_is_00000;                                                          // funct7 = 1110000, funct3 = 000   

assign fmv_w_x  =  i_funct7[31] &  i_funct7[30] &  i_funct7[29] &  i_funct7[28] &
                  ~i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] & 
                  ~i_funct3[14] & ~i_funct3[13] & ~i_funct3[12] &  R_type_83 &
                   rs2_is_00000;                                                          // funct7 = 1111000, funct3 = 000   
                   
assign fcos     = ~i_funct7[31] &  i_funct7[30] &  i_funct7[29] & ~i_funct7[28] &
                  ~i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] &  R_type_83 & 
                   rs2_is_00000;                                                          // funct7 = 0110000

assign fsin     = ~i_funct7[31] &  i_funct7[30] &  i_funct7[29] & ~i_funct7[28] &
                   i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] &  R_type_83 &
                   rs2_is_00000;                                                          // funct7 = 0110100

assign fcosh    = ~i_funct7[31] &  i_funct7[30] &  i_funct7[29] &  i_funct7[28] &
                  ~i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] &  R_type_83 &
                   rs2_is_00000;                                                          // funct7 = 0111000

assign fsinh    = ~i_funct7[31] &  i_funct7[30] &  i_funct7[29] &  i_funct7[28] &
                   i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] &  R_type_83 &
                   rs2_is_00000;                                                          // funct7 = 0111100

assign fatanh   =  i_funct7[31] & ~i_funct7[30] & ~i_funct7[29] & ~i_funct7[28] &
                  ~i_funct7[27] & ~i_funct7[26] & ~i_funct7[25] &  R_type_83 &
                   rs2_is_00000;                                                          // funct7 = 1000000
                   
//      ___           _                   _   _                   ____                     _           
//     |_ _|_ __  ___| |_ _ __ _   _  ___| |_(_) ___  _ __  ___  |  _ \  ___  ___ ___   __| | ___ _ __ 
//      | || '_ \/ __| __| '__| | | |/ __| __| |/ _ \| '_ \/ __| | | | |/ _ \/ __/ _ \ / _` |/ _ \ '__|
//      | || | | \__ \ |_| |  | |_| | (__| |_| | (_) | | | \__ \ | |_| |  __/ (_| (_) | (_| |  __/ |   
//     |___|_| |_|___/\__|_|   \__,_|\___|\__|_|\___/|_| |_|___/ |____/ \___|\___\___/ \__,_|\___|_|   
// 
                                                                                                                    
always @(*) begin
   o_pc_sel       = 0; 
   o_rd_wren      = 0;        
   o_imm_sel      = 3'b000; 
   o_insn_vld     = 0;     
   o_br_un        = 0; 
   o_opa_sel      = 0; 
   o_br_sel       = 3'b000;
   o_opb_sel      = 0; 
   o_alu_op       = 6'b0_00000; 
   o_mem_wren     = 0;      
   o_wb_sel       = 3'b000; 
   o_sl_sel       = 3'b000;
   o_fpu_vld      = 0;
   o_fpu_mem_wren = 0;
   o_fpu_rd_wren  = 0;
   o_fpu_data_sel = 2'b00;
   o_fpu_op       = 5'b00000;
      
   if (I_type_3) begin
      o_pc_sel       = 0; 
      o_rd_wren      = 1;        
      o_imm_sel      = 3'b000;
      o_br_un        = 0;  
      o_opa_sel      = 0; 
      o_br_sel       = 3'b000;
      o_opb_sel      = 1; 
      o_alu_op       = 6'b1_00000; 
      o_mem_wren     = 0;      
      o_wb_sel       = 3'b100;
      o_fpu_vld      = 0;
      o_fpu_mem_wren = 0;
      o_fpu_rd_wren  = 0;
      o_fpu_data_sel = 2'b00;
      o_fpu_op       = 5'b00000;
      if (lb) begin       
         o_sl_sel   = 3'b001; 
         o_insn_vld = 1;
      end else if (lh)  begin
         o_sl_sel   = 3'b010; 
         o_insn_vld = 1;
      end else if (lw)  begin
         o_sl_sel   = 3'b011; 
         o_insn_vld = 1;
      end else if (lbu) begin 
         o_sl_sel   = 3'b100; 
         o_insn_vld = 1;
      end else if (lhu) begin
         o_sl_sel   = 3'b101; 
         o_insn_vld = 1;
      end
   end
      
   else if (I_type_19) begin
      o_pc_sel       = 0; 
      o_rd_wren      = 1;  
      o_imm_sel      = 3'b000; 
      o_opa_sel      = 0; 
      o_br_sel       = 3'b000;
      o_br_un        = 0;
      o_opb_sel      = 1; 
      o_mem_wren     = 0; 
      o_wb_sel       = 3'b001;  
      o_sl_sel       = 3'b000;
      o_fpu_vld      = 0;
      o_fpu_mem_wren = 0;
      o_fpu_rd_wren  = 0;
      o_fpu_data_sel = 2'b00;
      o_fpu_op       = 5'b00000;
      if (addi) begin
         o_alu_op   = 6'b1_00000; 
         o_insn_vld = 1;
      end else if (slli)  begin
         o_alu_op   = 6'b1_00111; 
         o_insn_vld = 1;   
      end else if (slti)  begin
         o_alu_op   = 6'b1_00010; 
         o_insn_vld = 1;
      end else if (sltiu) begin
         o_alu_op   = 6'b1_00011; 
         o_insn_vld = 1;
      end else if (xori)  begin
         o_alu_op   = 6'b1_00100; 
         o_insn_vld = 1;
      end else if (srli)  begin
         o_alu_op   = 6'b1_01000; 
         o_insn_vld = 1;
      end else if (srai)  begin
         o_alu_op   = 6'b1_01001; 
         o_insn_vld = 1;
      end else if (ori)   begin
         o_alu_op   = 6'b1_00101; 
         o_insn_vld = 1;
      end else if (andi)  begin
         o_alu_op   = 6'b1_00110; 
         o_insn_vld = 1;   
      end
   end
   
   else if (auipc) begin
      o_pc_sel       = 0; 
      o_rd_wren      = 1;        
      o_imm_sel      = 3'b100; 
      o_insn_vld     = 1; 
      o_br_un        = 0;     
      o_opa_sel      = 1; 
      o_br_sel       = 3'b000; 
      o_opb_sel      = 1; 
      o_alu_op       = 6'b1_00000; 
      o_mem_wren     = 0;      
      o_wb_sel       = 3'b001; 
      o_sl_sel       = 3'b000;
      o_fpu_vld      = 0;
      o_fpu_mem_wren = 0;
      o_fpu_rd_wren  = 0;
      o_fpu_data_sel = 2'b00;
      o_fpu_op       = 5'b00000;
   end
   
   else if (S_type) begin  // sb, sw, sh
      o_pc_sel       = 0; 
      o_rd_wren      = 0;        
      o_imm_sel      = 3'b001; 
      o_insn_vld     = 1;     
      o_br_un        = 0;
      o_opa_sel      = 0; 
      o_br_sel       = 3'b000;
      o_opb_sel      = 1; 
      o_alu_op       = 6'b1_00000; 
      o_mem_wren     = 1; 
      o_sl_sel       = 3'b000;
      o_fpu_vld      = 0;
      o_fpu_mem_wren = 0;
      o_fpu_rd_wren  = 0;
      o_fpu_data_sel = 2'b00;
      o_fpu_op       = 5'b00000;
   end

   else if (R_type) begin
      o_pc_sel       = 0; 
      o_rd_wren      = 1;  
      o_insn_vld     = 1; 
      o_br_un        = 0;     
      o_opa_sel      = 0; 
      o_opb_sel      = 0; 
      o_mem_wren     = 0; 
      o_wb_sel       = 3'b001; 
      o_br_sel       = 3'b000; 
      o_sl_sel       = 3'b000;
      o_fpu_vld      = 0;
      o_fpu_mem_wren = 0;
      o_fpu_rd_wren  = 0;
      o_fpu_data_sel = 2'b00;
      o_fpu_op       = 5'b00000;
      if (add) begin
         o_alu_op   = 6'b1_00000; 
         o_insn_vld = 1;   
      end else if (sub)  begin  
         o_alu_op   = 6'b1_00001; 
         o_insn_vld = 1;   
      end else if (sll)  begin  
         o_alu_op   = 6'b1_00111; 
         o_insn_vld = 1;   
      end else if (slt)  begin  
         o_alu_op   = 6'b1_00010; 
         o_insn_vld = 1;   
      end else if (sltu) begin 
         o_alu_op   = 6'b1_00011; 
         o_insn_vld = 1;   
      end else if (XOR) begin  
         o_alu_op   = 6'b1_00100; 
         o_insn_vld = 1;   
      end else if (srl) begin  
         o_alu_op   = 6'b1_01000; 
         o_insn_vld = 1;   
      end else if (sra) begin  
         o_alu_op   = 6'b1_01001; 
         o_insn_vld = 1;   
      end else if (OR)  begin   
         o_alu_op   = 6'b1_00101; 
         o_insn_vld = 1;   
      end else if (AND) begin  
         o_alu_op   = 6'b1_00110; 
         o_insn_vld = 1;
      end 
/*    
      else if (mul) begin  
         o_alu_op   = 5'b01011; 
         o_insn_vld = 1;
      end else if (mulh) begin  
         o_alu_op   = 5'b01100; 
         o_insn_vld = 1;
      end else if (mulhsu) begin  
         o_alu_op   = 5'b01101; 
         o_insn_vld = 1;
      end else if (mulhu) begin  
         o_alu_op   = 5'b01110; 
         o_insn_vld = 1;
      end else if (div) begin  
         o_alu_op   = 5'b01111; 
         o_insn_vld = 1;
      end else if (divu) begin  
         o_alu_op   = 5'b10000; 
         o_insn_vld = 1;
      end else if (rem) begin  
         o_alu_op   = 5'b10001; 
         o_insn_vld = 1;
      end else if (remu) begin  
         o_alu_op   = 5'b10010; 
         o_insn_vld = 1;
      end
*/
   end
   
   else if (lui) begin
      o_pc_sel       = 0; 
      o_rd_wren      = 1;        
      o_imm_sel      = 3'b100;
      o_br_un        = 0;  
      o_insn_vld     = 1; 
      o_br_sel       = 3'b000;
      o_opa_sel      = 0; 
      o_opb_sel      = 1; 
      o_alu_op       = 6'b1_01010; 
      o_mem_wren     = 0;      
      o_wb_sel       = 3'b001; 
      o_sl_sel       = 3'b000;
      o_fpu_vld      = 0;
      o_fpu_mem_wren = 0;
      o_fpu_rd_wren  = 0;
      o_fpu_data_sel = 2'b00;
      o_fpu_op       = 5'b00000;
   end
   
   else if (B_type) begin
      o_pc_sel       = 0;
      o_rd_wren      = 0; 
      o_imm_sel      = 3'b010;   
      o_insn_vld     = 1; 
      o_opa_sel      = 1; 
      o_opb_sel      = 1; 
      o_alu_op       = 6'b1_00000; 
      o_mem_wren     = 0; 
      o_wb_sel       = 3'b001; 
      o_sl_sel       = 3'b000;
      o_fpu_vld      = 0;
      o_fpu_mem_wren = 0;
      o_fpu_rd_wren  = 0;
      o_fpu_data_sel = 2'b00;
      o_fpu_op       = 5'b00000;
      if (beq) begin
         o_br_un  = 1; 
         o_br_sel = 3'b001;
      end else if (bne) begin
         o_br_un  = 1; 
         o_br_sel = 3'b010;
      end else if (blt) begin
         o_br_un  = 1; 
         o_br_sel = 3'b011;
      end else if (bge) begin
         o_br_un  = 1; 
         o_br_sel = 3'b100;
      end else if (bltu) begin
         o_br_un  = 0; 
         o_br_sel = 3'b101;
      end else if (bgeu) begin
         o_br_un  = 0; 
         o_br_sel = 3'b110;
      end
   end

   else if (jalr) begin   // jalr
      o_pc_sel       = 1; 
      o_rd_wren      = 1;       
      o_imm_sel      = 3'b000; 
      o_br_un        = 0;
      o_insn_vld     = 1;     
      o_opa_sel      = 0; 
      o_br_sel       = 3'b000;
      o_opb_sel      = 1; 
      o_alu_op       = 6'b1_00000; 
      o_mem_wren     = 0;      
      o_wb_sel       = 3'b000; 
      o_sl_sel       = 3'b000;
      o_fpu_vld      = 0;
      o_fpu_mem_wren = 0;
      o_fpu_rd_wren  = 0;
      o_fpu_data_sel = 2'b00;
      o_fpu_op       = 5'b00000;
   end
   
   else if (jal) begin    // jal
      o_pc_sel       = 1; 
      o_rd_wren      = 1;       
      o_imm_sel      = 3'b011; 
      o_br_un        = 0;
      o_insn_vld     = 1;     
      o_opa_sel      = 1; 
      o_br_sel       = 3'b000;
      o_opb_sel      = 1; 
      o_alu_op       = 6'b1_00000; 
      o_mem_wren     = 0;      
      o_wb_sel       = 3'b000; 
      o_sl_sel       = 3'b000;
      o_fpu_vld      = 0;
      o_fpu_mem_wren = 0;
      o_fpu_rd_wren  = 0;
      o_fpu_data_sel = 2'b00;
      o_fpu_op       = 5'b00000;
   end
   
   else if (R_type_83) begin
      o_pc_sel       = 0;       
      o_imm_sel      = 3'b000; 
      o_br_un        = 0;
      o_insn_vld     = 1;     
      o_opa_sel      = 1; 
      o_br_sel       = 3'b000;
      o_opb_sel      = 1; 
      o_mem_wren     = 0;      
      o_sl_sel       = 3'b000;
      o_fpu_mem_wren = 0;
      o_fpu_data_sel = 2'b00;
      
      if (fadd | fsub | fmul | fdiv | fsqrt | fsgnj | fsgnjn | fsgnjx | fmin | fmax | fcos | fsin | fcosh | fsinh | fatanh) begin
         o_rd_wren     = 0;
         o_alu_op      = 6'b0_00000;
         o_wb_sel      = 3'b010;
         o_fpu_vld     = 1;
         o_fpu_rd_wren = 1;
         if (fadd)   o_fpu_op = 6'd0;  else
         if (fsub)   o_fpu_op = 6'd1;  else
         if (fmul)   o_fpu_op = 6'd2;  else
         if (fdiv)   o_fpu_op = 6'd3;  else
         if (fsqrt)  o_fpu_op = 6'd4;  else
         if (fsgnj)  o_fpu_op = 6'd7;  else
         if (fsgnjn) o_fpu_op = 6'd8;  else
         if (fsgnjx) o_fpu_op = 6'd9;  else
         if (fmin)   o_fpu_op = 6'd10; else
         if (fmax)   o_fpu_op = 6'd11; else
         if (fcos)   o_fpu_op = 6'd16; else
         if (fsin)   o_fpu_op = 6'd17; else
         if (fcosh)  o_fpu_op = 6'd18; else
         if (fsinh)  o_fpu_op = 6'd19; else
         if (fatanh) o_fpu_op = 6'd20;
      end else
      
      if (feq | flt | fle) begin
         o_rd_wren     = 1;
         o_alu_op      = 6'b0_00000;
         o_wb_sel      = 3'b010;
         o_fpu_vld     = 1;
         o_fpu_rd_wren = 0;
         if (feq) o_fpu_op = 6'd12; else
         if (flt) o_fpu_op = 6'd13; else
         if (fle) o_fpu_op = 6'd14;
      end else
      
      if (fcvt_w_s) begin
         o_rd_wren     = 1;
         o_alu_op      = 6'b0_00000;
         o_wb_sel      = 3'b010;
         o_fpu_vld     = 1;
         o_fpu_rd_wren = 0;
         o_fpu_op      = 6'd5;
      end else
      
      if (fcvt_s_w) begin
         o_rd_wren     = 0;
         o_alu_op      = 6'b0_00000;
         o_wb_sel      = 3'b010;
         o_fpu_vld     = 1;
         o_fpu_rd_wren = 1;
         o_fpu_op      = 6'd6;
      end else
      
      if (fmv_x_w) begin
         o_rd_wren     = 1;
         o_alu_op      = 6'b1_01011;
         o_wb_sel      = 3'b001;
         o_fpu_vld     = 0;
         o_fpu_rd_wren = 0;
         o_fpu_op      = 6'd0;
      end else
      
      if (fmv_w_x) begin
         o_rd_wren     = 0;
         o_alu_op      = 6'b0_00000;
         o_wb_sel      = 3'b010;
         o_fpu_vld     = 1;
         o_fpu_rd_wren = 1;
         o_fpu_op      = 6'd15;
      end
   end else
   
   if (flw) begin
      o_pc_sel       = 0; 
      o_rd_wren      = 0;       
      o_imm_sel      = 3'b000; 
      o_br_un        = 0;
      o_insn_vld     = 1;     
      o_opa_sel      = 0; 
      o_br_sel       = 3'b000;
      o_opb_sel      = 1; 
      o_alu_op       = 6'b1_00000; 
      o_mem_wren     = 0;      
      o_wb_sel       = 3'b100; 
      o_sl_sel       = 3'b011;
      o_fpu_vld      = 0;
      o_fpu_mem_wren = 0;
      o_fpu_rd_wren  = 1;
      o_fpu_data_sel = 2'b00;
      o_fpu_op       = 5'b00000;
   end else
   
   if (fsw) begin
      o_pc_sel       = 0; 
      o_rd_wren      = 0;       
      o_imm_sel      = 3'b001; 
      o_br_un        = 0;
      o_insn_vld     = 1;     
      o_opa_sel      = 0; 
      o_br_sel       = 3'b000;
      o_opb_sel      = 1; 
      o_alu_op       = 6'b1_00000; 
      o_mem_wren     = 0;      
      o_wb_sel       = 3'b000; 
      o_sl_sel       = 3'b000;
      o_fpu_vld      = 0;
      o_fpu_mem_wren = 1;
      o_fpu_rd_wren  = 0;
      o_fpu_data_sel = 2'b00;
      o_fpu_op       = 5'b00000;
   end
end

assign o_bmask = {(sw | fsw), sh, sb};
assign o_ctrl = B_type | I_type_103 | J_type;

assign o_rs1_is_float = (R_type_83 & ~fmv_w_x & ~fcvt_s_w); 
assign o_rs2_is_float = (R_type_83 & ~fcvt_w_s & ~fcvt_s_w & ~fmv_x_w & ~fmv_w_x & ~fsqrt) | fsw;
   
endmodule

