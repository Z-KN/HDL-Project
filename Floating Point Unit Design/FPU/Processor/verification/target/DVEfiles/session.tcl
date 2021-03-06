# Begin_DVE_Session_Save_Info
# DVE full session
# Saved on Sat Nov 7 13:32:39 2020
# Designs open: 1
#   Sim: /mnt/hgfs/SF/FPU/Processor/verification/target/simv
# Toplevel windows open: 1
# 	TopLevel.1
#   Source.1: tb.unnamed$$_13
#   Group count = 1
#   Group Group1 signal count = 56
# End_DVE_Session_Save_Info

# DVE version: G-2012.09
# DVE build date: Aug 24 2012 00:30:46


#<Session mode="Full" path="/mnt/hgfs/SF/FPU/Processor/verification/target/DVEfiles/session.tcl" type="Debug">

gui_set_loading_session_type Post
gui_continuetime_set

# Close design
if { [gui_sim_state -check active] } {
    gui_sim_terminate
}
gui_close_db -all
gui_expr_clear_all

# Close all windows
gui_close_window -type Console
gui_close_window -type Wave
gui_close_window -type Source
gui_close_window -type Schematic
gui_close_window -type Data
gui_close_window -type DriverLoad
gui_close_window -type List
gui_close_window -type Memory
gui_close_window -type HSPane
gui_close_window -type DLPane
gui_close_window -type Assertion
gui_close_window -type CovHier
gui_close_window -type CoverageTable
gui_close_window -type CoverageMap
gui_close_window -type CovDetail
gui_close_window -type Local
gui_close_window -type Stack
gui_close_window -type Watch
gui_close_window -type Group
gui_close_window -type Transaction



# Application preferences
gui_set_pref_value -key app_default_font -value {Helvetica,10,-1,5,50,0,0,0,0,0}
gui_src_preferences -tabstop 8 -maxbits 24 -windownumber 1
#<WindowLayout>

# DVE Topleve session: 


# Create and position top-level windows :TopLevel.1

if {![gui_exist_window -window TopLevel.1]} {
    set TopLevel.1 [ gui_create_window -type TopLevel \
       -icon $::env(DVE)/auxx/gui/images/toolbars/dvewin.xpm] 
} else { 
    set TopLevel.1 TopLevel.1
}
gui_show_window -window ${TopLevel.1} -show_state normal -rect {{43 132} {1715 822}}

# ToolBar settings
gui_set_toolbar_attributes -toolbar {TimeOperations} -dock_state top
gui_set_toolbar_attributes -toolbar {TimeOperations} -offset 0
gui_show_toolbar -toolbar {TimeOperations}
gui_set_toolbar_attributes -toolbar {&File} -dock_state top
gui_set_toolbar_attributes -toolbar {&File} -offset 0
gui_show_toolbar -toolbar {&File}
gui_set_toolbar_attributes -toolbar {&Edit} -dock_state top
gui_set_toolbar_attributes -toolbar {&Edit} -offset 0
gui_show_toolbar -toolbar {&Edit}
gui_set_toolbar_attributes -toolbar {Simulator} -dock_state top
gui_set_toolbar_attributes -toolbar {Simulator} -offset 0
gui_show_toolbar -toolbar {Simulator}
gui_set_toolbar_attributes -toolbar {Interactive Rewind} -dock_state top
gui_set_toolbar_attributes -toolbar {Interactive Rewind} -offset 0
gui_show_toolbar -toolbar {Interactive Rewind}
gui_set_toolbar_attributes -toolbar {Signal} -dock_state top
gui_set_toolbar_attributes -toolbar {Signal} -offset 0
gui_show_toolbar -toolbar {Signal}
gui_set_toolbar_attributes -toolbar {&Scope} -dock_state top
gui_set_toolbar_attributes -toolbar {&Scope} -offset 0
gui_show_toolbar -toolbar {&Scope}
gui_set_toolbar_attributes -toolbar {&Trace} -dock_state top
gui_set_toolbar_attributes -toolbar {&Trace} -offset 0
gui_show_toolbar -toolbar {&Trace}
gui_set_toolbar_attributes -toolbar {BackTrace} -dock_state top
gui_set_toolbar_attributes -toolbar {BackTrace} -offset 0
gui_show_toolbar -toolbar {BackTrace}
gui_set_toolbar_attributes -toolbar {Testbench} -dock_state top
gui_set_toolbar_attributes -toolbar {Testbench} -offset 0
gui_show_toolbar -toolbar {Testbench}
gui_set_toolbar_attributes -toolbar {&Window} -dock_state top
gui_set_toolbar_attributes -toolbar {&Window} -offset 0
gui_show_toolbar -toolbar {&Window}
gui_set_toolbar_attributes -toolbar {Zoom} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom} -offset 0
gui_show_toolbar -toolbar {Zoom}
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -offset 0
gui_show_toolbar -toolbar {Zoom And Pan History}
gui_set_toolbar_attributes -toolbar {Grid} -dock_state top
gui_set_toolbar_attributes -toolbar {Grid} -offset 0
gui_show_toolbar -toolbar {Grid}

