set_global_assignment -entity "PLL_20MHz" -library "lib_PLL_20MHz" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "PLL_20MHz" -library "lib_PLL_20MHz" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "PLL_20MHz" -library "lib_PLL_20MHz" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_PLL_20MHz" -name SPD_FILE [file join $::quartus(sip_path) "PLL_20MHz.spd"]

set_global_assignment -library "lib_PLL_20MHz" -name MISC_FILE [file join $::quartus(sip_path) "PLL_20MHz_sim/PLL_20MHz.vo"]
