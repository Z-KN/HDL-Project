debImport "/home/edauser/Processor/testbench/tb.v" -path \
          {/home/edauser/Processor/testbench}
srcSignalView -on
srcSignalViewSelect "tb.data_access_req"
srcSignalViewSelect "tb.j"
srcSignalViewSelect "tb.j"
srcSignalViewSelect "tb.instruction\[31:0\]"
srcSignalViewSelect "tb.instruction\[31:0\]"
srcSignalViewSelect "tb.instruction\[31:0\]"
debLoadSimResult /home/edauser/Processor/verification/target/test.vcd.fsdb
srcSignalViewSelect "tb.instruction\[31:0\]"
wvCreateWindow
srcSignalViewAddSelectedToWave -win $_nTrace1
srcSignalViewSelect "tb.instruction\[31:0\]"
srcSignalViewSelect "tb.instruction\[31:0\]"
srcSignalViewSelect "tb.data_access_req"
srcSignalViewSelect "tb.data_access_req" "tb.ins_fetch_req"
srcSignalViewSelect "tb.data_access_req" "tb.ins_fetch_req" "tb.wen"
srcSignalViewSelect "tb.data_access_req" "tb.ins_fetch_req" "tb.wen" \
           "tb.data_address\[31:0\]"
srcSignalViewSelect "tb.data_access_req" "tb.ins_fetch_req" "tb.wen" \
           "tb.data_address\[31:0\]" "tb.ins_pc\[31:0\]"
srcSignalViewSelect "tb.data_access_req" "tb.ins_fetch_req" "tb.wen" \
           "tb.data_address\[31:0\]" "tb.ins_pc\[31:0\]" \
           "tb.instruction\[31:0\]"
srcSignalViewSelect "tb.data_access_req" "tb.ins_fetch_req" "tb.wen" \
           "tb.data_address\[31:0\]" "tb.ins_pc\[31:0\]" \
           "tb.instruction\[31:0\]" "tb.rdata\[31:0\]"
srcSignalViewSelect "tb.data_access_req" "tb.ins_fetch_req" "tb.wen" \
           "tb.data_address\[31:0\]" "tb.ins_pc\[31:0\]" \
           "tb.instruction\[31:0\]" "tb.rdata\[31:0\]" "tb.wdata\[31:0\]"
srcSignalViewSelect "tb.data_access_req" "tb.ins_fetch_req" "tb.wen" \
           "tb.data_address\[31:0\]" "tb.ins_pc\[31:0\]" \
           "tb.instruction\[31:0\]" "tb.rdata\[31:0\]" "tb.wdata\[31:0\]" \
           "tb.clk"
srcSignalViewSelect "tb.data_access_req" "tb.ins_fetch_req" "tb.wen" \
           "tb.data_address\[31:0\]" "tb.ins_pc\[31:0\]" \
           "tb.instruction\[31:0\]" "tb.rdata\[31:0\]" "tb.wdata\[31:0\]" \
           "tb.clk" "tb.i"
srcSignalViewSelect "tb.data_access_req" "tb.ins_fetch_req" "tb.wen" \
           "tb.data_address\[31:0\]" "tb.ins_pc\[31:0\]" \
           "tb.instruction\[31:0\]" "tb.rdata\[31:0\]" "tb.wdata\[31:0\]" \
           "tb.clk" "tb.i" "tb.j"
srcSignalViewSelect "tb.data_access_req" "tb.ins_fetch_req" "tb.wen" \
           "tb.data_address\[31:0\]" "tb.ins_pc\[31:0\]" \
           "tb.instruction\[31:0\]" "tb.rdata\[31:0\]" "tb.wdata\[31:0\]" \
           "tb.clk" "tb.i" "tb.j" "tb.rst_b"
srcSignalViewSelect "tb.data_access_req" "tb.ins_fetch_req" "tb.wen" \
           "tb.data_address\[31:0\]" "tb.ins_pc\[31:0\]" \
           "tb.instruction\[31:0\]" "tb.rdata\[31:0\]" "tb.wdata\[31:0\]" \
           "tb.clk" "tb.i" "tb.j" "tb.rst_b"
srcSignalViewAddSelectedToWave -win $_nTrace1
wvSetCursor -win $_nWave2 1631.055394 -snap {("G1" 9)}
wvSetCursor -win $_nWave2 2935.899709 -snap {("G1" 10)}
wvSetCursor -win $_nWave2 4110.259593 -snap {("G1" 10)}
wvSetCursor -win $_nWave2 5219.377261 -snap {("G1" 10)}
wvSetCursor -win $_nWave2 7307.128165 -snap {("G1" 10)}
wvSetCursor -win $_nWave2 9525.363501 -snap {("G1" 10)}
srcActiveTrace "tb.clk" -win $_nTrace1 -TraceByDConWave -TraceTime 9550 \
           -TraceValue 1
nsMsgSwitchTab -tab trace
wvSetCursor -win $_nWave2 9721.090149 -snap {("G1" 10)}
srcActiveTrace "tb.clk" -win $_nTrace1 -TraceByDConWave -TraceTime 9550 \
           -TraceValue 1
wvSetCursor -win $_nWave2 10960.692248 -snap {("G1" 10)}
wvSetCursor -win $_nWave2 12591.747642 -snap {("G1" 10)}
wvSetCursor -win $_nWave2 13635.623094 -snap {("G1" 10)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
verdiDockWidgetSetCurTab -dock widgetDock_<Message>
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
debExit