# End ToolBar settings

# Docked window settings
set HSPane.1 [gui_create_window -type HSPane -parent ${TopLevel.1} -dock_state left -dock_on_new_line true -dock_extent 185]
catch { set Hier.1 [gui_share_window -id ${HSPane.1} -type Hier] }
catch { set Stack.1 [gui_share_window -id ${HSPane.1} -type Stack -silent] }
catch { set Class.1 [gui_share_window -id ${HSPane.1} -type Class -silent] }
catch { set Object.1 [gui_share_window -id ${HSPane.1} -type Object -silent] }
gui_set_window_pref_key -window ${HSPane.1} -key dock_width -value_type integer -value 185
gui_set_window_pref_key -window ${HSPane.1} -key dock_height -value_type integer -value -1
gui_set_window_pref_key -window ${HSPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${HSPane.1} {{left 0} {top 0} {width 184} {height 428} {dock_state left} {dock_on_new_line true} {child_hier_colhier 163} {child_hier_coltype 68} {child_hier_colpd 0} {child_hier_col1 0} {child_hier_col2 1} {child_hier_col3 -1}}
set DLPane.1 [gui_create_window -type DLPane -parent ${TopLevel.1} -dock_state left -dock_on_new_line true -dock_extent 519]
catch { set Data.1 [gui_share_window -id ${DLPane.1} -type Data] }
catch { set Local.1 [gui_share_window -id ${DLPane.1} -type Local -silent] }
catch { set Member.1 [gui_share_window -id ${DLPane.1} -type Member -silent] }
gui_set_window_pref_key -window ${DLPane.1} -key dock_width -value_type integer -value 519
gui_set_window_pref_key -window ${DLPane.1} -key dock_height -value_type integer -value 428
gui_set_window_pref_key -window ${DLPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${DLPane.1} {{left 0} {top 0} {width 518} {height 428} {dock_state left} {dock_on_new_line true} {child_data_colvariable 214} {child_data_colvalue 198} {child_data_coltype 128} {child_data_col1 0} {child_data_col2 1} {child_data_col3 2}}
set Console.1 [gui_create_window -type Console -parent ${TopLevel.1} -dock_state bottom -dock_on_new_line true -dock_extent 156]
gui_set_window_pref_key -window ${Console.1} -key dock_width -value_type integer -value 1658
gui_set_window_pref_key -window ${Console.1} -key dock_height -value_type integer -value 156
gui_set_window_pref_key -window ${Console.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${Console.1} {{left 0} {top 0} {width 1672} {height 155} {dock_state bottom} {dock_on_new_line true}}
#### Start - Readjusting docked view's offset / size
set dockAreaList { top left right bottom }
foreach dockArea $dockAreaList {
  set viewList [gui_ekki_get_window_ids -active_parent -dock_area $dockArea]
  foreach view $viewList {
      if {[lsearch -exact [gui_get_window_pref_keys -window $view] dock_width] != -1} {
        set dockWidth [gui_get_window_pref_value -window $view -key dock_width]
        set dockHeight [gui_get_window_pref_value -window $view -key dock_height]
        set offset [gui_get_window_pref_value -window $view -key dock_offset]
        if { [string equal "top" $dockArea] || [string equal "bottom" $dockArea]} {
          gui_set_window_attributes -window $view -dock_offset $offset -width $dockWidth
        } else {
          gui_set_window_attributes -window $view -dock_offset $offset -height $dockHeight
        }
      }
  }
}
#### End - Readjusting docked view's offset / size
gui_sync_global -id ${TopLevel.1} -option true

# MDI window settings
set Source.1 [gui_create_window -type {Source}  -parent ${TopLevel.1}]
gui_show_window -window ${Source.1} -show_state maximized
gui_update_layout -id ${Source.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false}}

# End MDI window settings

gui_set_env TOPLEVELS::TARGET_FRAME(Source) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(Schematic) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(PathSchematic) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(Wave) none
gui_set_env TOPLEVELS::TARGET_FRAME(List) none
gui_set_env TOPLEVELS::TARGET_FRAME(Memory) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(DriverLoad) none
gui_update_statusbar_target_frame ${TopLevel.1}

#</WindowLayout>

#<Database>

# DVE Open design session: 

if { [llength [lindex [gui_get_db -design Sim] 0]] == 0 } {
gui_set_env SIMSETUP::SIMARGS {{-cm line+cond+fsm+branch+tgl}}
gui_set_env SIMSETUP::SIMEXE {./simv}
gui_set_env SIMSETUP::ALLOW_POLL {0}
if { ![gui_is_db_opened -db {/mnt/hgfs/SF/FPU/Processor/verification/target/simv}] } {
gui_sim_run Ucli -exe simv -args { -cm line+cond+fsm+branch+tgl -ucligui} -dir /mnt/hgfs/SF/FPU/Processor/verification/target -nosource
}
}
if { ![gui_sim_state -check active] } {error "Simulator did not start correctly" error}
gui_set_precision 100ps
gui_set_time_units 100ps
#</Database>

# DVE Global setting session: 


# Global: Breakpoints

# Global: Bus

# Global: Expressions

# Global: Signal Time Shift

# Global: Signal Compare

# Global: Signal Groups
gui_load_child_values {tb.x_processor}


set _session_group_1 Group1
gui_sg_create "$_session_group_1"
set Group1 "$_session_group_1"

gui_sg_addsignal -group "$_session_group_1" { tb.x_processor.cpu_clock tb.x_processor.cpu_reset_b tb.x_processor.instruction tb.x_processor.rdata tb.x_processor.result tb.x_processor.exception tb.x_processor.data_FPR tb.x_processor.ins_fetch_req tb.x_processor.ins_pc tb.x_processor.data_access_req tb.x_processor.data_address tb.x_processor.wen tb.x_processor.wdata tb.x_processor.fpu_instr tb.x_processor.data_GPR tb.x_processor.argument tb.x_processor.opcode tb.x_processor.fmt tb.x_processor.ft tb.x_processor.rs tb.x_processor.rt tb.x_processor.fs tb.x_processor.fd tb.x_processor.func tb.x_processor.imm tb.x_processor.rdata_temp tb.x_processor.op_lui tb.x_processor.op_ori tb.x_processor.op_cop1 tb.x_processor.func_add tb.x_processor.func_sub tb.x_processor.func_mul tb.x_processor.func_div tb.x_processor.func_cvtps tb.x_processor.func_cvts tb.x_processor.func_cvtw tb.x_processor.func_cvtspl tb.x_processor.func_cvtspu tb.x_processor.fmt_s tb.x_processor.fmt_ps tb.x_processor.fmt_w tb.x_processor.idle tb.x_processor.adds tb.x_processor.addps tb.x_processor.subs tb.x_processor.subps tb.x_processor.muls tb.x_processor.mulps tb.x_processor.divs tb.x_processor.cvtpss tb.x_processor.cvtsw tb.x_processor.cvtws tb.x_processor.cvtspl tb.x_processor.cvtspu tb.x_processor.mfc1 tb.x_processor.mtc1 }
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.op_lui}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.op_lui}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.op_ori}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.op_ori}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.op_cop1}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.op_cop1}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.func_add}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.func_add}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.func_sub}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.func_sub}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.func_mul}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.func_mul}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.func_div}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.func_div}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.func_cvtps}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.func_cvtps}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.func_cvts}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.func_cvts}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.func_cvtw}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.func_cvtw}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.func_cvtspl}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.func_cvtspl}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.func_cvtspu}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.func_cvtspu}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.fmt_s}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.fmt_s}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.fmt_ps}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.fmt_ps}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.fmt_w}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.fmt_w}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.idle}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.idle}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.adds}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.adds}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.addps}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.addps}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.subs}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.subs}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.subps}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.subps}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.muls}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.muls}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.mulps}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.mulps}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.divs}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.divs}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.cvtpss}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.cvtpss}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.cvtsw}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.cvtsw}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.cvtws}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.cvtws}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.cvtspl}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.cvtspl}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.cvtspu}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.cvtspu}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.mfc1}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.mfc1}
gui_set_radix -radix {decimal} -signals {Sim:tb.x_processor.mtc1}
gui_set_radix -radix {unsigned} -signals {Sim:tb.x_processor.mtc1}

