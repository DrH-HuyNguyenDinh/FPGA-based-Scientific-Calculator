# create_clock -waveform {0 25} -period 50 -name i_clk [get_ports {i_clk}]

create_clock -period 20 -name CLOCK_50 [get_ports {CLOCK_50}]
derive_pll_clocks

set input_ports [get_ports {KEY[*] PS2_CLK PS2_DAT}]
set_input_delay -clock pll20mhz|pll_20mhz_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk -max 15.000 $input_ports
set_input_delay -clock pll20mhz|pll_20mhz_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk -min 5.000  $input_ports

set output_ports [get_ports { \
    LEDR[*] HEX0[*] HEX1[*] HEX2[*] HEX3[*] HEX4[*] HEX5[*] PS2_CLK PS2_DAT \
    o_io_hex6[*] o_io_hex7[*] GPIO[*] o_pc_debug[*] \
    o_insn_vld o_io_ledg[*] o_mispred o_ctrl \
}]
set_output_delay -clock pll20mhz|pll_20mhz_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk -max 10.000 $output_ports
set_output_delay -clock pll20mhz|pll_20mhz_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk -min -2.000 $output_ports