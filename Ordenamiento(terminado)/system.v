//---------------------------------------------------------------------------
// SharkBoad SystemModule
//
// Top Level Design for the Xilinx Spartan 3-100E Device
//---------------------------------------------------------------------------

/*#
# SharkBoad
# Copyright (C) 2012 Bogotá, Colombia
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, version 3 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#*/

module system
#(parameter	clk_freq	= 50000000) 
(
	input		Clk_System, lowRst_System, start
);

//---------------------------------------------------------------------------
// General Purpose IO
//---------------------------------------------------------------------------
wire [7:0] nBusA;
wire [7:0] nBusB; 
wire [7:0] nBusC;

wire [7:0] nDataOutReg0; 
wire [7:0] nDataOutReg1; 
wire [7:0] nDataOutReg2; 
wire [7:0] nDataOutReg3;
wire [7:0] nDataOutReg4;

wire [7:0] nDataOutReg6; 
wire [7:0] nDataOutReg7; 
wire [7:0] nDataOutReg8;
wire [7:0] nDataOutReg9;
wire [7:0] nDataOutReg10;

wire [3:0] cSelDecoA;
wire [11:0] nOutDecoA;
wire [3:0] cSelDecoB;
wire [11:0] nOutDecoB;
wire [3:0] cSelDecoC;
wire [11:0] nOutDecoC;

wire [3:0] cSelMuxBusA;
wire [3:0] cSelMuxBusB;

wire [2:0] cSelAlu;

fixedregister #(.DATAWIDTH(8), .INITREG(4)) fixedreg_unit_0
(
.clk(Clk_System), .lowRst(lowRst_System),

.DataOutReg(nDataOutReg6)
);

fixedregister #(.DATAWIDTH(8), .INITREG(5)) fixedreg_unit_1
(
.clk(Clk_System), .lowRst(lowRst_System),

.DataOutReg(nDataOutReg7)
);

fixedregister #(.DATAWIDTH(8), .INITREG(8)) fixedreg_unit_2
(
.clk(Clk_System), .lowRst(lowRst_System),

.DataOutReg(nDataOutReg8)
);

fixedregister #(.DATAWIDTH(8), .INITREG(3)) fixedreg_unit_3
(
.clk(Clk_System), .lowRst(lowRst_System),

.DataOutReg(nDataOutReg9)
);

fixedregister #(.DATAWIDTH(8), .INITREG(1)) fixedreg_unit_4
(
.clk(Clk_System), .lowRst(lowRst_System),

.DataOutReg(nDataOutReg10)
);



dataregister #(.DATAWIDTH(8)) datareg_unit_0
(
.clk(Clk_System), .lowRst(lowRst_System), .lowWr(nOutDecoC[0]),
.DataIn(nBusC), 

.DataOut(nDataOutReg0)
);

dataregister #(.DATAWIDTH(8)) datareg_unit_1
(
.clk(Clk_System), .lowRst(lowRst_System), .lowWr(nOutDecoC[1]),
.DataIn(nBusC), 

.DataOut(nDataOutReg1)
);

dataregister #(.DATAWIDTH(8)) datareg_unit_2
(
.clk(Clk_System), .lowRst(lowRst_System), .lowWr(nOutDecoC[2]),
.DataIn(nBusC), 

.DataOut(nDataOutReg2)
);

dataregister #(.DATAWIDTH(8)) datareg_unit_3
(
.clk(Clk_System), .lowRst(lowRst_System), .lowWr(nOutDecoC[3]),
.DataIn(nBusC), 

.DataOut(nDataOutReg3)
);

dataregister #(.DATAWIDTH(8)) datareg_unit_4
(
.clk(Clk_System), .lowRst(lowRst_System), .lowWr(nOutDecoC[4]),
.DataIn(nBusC), 

.DataOut(nDataOutReg4)
);



decoder #(.SELECTION(4), .DATAWIDTH(12)) decoder_unitC
(
.sSelDeco(cSelDecoC), .sOutDeco(nOutDecoC)
);

multiplexor #(.SELECTION(4), .DATAWIDTH(8)) multiplexor_unitBusA
(
.sDataInMux0(0), .sDataInMux1(nDataOutReg0), .sDataInMux2(nDataOutReg1), .sDataInMux3(nDataOutReg2), .sDataInMux4(nDataOutReg3), .sDataInMux5(nDataOutReg4), .sDataInMux6(nDataOutReg6), .sDataInMux7(nDataOutReg7),.sDataInMux8(nDataOutReg8),.sDataInMux9(nDataOutReg9),.sDataInMux10(nDataOutReg10),
.sSelMux(cSelDecoA),

.sDataOutMux(nBusA)
);

multiplexor #(.SELECTION(4), .DATAWIDTH(8)) multiplexor_unitBusB
(
.sDataInMux0(0), .sDataInMux1(nDataOutReg0), .sDataInMux2(nDataOutReg1), .sDataInMux3(nDataOutReg2), .sDataInMux4(nDataOutReg3), .sDataInMux5(nDataOutReg4), .sDataInMux6(nDataOutReg6), .sDataInMux7(nDataOutReg7),.sDataInMux8(nDataOutReg8),.sDataInMux9(nDataOutReg9),.sDataInMux10(nDataOutReg10),
.sSelMux(cSelDecoB),

.sDataOutMux(nBusB)
);

alu #(.DATAWIDTH(8), .SELECTION(3)) alu_unit0
(
.sDataInBusA(nBusA), .sDataInBusB(nBusB),
.sSelAlu(cSelAlu),
.sDataOutBusC(nBusC),
.sOverflow(cOverflow), .sCarry(cCarry), .sNegative(cNegative), .sZero(cZero), .sPar(cPar)
);

statemachine #(.SELECTIONALU(3), .SELECTIONDECO(4)) statemachine_unit0
(
.clk(Clk_System), .lowRst(lowRst_System), .sOverflow(cOverflow), .sCarry(cCarry), .sNegative(cNegative), .sZero(cZero),.sPar(cPar),.sStart(start), 

.sSelDecoA(cSelDecoA), .sSelDecoB(cSelDecoB), .sSelDecoC(cSelDecoC),
.sSelAlu(cSelAlu)

);

//----------------------------------------------------------------------------
// Wires Assigments
//----------------------------------------------------------------------------

//assign led = wled_out;

endmodule


