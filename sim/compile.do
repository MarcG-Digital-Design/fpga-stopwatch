# Run in the Questa/ModelSim Transcript: do path/to/sim/compile.do
# Compiles the existing RTL only; this script is not a testbench.
onerror {error "RTL compilation failed. See the Transcript."}
set script_dir [file dirname [file normalize [info script]]]
set repo_dir [file normalize [file join $script_dir ..]]
cd $script_dir
if {![file exists work]} {vlib work}
vmap work work
foreach source {mux.vhd double_dabble.vhd counter_minute.vhd diviseur_seconde.vhd Chronometre.vhd} {
    vcom -93 -work work [file join $repo_dir rtl $source]
}
puts "RTL compiled. No functional simulation has been run."