# Global: Highlighting

# Global: Stack
gui_change_stack_mode -mode list

# Post database loading setting...

# Restore C1 time
gui_set_time -C1_only 3052



# Save global setting...

# Wave/List view global setting
gui_cov_show_value -switch false

# Close all empty TopLevel windows
foreach __top [gui_ekki_get_window_ids -type TopLevel] {
    if { [llength [gui_ekki_get_window_ids -parent $__top]] == 0} {
        gui_close_window -window $__top
    }
}
gui_set_loading_session_type noSession
# DVE View/pane content session: 


# Hier 'Hier.1'
gui_show_window -window ${Hier.1}
gui_list_set_filter -id ${Hier.1} -list { {Package 1} {All 0} {Process 1} {UnnamedProcess 1} {Function 1} {Block 1} {OVA Unit 1} {LeafScCell 1} {LeafVlgCell 1} {Interface 1} {PowSwitch 0} {LeafVhdCell 1} {$unit 1} {NamedBlock 1} {Task 1} {VlgPackage 1} {IsoCell 0} {ClassDef 1} }
gui_list_set_filter -id ${Hier.1} -text {*}
gui_hier_list_init -id ${Hier.1}
gui_change_design -id ${Hier.1} -design Sim
catch {gui_list_expand -id ${Hier.1} tb}
catch {gui_list_select -id ${Hier.1} {tb.x_processor}}
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Class 'Class.1'
gui_list_set_filter -id ${Class.1} -list { {OVM 1} {VMM 1} {All 1} {Object 1} {UVM 1} {RVM 1} }
gui_list_set_filter -id ${Class.1} -text {*}
gui_change_design -id ${Class.1} -design Sim

