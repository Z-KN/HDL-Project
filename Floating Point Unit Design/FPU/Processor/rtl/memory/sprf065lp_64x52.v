//////////////////////////////////////////////////////////////////////////////////////
//*                                                                              */
//*STATEMENT OF USE                                                              */
//*                                                                              */
//*This information contains confidential and proprietary information of TSMC.   */
//*No part of this information may be reproduced, transmitted, transcribed,      */
//*stored in a retrieval system, or translated into any human or computer        */
//*language, in any form or by any means, electronic, mechanical, magnetic,      */
//*optical, chemical, manual, or otherwise, without the prior written permission */
//*of TSMC. This information was prepared for informational purpose and is for   */
//*use by TSMC's customers only. TSMC reserves the right to make changes in the  */
//*information at any time and without notice.                                   */
//*                                                                              */
///*******************************************************************************/
//*                                                                              */
//*      Usage Limitation: PLEASE READ CAREFULLY FOR CORRECT USAGE               */
//*                                                                              */
//* The model doesn't support the control enable, data and address signals       */
//* transition at positive clock edge.                                           */
//* Please have some timing delays between control/data/address and clock signals*/
//* to ensure the correct behavior.                                              */
//*                                                                              */
//* Please be careful when using non 2^n  memory.                                */
//* In a non-fully decoded array, a write cycle to a nonexistent address location*/
//* does not change the memory array contents and output remains the same.       */
//* In a non-fully decoded array, a read cycle to a nonexistent address location */
//* does not change the memory array contents but the output becomes unknown.    */
//*                                                                              */
//* In the verilog model, the behavior of unknown clock will corrupt the         */
//* memory data and make output unknown regardless of CEB signal.  But in the    */
//* silicon, the unknown clock at CEB high, the memory and output data will be   */
//* held. The verilog model behavior is more conservative in this condition.     */
//*                                                                              */
//* The model doesn't identify physical column and row address                   */
//*                                                                              */
//* The verilog model provides UNIT_DELAY mode for the fast function simulation. */
//* All timing values in the specification are not checked in the UNIT_DELAY mode*/
//* simulation.                                                                  */
//*                                                                              */
//****************************************************************************** */
//*      Macro Usage       : (+define[MACRO] for Verilog compiliers)             */
//* +TSMC_UNIT_DELAY : Enable fast function simulation.                          */
//* +TSMC_NO_WARNING : Disable all runtime warning messages from this model.     */
//* +TSMC_INITIALIZE_MEM : Initialize the memory data in verilog format.         */
//* +TSMC_INITIALIZE_FAULT : Initialize the memory fault data in verilog format. */
//* +TSMC_NO_TESTPINS_WARNING : Disable the wrong test pins connection error     */
//*                             message if necessary.                            */
//****************************************************************************** */
//*        Software         : TSMC MEMORY COMPILER 2010.02.00.a
//*        Technology       : 65 nm CMOS LOGIC Low Power 1P9M 1.2V
//*        Memory Type      : TSMC 65nm Low Power High Performance One Port Register File
//*        Library Name     : ts5n65lphslvta64x52m4s (user specify : sprf065lp_64x52)
//*        Library Version  : 200b
//*        Generated Time   : 2011/06/14, 15:41:08
//*******************************************************************************
`resetall
`celldefine
`timescale 1ns/1ps
`delay_mode_path
`suppress_faults
`enable_portfaults

`ifdef TSMC_UNIT_DELAY
    `define SRAM_DELAY 0.001
