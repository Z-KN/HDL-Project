debImport "-f" "file.filelist"
verdiDockWidgetDisplay -dock widgetDock_WelcomePage
verdiWindowWorkMode -win Verdi_1 -hardwareDebug
wvCreateWindow
wvConvertFile -win $_nWave2 -o \
           "/home/edauser/Processor/verification/target/test.vcd.fsdb" \
           "/home/edauser/Processor/verification/target/test.vcd"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvOpenFile -win $_nWave2 \
           {/home/edauser/Processor/verification/target/test.vcd.fsdb}
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/tb"
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/tb/clk} \
{/tb/rst_b} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 1 2 )} 
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/tb/clk} \
{/tb/rst_b} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 1 2 )} 
wvSetPosition -win $_nWave2 {("G1" 2)}
wvGetSignalClose -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 309754.943067 537897.805326
wvZoom -win $_nWave2 401305.384580 439014.948589
wvZoom -win $_nWave2 413113.429875 423120.834833
wvZoom -win $_nWave2 416596.264108 418461.739963
verdiDockWidgetHide -dock windowDock_nWave_2
verdiDockWidgetHide -dock widgetDock_MTB_SOURCE_TAB_1
verdiDockWidgetHide -dock widgetDock_<Inst._Tree>
verdiDockWidgetHide -dock widgetDock_<Decl._Tree>
verdiDockWidgetHide -dock widgetDock_<Message>
debExit
