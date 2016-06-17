onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color {Orange Red} -label clk -radix unsigned /uebung5_tb/clk
add wave -noupdate -color Gold /uebung5_tb/rst
add wave -noupdate -label a -radix unsigned /uebung5_tb/a
add wave -noupdate -label b -radix unsigned /uebung5_tb/b
add wave -noupdate -label c -radix unsigned /uebung5_tb/c
add wave -noupdate -label d -radix unsigned /uebung5_tb/d
add wave -noupdate -label e -radix unsigned /uebung5_tb/e
add wave -noupdate -label x -radix unsigned /uebung5_tb/x
add wave -noupdate -label z -radix unsigned /uebung5_tb/z
add wave -noupdate -label y -radix unsigned /uebung5_tb/y
add wave -noupdate -label ready -radix unsigned /uebung5_tb/ready
add wave -noupdate -label current /uebung5_tb/uebung5/current_state
add wave -noupdate -label next /uebung5_tb/uebung5/next_state
add wave -noupdate -label s_alle -radix unsigned /uebung5_tb/uebung5/s_all_without_multi
add wave -noupdate -label s_mutliplikation -radix unsigned /uebung5_tb/uebung5/s_multi
add wave -noupdate -divider Subtrahierer
add wave -noupdate -label a -radix unsigned /uebung5_tb/uebung5/subtrahierer/a
add wave -noupdate -label b -radix unsigned /uebung5_tb/uebung5/subtrahierer/b
add wave -noupdate -label q -radix unsigned /uebung5_tb/uebung5/subtrahierer/q
add wave -noupdate -divider Multiplizierer
add wave -noupdate -label a -radix unsigned /uebung5_tb/uebung5/multiplizierer/a
add wave -noupdate -label b -radix unsigned /uebung5_tb/uebung5/multiplizierer/b
add wave -noupdate -label q -radix unsigned /uebung5_tb/uebung5/multiplizierer/q
add wave -noupdate -divider Addierer2
add wave -noupdate -label a -radix unsigned /uebung5_tb/uebung5/addierer_2/a
add wave -noupdate -label b -radix unsigned /uebung5_tb/uebung5/addierer_2/b
add wave -noupdate -label q -radix unsigned /uebung5_tb/uebung5/addierer_2/q
add wave -noupdate -divider Addierer3
add wave -noupdate -label a -radix unsigned /uebung5_tb/uebung5/addierer_3/a
add wave -noupdate -label b -radix unsigned /uebung5_tb/uebung5/addierer_3/b
add wave -noupdate -label q -radix unsigned /uebung5_tb/uebung5/addierer_3/q
add wave -noupdate -divider Addierer1
add wave -noupdate -label a -radix unsigned /uebung5_tb/uebung5/addierer_1/a
add wave -noupdate -label b -radix unsigned /uebung5_tb/uebung5/addierer_1/b
add wave -noupdate -label q -radix unsigned -childformat {{/uebung5_tb/uebung5/addierer_1/q(31) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(30) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(29) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(28) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(27) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(26) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(25) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(24) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(23) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(22) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(21) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(20) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(19) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(18) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(17) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(16) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(15) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(14) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(13) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(12) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(11) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(10) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(9) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(8) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(7) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(6) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(5) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(4) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(3) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(2) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(1) -radix unsigned} {/uebung5_tb/uebung5/addierer_1/q(0) -radix unsigned}} -subitemconfig {/uebung5_tb/uebung5/addierer_1/q(31) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(30) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(29) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(28) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(27) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(26) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(25) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(24) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(23) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(22) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(21) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(20) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(19) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(18) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(17) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(16) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(15) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(14) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(13) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(12) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(11) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(10) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(9) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(8) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(7) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(6) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(5) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(4) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(3) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(2) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(1) {-height 16 -radix unsigned} /uebung5_tb/uebung5/addierer_1/q(0) {-height 16 -radix unsigned}} /uebung5_tb/uebung5/addierer_1/q
add wave -noupdate -divider v4v6
add wave -noupdate -label we -radix unsigned /uebung5_tb/uebung5/v4v6/we
add wave -noupdate -label a -radix unsigned /uebung5_tb/uebung5/v4v6/a
add wave -noupdate -label q -radix unsigned /uebung5_tb/uebung5/v4v6/q
add wave -noupdate -divider v3v5
add wave -noupdate -label we -radix unsigned /uebung5_tb/uebung5/v3v5/we
add wave -noupdate -label a -radix unsigned /uebung5_tb/uebung5/v3v5/a
add wave -noupdate -label q -radix unsigned /uebung5_tb/uebung5/v3v5/q
add wave -noupdate -divider v1v10
add wave -noupdate -label we -radix unsigned /uebung5_tb/uebung5/v1v10/we
add wave -noupdate -label a -radix unsigned /uebung5_tb/uebung5/v1v10/a
add wave -noupdate -label q -radix unsigned /uebung5_tb/uebung5/v1v10/q
add wave -noupdate -divider v1v7
add wave -noupdate -label we -radix unsigned /uebung5_tb/uebung5/v1v7/we
add wave -noupdate -label a -radix unsigned /uebung5_tb/uebung5/v1v7/a
add wave -noupdate -label q -radix unsigned /uebung5_tb/uebung5/v1v7/q
add wave -noupdate -divider V5V7
add wave -noupdate -label we -radix unsigned /uebung5_tb/uebung5/v5v7/we
add wave -noupdate -label a -radix unsigned /uebung5_tb/uebung5/v5v7/a
add wave -noupdate -label q -radix unsigned /uebung5_tb/uebung5/v5v7/q
add wave -noupdate -divider v6v8
add wave -noupdate -label we -radix unsigned /uebung5_tb/uebung5/v6v8/we
add wave -noupdate -label a -radix unsigned /uebung5_tb/uebung5/v6v8/a
add wave -noupdate -label q -radix unsigned /uebung5_tb/uebung5/v6v8/q
add wave -noupdate -divider v9v10
add wave -noupdate -label we -radix unsigned /uebung5_tb/uebung5/v9v10/we
add wave -noupdate -label a -radix unsigned /uebung5_tb/uebung5/v9v10/a
add wave -noupdate -label q -radix unsigned /uebung5_tb/uebung5/v9v10/q
add wave -noupdate -divider v7v9
add wave -noupdate -label we -radix unsigned /uebung5_tb/uebung5/v7v9/we
add wave -noupdate -label a -radix unsigned /uebung5_tb/uebung5/v7v9/a
add wave -noupdate -label q -radix unsigned /uebung5_tb/uebung5/v7v9/q
add wave -noupdate -divider V2V5
add wave -noupdate -label we -radix unsigned /uebung5_tb/uebung5/v2v5/we
add wave -noupdate -label a -radix unsigned /uebung5_tb/uebung5/v2v5/a
add wave -noupdate -label q -radix unsigned /uebung5_tb/uebung5/v2v5/q
add wave -noupdate -divider y_Register
add wave -noupdate -label we -radix unsigned /uebung5_tb/uebung5/y_ausgangs_reg/we
add wave -noupdate -label a -radix unsigned /uebung5_tb/uebung5/y_ausgangs_reg/a
add wave -noupdate -label q -radix unsigned /uebung5_tb/uebung5/y_ausgangs_reg/q
add wave -noupdate -divider z_register
add wave -noupdate -label we -radix unsigned /uebung5_tb/uebung5/z_ausgang_reg/we
add wave -noupdate -label a -radix unsigned /uebung5_tb/uebung5/z_ausgang_reg/a
add wave -noupdate -label q -radix unsigned /uebung5_tb/uebung5/z_ausgang_reg/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {57062 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {241584 ps}