`endif

module sprf065lp_64x52(
    A,
    D,
    BWEB,
    WEB,
    CEB,
    CLK,
    TURBO,
    RTSEL,
    TSEL,



    Q
);

// Parameter declarations
parameter N  = 52;                                      // word width
parameter W  = 64;                                    // word depth
parameter M  = 6;                                      // address width
parameter ADR_WIDTH_COL = 2;                            // column address width
parameter ADR_WIDTH_ROW = M - ADR_WIDTH_COL;            // row address width
parameter MUX = 4;                                     // column mux width


input [M - 1:0] A;         // write address bus
input [N - 1:0] D;          // input data bus
input [N - 1:0] BWEB;       // active-low bit-wise write-enable bus
input WEB;                  // active-low write-enable
input CEB;                  // active-low chip select
input CLK;                 // write clock




output [N - 1:0] Q;

// Test Mode
input [1:0] TSEL;
input TURBO;
input RTSEL;
// Test Mode
wire [1:0] TSEL_i;
wire TURBO_i;
wire RTSEL_i;

wire [N - 1:0] b_D;
wire [N - 1:0] b_BWEB;
wire [M - 1:0] b_A;

wire b_WEB;
wire b_CEB;


wire b_CLK;


reg [N - 1:0] Q_n;


wire CE = ~CEB;
wire WE = ~CEB & ~WEB;
// Register File  Control Signal Buffers
//      Normal

buf iD0 (b_D[0], D[0]);
buf iD1 (b_D[1], D[1]);
buf iD2 (b_D[2], D[2]);
buf iD3 (b_D[3], D[3]);
buf iD4 (b_D[4], D[4]);
buf iD5 (b_D[5], D[5]);
buf iD6 (b_D[6], D[6]);
buf iD7 (b_D[7], D[7]);
buf iD8 (b_D[8], D[8]);
buf iD9 (b_D[9], D[9]);
buf iD10 (b_D[10], D[10]);
buf iD11 (b_D[11], D[11]);
buf iD12 (b_D[12], D[12]);
buf iD13 (b_D[13], D[13]);
buf iD14 (b_D[14], D[14]);
buf iD15 (b_D[15], D[15]);
buf iD16 (b_D[16], D[16]);
buf iD17 (b_D[17], D[17]);
buf iD18 (b_D[18], D[18]);
buf iD19 (b_D[19], D[19]);
buf iD20 (b_D[20], D[20]);
buf iD21 (b_D[21], D[21]);
buf iD22 (b_D[22], D[22]);
buf iD23 (b_D[23], D[23]);
buf iD24 (b_D[24], D[24]);
buf iD25 (b_D[25], D[25]);
buf iD26 (b_D[26], D[26]);
buf iD27 (b_D[27], D[27]);
buf iD28 (b_D[28], D[28]);
buf iD29 (b_D[29], D[29]);
buf iD30 (b_D[30], D[30]);
buf iD31 (b_D[31], D[31]);
buf iD32 (b_D[32], D[32]);
buf iD33 (b_D[33], D[33]);
buf iD34 (b_D[34], D[34]);
buf iD35 (b_D[35], D[35]);
buf iD36 (b_D[36], D[36]);
buf iD37 (b_D[37], D[37]);
buf iD38 (b_D[38], D[38]);
buf iD39 (b_D[39], D[39]);
buf iD40 (b_D[40], D[40]);
buf iD41 (b_D[41], D[41]);
buf iD42 (b_D[42], D[42]);
buf iD43 (b_D[43], D[43]);
buf iD44 (b_D[44], D[44]);
buf iD45 (b_D[45], D[45]);
buf iD46 (b_D[46], D[46]);
buf iD47 (b_D[47], D[47]);
buf iD48 (b_D[48], D[48]);
buf iD49 (b_D[49], D[49]);
buf iD50 (b_D[50], D[50]);
buf iD51 (b_D[51], D[51]);

buf iBWEB0 (b_BWEB[0], BWEB[0]);
buf iBWEB1 (b_BWEB[1], BWEB[1]);
buf iBWEB2 (b_BWEB[2], BWEB[2]);
buf iBWEB3 (b_BWEB[3], BWEB[3]);
buf iBWEB4 (b_BWEB[4], BWEB[4]);
buf iBWEB5 (b_BWEB[5], BWEB[5]);
buf iBWEB6 (b_BWEB[6], BWEB[6]);
buf iBWEB7 (b_BWEB[7], BWEB[7]);
buf iBWEB8 (b_BWEB[8], BWEB[8]);
buf iBWEB9 (b_BWEB[9], BWEB[9]);
buf iBWEB10 (b_BWEB[10], BWEB[10]);
buf iBWEB11 (b_BWEB[11], BWEB[11]);
buf iBWEB12 (b_BWEB[12], BWEB[12]);
buf iBWEB13 (b_BWEB[13], BWEB[13]);
buf iBWEB14 (b_BWEB[14], BWEB[14]);
buf iBWEB15 (b_BWEB[15], BWEB[15]);
buf iBWEB16 (b_BWEB[16], BWEB[16]);
buf iBWEB17 (b_BWEB[17], BWEB[17]);
buf iBWEB18 (b_BWEB[18], BWEB[18]);
buf iBWEB19 (b_BWEB[19], BWEB[19]);
buf iBWEB20 (b_BWEB[20], BWEB[20]);
buf iBWEB21 (b_BWEB[21], BWEB[21]);
buf iBWEB22 (b_BWEB[22], BWEB[22]);
buf iBWEB23 (b_BWEB[23], BWEB[23]);
buf iBWEB24 (b_BWEB[24], BWEB[24]);
buf iBWEB25 (b_BWEB[25], BWEB[25]);
buf iBWEB26 (b_BWEB[26], BWEB[26]);
buf iBWEB27 (b_BWEB[27], BWEB[27]);
buf iBWEB28 (b_BWEB[28], BWEB[28]);
buf iBWEB29 (b_BWEB[29], BWEB[29]);
buf iBWEB30 (b_BWEB[30], BWEB[30]);
buf iBWEB31 (b_BWEB[31], BWEB[31]);
buf iBWEB32 (b_BWEB[32], BWEB[32]);
buf iBWEB33 (b_BWEB[33], BWEB[33]);
buf iBWEB34 (b_BWEB[34], BWEB[34]);
buf iBWEB35 (b_BWEB[35], BWEB[35]);
buf iBWEB36 (b_BWEB[36], BWEB[36]);
buf iBWEB37 (b_BWEB[37], BWEB[37]);
buf iBWEB38 (b_BWEB[38], BWEB[38]);
buf iBWEB39 (b_BWEB[39], BWEB[39]);
buf iBWEB40 (b_BWEB[40], BWEB[40]);
buf iBWEB41 (b_BWEB[41], BWEB[41]);
buf iBWEB42 (b_BWEB[42], BWEB[42]);
buf iBWEB43 (b_BWEB[43], BWEB[43]);
buf iBWEB44 (b_BWEB[44], BWEB[44]);
buf iBWEB45 (b_BWEB[45], BWEB[45]);
buf iBWEB46 (b_BWEB[46], BWEB[46]);
buf iBWEB47 (b_BWEB[47], BWEB[47]);
buf iBWEB48 (b_BWEB[48], BWEB[48]);
buf iBWEB49 (b_BWEB[49], BWEB[49]);
buf iBWEB50 (b_BWEB[50], BWEB[50]);
buf iBWEB51 (b_BWEB[51], BWEB[51]);

buf iA0 (b_A[0], A[0]);
buf iA1 (b_A[1], A[1]);
buf iA2 (b_A[2], A[2]);
buf iA3 (b_A[3], A[3]);
buf iA4 (b_A[4], A[4]);
buf iA5 (b_A[5], A[5]);

buf iWEB (b_WEB, WEB);
buf iCEB (b_CEB, CEB);


buf iCLK (b_CLK, CLK);

nmos iQ0 (Q[0], Q_n[0], 1'b1);
nmos iQ1 (Q[1], Q_n[1], 1'b1);
nmos iQ2 (Q[2], Q_n[2], 1'b1);
nmos iQ3 (Q[3], Q_n[3], 1'b1);
nmos iQ4 (Q[4], Q_n[4], 1'b1);
nmos iQ5 (Q[5], Q_n[5], 1'b1);
nmos iQ6 (Q[6], Q_n[6], 1'b1);
nmos iQ7 (Q[7], Q_n[7], 1'b1);
nmos iQ8 (Q[8], Q_n[8], 1'b1);
nmos iQ9 (Q[9], Q_n[9], 1'b1);
nmos iQ10 (Q[10], Q_n[10], 1'b1);
nmos iQ11 (Q[11], Q_n[11], 1'b1);
nmos iQ12 (Q[12], Q_n[12], 1'b1);
nmos iQ13 (Q[13], Q_n[13], 1'b1);
nmos iQ14 (Q[14], Q_n[14], 1'b1);
nmos iQ15 (Q[15], Q_n[15], 1'b1);
nmos iQ16 (Q[16], Q_n[16], 1'b1);
nmos iQ17 (Q[17], Q_n[17], 1'b1);
nmos iQ18 (Q[18], Q_n[18], 1'b1);
nmos iQ19 (Q[19], Q_n[19], 1'b1);
nmos iQ20 (Q[20], Q_n[20], 1'b1);
nmos iQ21 (Q[21], Q_n[21], 1'b1);
nmos iQ22 (Q[22], Q_n[22], 1'b1);
nmos iQ23 (Q[23], Q_n[23], 1'b1);
nmos iQ24 (Q[24], Q_n[24], 1'b1);
nmos iQ25 (Q[25], Q_n[25], 1'b1);
nmos iQ26 (Q[26], Q_n[26], 1'b1);
nmos iQ27 (Q[27], Q_n[27], 1'b1);
nmos iQ28 (Q[28], Q_n[28], 1'b1);
nmos iQ29 (Q[29], Q_n[29], 1'b1);
nmos iQ30 (Q[30], Q_n[30], 1'b1);
nmos iQ31 (Q[31], Q_n[31], 1'b1);
nmos iQ32 (Q[32], Q_n[32], 1'b1);
nmos iQ33 (Q[33], Q_n[33], 1'b1);
nmos iQ34 (Q[34], Q_n[34], 1'b1);
nmos iQ35 (Q[35], Q_n[35], 1'b1);
nmos iQ36 (Q[36], Q_n[36], 1'b1);
nmos iQ37 (Q[37], Q_n[37], 1'b1);
nmos iQ38 (Q[38], Q_n[38], 1'b1);
nmos iQ39 (Q[39], Q_n[39], 1'b1);
nmos iQ40 (Q[40], Q_n[40], 1'b1);
nmos iQ41 (Q[41], Q_n[41], 1'b1);
nmos iQ42 (Q[42], Q_n[42], 1'b1);
nmos iQ43 (Q[43], Q_n[43], 1'b1);
nmos iQ44 (Q[44], Q_n[44], 1'b1);
nmos iQ45 (Q[45], Q_n[45], 1'b1);
nmos iQ46 (Q[46], Q_n[46], 1'b1);
nmos iQ47 (Q[47], Q_n[47], 1'b1);
nmos iQ48 (Q[48], Q_n[48], 1'b1);
nmos iQ49 (Q[49], Q_n[49], 1'b1);
nmos iQ50 (Q[50], Q_n[50], 1'b1);
nmos iQ51 (Q[51], Q_n[51], 1'b1);
// Test Mode
buf (TSEL_i[0], TSEL[0]);
buf (TSEL_i[1], TSEL[1]);

buf (TURBO_i,TURBO);
buf (RTSEL_i,RTSEL);

`ifdef TSMC_NO_TESTPINS_WARNING
`else
always @(b_CLK or TSEL_i) begin
  if (TSEL_i !== 2'b01 && $realtime !=0) begin
           $display("\tWarning %m : input TSEL[1:0] shall keep 01 as default setting at simulation time %.1f\n", $realtime);
   end
end

always @(b_CLK or TURBO_i) begin
  if (TURBO_i !== 1'b1 && $realtime !=0) begin
           $display("\tWarning %m : input TURBO shall keep 1 as default setting at simulation time %.1f\n", $realtime);
   end
end

always @(b_CLK or RTSEL_i) begin
  if (RTSEL_i !== 1'b0 && $realtime !=0) begin
           $display("\tWarning %m : input RTSEL shall keep 0 as default setting at simulation time %.1f\n", $realtime);
   end
end
`endif
//      Repair




