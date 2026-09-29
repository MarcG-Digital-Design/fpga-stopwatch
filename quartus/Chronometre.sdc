# 50 MHz board oscillator: period = 20 ns.
create_clock -name MAX10_CLK1_50 -period 20.000 [get_ports {MAX10_CLK1_50}]
derive_clock_uncertainty
# External switch and display timing constraints must be reviewed for hardware sign-off.
