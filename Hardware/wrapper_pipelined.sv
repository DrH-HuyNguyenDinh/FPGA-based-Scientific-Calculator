module wrapper_pipelined (
   input logic CLOCK_50,
   input logic [3:0] KEY,

   inout logic PS2_CLK, PS2_DAT,

   output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
   output logic [9:0]  LEDR,
   output logic [31:0] GPIO,

   output logic        o_mispred, o_ctrl,
   output logic [31:0] o_pc_debug,  // Debug program counter.
   output logic        o_insn_vld,  // Instruction valid.
   output logic [31:0] o_io_ledg,   // Output for driving green LEDs.
   output logic [6:0]  o_io_hex6,   // Output for driving 7-segment LED6 displays.
   output logic [6:0]  o_io_hex7    // Output for driving 7-segment LED7 displays.
);

logic clk;
logic [7:0] pre_raw_scan_code;
logic [7:0] ps2_scan_code_latched;
logic       data_ready, data_error, data_busy;
logic       ps2_valid_latched;
logic       ps2_error_latched;
logic [7:0] ps2_seq;

PLL_20MHz pll20mhz (
   .refclk   (CLOCK_50),
   .rst      (~KEY[3]),
   .outclk_0 (clk)
);

ps2_host u0 (
  .sys_clk  (clk),
  .sys_rst  (~KEY[3]),
  .ps2_clk  (PS2_CLK),
  .ps2_data (PS2_DAT),
  .tx_data  (8'h00),
  .send_req (1'b0),
  .rx_data  (pre_raw_scan_code),
  .ready    (data_ready),
  .busy     (data_busy),
  .error    (data_error)
);

always_ff @(posedge clk or negedge KEY[3]) begin
   if (~KEY[3]) begin
      ps2_scan_code_latched <= 8'h00;
      ps2_valid_latched     <= 1'b0;
      ps2_error_latched     <= 1'b0;
      ps2_seq               <= 8'h00;
   end else if (data_ready) begin
      ps2_scan_code_latched <= pre_raw_scan_code;
      ps2_valid_latched     <= 1'b1;
      ps2_error_latched     <= data_error;
      ps2_seq               <= ps2_seq + 8'h01;
   end
end

pipelined pipelined (
   .i_clk      (clk),
   .i_reset    (KEY[3]),
   .i_io_sw    ({14'b0, ps2_seq, ps2_error_latched, ps2_valid_latched, ps2_scan_code_latched}),
   .i_io_key   ({30'b0, KEY[1:0]}),

   .o_pc_debug (o_pc_debug),
   .o_insn_vld (o_insn_vld),
   .o_io_ledr  (LEDR),
   .o_io_ledg  (o_io_ledg),
   .o_io_hex0  (HEX0),
   .o_io_hex1  (HEX1),
   .o_io_hex2  (HEX2),
   .o_io_hex3  (HEX3),
   .o_io_hex4  (HEX4),
   .o_io_hex5  (HEX5),
   .o_io_hex6  (o_io_hex6),
   .o_io_hex7  (o_io_hex7),
   .o_io_lcd   (GPIO),
   .o_mispred  (o_mispred),
   .o_ctrl     (o_ctrl)
);

endmodule