// M-by-N core memory
reg [N - 1:0] mem[W - 1:0];
reg [N - 1:0] mem_sa0[W - 1:0];
reg [N - 1:0] mem_sa1[W - 1:0];






// latched input signal
reg [M - 1:0] AL;
reg WEBL;
reg CEBL;
reg [N - 1:0] DL;
reg [N - 1:0] BWEBL;


`ifdef TSMC_UNIT_DELAY
`else
// Timing Check notifiers
reg notifier_CLK;      // notifier for clock CLK timing violations.
reg notifier_D;         // notifier for D, DM  BWEB & BWEBM timing violations.
reg notifier_WEB;       // notifier for WEB & BWEB timing violations.
reg notifier_CEB;       // notifier for CEB & CEBM timing violations.
reg notifier_A;        // notifier for A & AM timing violations.
`endif
reg clk_backfrom_xz;
reg sclk_backfrom_xz;
integer i;


`ifdef TSMC_UNIT_DELAY
`else
specify
specparam PATHPULSE$CLK$Q = ( 0, 0.001 );

specparam tckl = 0.364;
specparam tckh = 0.364;
specparam tcyc = 0.910;

specparam tas = 0.107;
specparam tah = 0.107;
specparam tds = 0.108;
specparam tdh = 0.168;
specparam tcebs = 0.213;
specparam tcebh = 0.040;
specparam twebs = 0.095;
specparam twebh = 0.062;
specparam tbwebs = 0.075;
specparam tbwebh = 0.168;





// CLK-2-Q
specparam tckq = 0.665;
specparam tckqh = 0.591;




  
  $width(negedge CLK, tckl, 0, notifier_CLK);
  $width(posedge CLK, tckh, 0, notifier_CLK);
  $period(posedge CLK, tcyc, notifier_CLK);
  
  $setuphold(posedge CLK, posedge CEB, tcebs, tcebh, notifier_CEB);
  $setuphold(posedge CLK, negedge CEB, tcebs, tcebh, notifier_CEB);
  
  
  $setuphold(posedge CLK &&& CE, posedge WEB, twebs, twebh, notifier_WEB);
  $setuphold(posedge CLK &&& CE, negedge WEB, twebs, twebh, notifier_WEB);

  $setuphold(posedge CLK &&& CE, posedge A[0], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, negedge A[0], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, posedge A[1], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, negedge A[1], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, posedge A[2], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, negedge A[2], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, posedge A[3], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, negedge A[3], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, posedge A[4], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, negedge A[4], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, posedge A[5], tas, tah, notifier_A);
  $setuphold(posedge CLK &&& CE, negedge A[5], tas, tah, notifier_A);

  $setuphold(posedge CLK &&& WE, posedge D[0], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[0], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[1], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[1], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[2], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[2], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[3], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[3], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[4], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[4], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[5], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[5], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[6], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[6], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[7], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[7], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[8], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[8], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[9], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[9], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[10], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[10], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[11], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[11], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[12], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[12], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[13], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[13], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[14], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[14], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[15], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[15], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[16], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[16], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[17], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[17], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[18], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[18], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[19], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[19], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[20], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[20], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[21], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[21], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[22], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[22], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[23], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[23], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[24], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[24], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[25], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[25], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[26], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[26], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[27], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[27], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[28], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[28], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[29], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[29], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[30], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[30], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[31], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[31], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[32], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[32], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[33], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[33], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[34], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[34], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[35], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[35], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[36], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[36], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[37], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[37], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[38], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[38], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[39], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[39], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[40], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[40], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[41], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[41], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[42], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[42], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[43], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[43], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[44], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[44], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[45], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[45], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[46], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[46], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[47], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[47], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[48], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[48], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[49], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[49], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[50], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[50], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge D[51], tds, tdh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge D[51], tds, tdh, notifier_D);

  $setuphold(posedge CLK &&& WE, posedge BWEB[0], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[0], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[1], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[1], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[2], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[2], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[3], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[3], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[4], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[4], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[5], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[5], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[6], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[6], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[7], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[7], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[8], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[8], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[9], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[9], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[10], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[10], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[11], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[11], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[12], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[12], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[13], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[13], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[14], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[14], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[15], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[15], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[16], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[16], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[17], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[17], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[18], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[18], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[19], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[19], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[20], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[20], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[21], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[21], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[22], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[22], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[23], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[23], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[24], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[24], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[25], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[25], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[26], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[26], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[27], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[27], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[28], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[28], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[29], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[29], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[30], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[30], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[31], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[31], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[32], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[32], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[33], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[33], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[34], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[34], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[35], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[35], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[36], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[36], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[37], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[37], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[38], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[38], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[39], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[39], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[40], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[40], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[41], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[41], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[42], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[42], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[43], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[43], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[44], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[44], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[45], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[45], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[46], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[46], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[47], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[47], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[48], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[48], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[49], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[49], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[50], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[50], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, posedge BWEB[51], tbwebs, tbwebh, notifier_D);
  $setuphold(posedge CLK &&& WE, negedge BWEB[51], tbwebs, tbwebh, notifier_D);














  (posedge CLK => (Q[0] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[1] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[2] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[3] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[4] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[5] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[6] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[7] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[8] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[9] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[10] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[11] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[12] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[13] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[14] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[15] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[16] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[17] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[18] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[19] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[20] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[21] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[22] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[23] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[24] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[25] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[26] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[27] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[28] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[29] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[30] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[31] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[32] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[33] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[34] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[35] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[36] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[37] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[38] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[39] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[40] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[41] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[42] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[43] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[44] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[45] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[46] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[47] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[48] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[49] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[50] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);
  (posedge CLK => (Q[51] +: 1'bx)) = (tckq,tckq,tckqh,tckq,tckqh,tckq);


endspecify
`endif