# Member 'Member.1'
gui_list_set_filter -id ${Member.1} -list { {InternalMember 0} {RandMember 1} {All 0} {BaseMember 0} {PrivateMember 1} {AutomaticMember 1} {VirtualMember 1} {PublicMember 1} {ProtectedMember 1} {StaticMember 1} }
gui_list_set_filter -id ${Member.1} -text {*}

# Data 'Data.1'
gui_list_set_filter -id ${Data.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {LowPower 1} {Parameter 1} {All 1} {Aggregate 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Data.1} -text {*}
gui_list_show_data -id ${Data.1} {tb.x_processor}
gui_show_window -window ${Data.1}
catch { gui_list_select -id ${Data.1} {tb.x_processor.cpu_clock tb.x_processor.cpu_reset_b tb.x_processor.instruction tb.x_processor.rdata tb.x_processor.result tb.x_processor.exception tb.x_processor.data_FPR tb.x_processor.ins_fetch_req tb.x_processor.ins_pc tb.x_processor.data_access_req tb.x_processor.data_address tb.x_processor.wen tb.x_processor.wdata tb.x_processor.fpu_instr tb.x_processor.data_GPR tb.x_processor.argument tb.x_processor.opcode tb.x_processor.fmt tb.x_processor.ft tb.x_processor.rs tb.x_processor.rt tb.x_processor.fs tb.x_processor.fd tb.x_processor.func tb.x_processor.imm tb.x_processor.rdata_temp tb.x_processor.op_lui tb.x_processor.op_ori tb.x_processor.op_cop1 tb.x_processor.func_add tb.x_processor.func_sub tb.x_processor.func_mul tb.x_processor.func_div tb.x_processor.func_cvtps tb.x_processor.func_cvts tb.x_processor.func_cvtw tb.x_processor.func_cvtspl tb.x_processor.func_cvtspu tb.x_processor.fmt_s tb.x_processor.fmt_ps tb.x_processor.fmt_w tb.x_processor.idle tb.x_processor.adds tb.x_processor.addps tb.x_processor.subs tb.x_processor.subps tb.x_processor.muls tb.x_processor.mulps tb.x_processor.divs tb.x_processor.cvtpss tb.x_processor.cvtsw tb.x_processor.cvtws tb.x_processor.cvtspl tb.x_processor.cvtspu tb.x_processor.mfc1 tb.x_processor.mtc1 }}
gui_view_scroll -id ${Data.1} -vertical -set 0
gui_view_scroll -id ${Data.1} -horizontal -set 0
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Source 'Source.1'
gui_src_value_annotate -id ${Source.1} -switch false
gui_set_env TOGGLE::VALUEANNOTATE 0
gui_open_source -id ${Source.1}  -replace -active {tb.unnamed$$_13} /mnt/hgfs/SF/FPU/Processor/testbench/tb.v
gui_view_scroll -id ${Source.1} -vertical -set 1458
gui_src_set_reusable -id ${Source.1}
# Warning: Class view not found.
# Restore toplevel window zorder
# The toplevel window could be closed if it has no view/pane
if {[gui_exist_window -window ${TopLevel.1}]} {
	gui_set_active_window -window ${TopLevel.1}
	gui_set_active_window -window ${Source.1}
	gui_set_active_window -window ${DLPane.1}
}
#</Session>