initial begin
    for ( i = 0; i < W; i = i + 1) begin
        mem_sa0[i] = {N{1'b1}};
        mem_sa1[i] = {N{1'b0}};
    end
end






`ifndef TSMC_UNIT_DELAY

always @(notifier_CEB) begin
    corrupt_mem;
    Q_n = {N{1'bx}};
end
always @(notifier_A) begin
    if (WEBL === 1'b0) begin
        corrupt_mem;
    end
    else if(WEBL === 1'b1) begin
        Q_n = {N{1'bx}};
    end
    else begin
        corrupt_mem;
        Q_n = {N{1'bx}};
    end
end

always @(notifier_D) begin
    mem[AL] = {N{1'bx}};
end
always @(notifier_WEB or notifier_CLK) begin
    mem[AL] = {N{1'bx}};
    Q_n = {N{1'bx}};
end
`endif

always @(b_CLK) begin
    if (b_CLK === 1'bx) begin
        clk_backfrom_xz = 1'b1;
`ifndef TSMC_NO_WARNING
        $display("Warning! Unknown violation %m\n \tinput CLK unknown/high-Z at simulation time %.3f\n", $realtime);
`endif
        corrupt_mem;
        Q_n = {N{1'bx}};
    end
end


always @(posedge b_CLK) begin
    if (b_CEB === 1'bx) begin
        Q_n = {N{1'bx}};
`ifndef TSMC_NO_WARNING
        $display("Warning! Unknown violation %m\n \tinput CEB unknown/high-Z at simulation time %.3f\n", $realtime);
`endif

        corrupt_mem;
        Q_n = {N{1'bx}};
    end
end




always @(posedge b_CLK) begin
    if (b_CLK === 1'bx) begin
        corrupt_mem;
        AL	= {M{1'bx}};
        WEBL = 1'bx;
        CEBL = 1'bx;
        DL = {N{1'bx}};
        BWEBL = {N{1'bx}};
        Q_n= {N{1'bx}};

    end
    else if (clk_backfrom_xz === 1'b1) begin
        clk_backfrom_xz = 1'b0;
    end
    else begin
`ifndef TSMC_NO_WARNING
        if (^b_D === 1'bx) begin
            $display("Warning! Unknown violation %m\n \tinput D unknown/high-Z at simulation time %.3f\n", $realtime);
        end
`endif

        AL = b_A;
        WEBL = b_WEB;
        CEBL = b_CEB;
        DL = b_D;
        BWEBL = b_BWEB;
        
        if (CEBL === 1'b0) begin


            if (^AL === 1'bx) begin
                corrupt_mem;
                if(WEBL == 1'b1) begin
                    Q_n = {N{1'bx}};
                end
    `ifndef TSMC_NO_WARNING
                $display("Warning! Unknown violation %m\n \tinput A unknown/high-Z at simulation time %.3f\n", $realtime);
    `endif
            end



            if (WEBL === 1'bx ) begin
`ifndef TSMC_NO_WARNING
                if (WEBL === 1'bx ) begin
                    $display("Warning! Unknown violation %m\n \tinput WEB unknown/high-Z at simulation time %.3f\n", $realtime);
                end
`endif
        
                corrupt_mem;
                Q_n = {N{1'bx}};
        
            end
            else if (WEBL === 1'b0) begin
`ifndef TSMC_NO_WARNING
                if (^BWEBL === 1'bx) begin
                    $display("Warning! Unknown violation %m\n \tinput BWEB unknown/high-Z at simulation time %.3f\n", $realtime);
                end
`endif

        
        
                mem[AL] = (DL & (~BWEBL)) ^ (mem[AL] & BWEBL);
            end
            else if (WEBL === 1'b1) begin
    `ifdef TSMC_UNIT_DELAY
                #(`SRAM_DELAY);
                Q_n = (mem[AL] & mem_sa0[AL]) | mem_sa1[AL];
    `else
                Q_n = {N{1'bx}};
                #0.001
                Q_n = (mem[AL] & mem_sa0[AL]) | mem_sa1[AL];
    `endif

            end
        end // end of if (CEBL === 1'b0)
    end
end


task corrupt_mem;   // USAGE: call this task to set core memory to unknown.
    integer i;
    begin 
        for (i = 0; i < W; i = i + 1) begin	 
            mem[i]	= {N{1'bx}};
        end
    end 
endtask

// Task for Loading a perdefined set of data from an external file.
task PreloadData;   // USAGE: initial inst.loadLP2PRF ("file_name");
    input [256*8:1] infile;  // Max 256 character File Name
    begin
        $display ("%m: Reading file, %0s, into the register file", infile);
        $readmemh (infile, mem, 0, W-1);
    end
endtask







task InjectSA;     // USAGE: inst.InjectSA(address, index, redundancy);
    input [M - 1:0] address;
    input [5:0] index;
    input redundancy;
    integer sum;
    integer i;
    reg sa1;
    reg sa0;
    begin 
        if (redundancy === 1'b0) begin
            mem_sa0[address][index] = 1'b0;
            mem_sa1[address][index] = 1'b0;
            sum = 0;
            for (i = 0; i < N; i = i + 1) begin
                sa0 = ~mem_sa0[address][i];
                sa1 = mem_sa1[address][i];
                sum = sa0 + sa1 + sum;
            end
            $display ("A s-a-0 error injected at address location %d = %b, current SA errors in this address is %d", address, ({N{1'bx}} &
            mem_sa0[address]) | mem_sa1[address], sum);
        end 
        else if (redundancy === 1'b1) begin
            mem_sa1[address][index] = 1'b1;
            mem_sa0[address][index] = 1'b1;
            sum = 0;
            for (i = 0; i < N; i = i + 1) begin
                sa0 = ~mem_sa0[address][i];
                sa1 = mem_sa1[address][i];
                sum = sa0 + sa1 + sum;
            end
            $display ("A s-a-1 error injected at address location %d = %b, current SA errors in this address is %d", address, ({N{1'bx}} &
            mem_sa0[address]) | mem_sa1[address], sum);
        end
    end 
endtask

// Task for printing the memory between specified addresses..
task PrintMemoryFromTo;     // USAGE: inst.PrintMemoryFromTo(from, to);
    input [M - 1:0] from;   // memory content are printed, start from this address.
    input [M - 1:0] to;     // memory content are printed, end at this address.
    integer i;
    begin 
        $display ("Dumping register file...");
        $display("@    Address, content-----");
        for (i = from; i <= to; i = i + 1) begin
            $display("@%d, %b", i, mem[i]);
        end 
    end
endtask

// Task for printing entire memory, including normal array and redundancy array.
task PrintMemory;   // USAGE: inst.PrintMemory;
    integer i;
    begin
        $display ("Dumping register file...");
        $display("@    Address, content-----");
        for (i = 0; i < W; i = i + 1) begin
            $display("@%d, %b", i, mem[i]);
        end 
    end
endtask

endmodule

`endcelldefine
