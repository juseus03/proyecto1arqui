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
wire [7:0] nDataOutReg6; 
wire [7:0] nDataOutReg7; 

wire [2:0] cSelDecoA;
wire [7:0] nOutDecoA;
wire [2:0] cSelDecoB;
wire [7:0] nOutDecoB;
wire [2:0] cSelDecoC;
wire [7:0] nOutDecoC;

wire [2:0] cSelMuxBusA;
wire [2:0] cSelMuxBusB;

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


decoder #(.SELECTION(3), .DATAWIDTH(8)) decoder_unitC
(
.sSelDeco(cSelDecoC), .sOutDeco(nOutDecoC)
);

multiplexor #(.SELECTION(3), .DATAWIDTH(8)) multiplexor_unitBusA
(
.sDataInMux0(nDataOutReg0), .sDataInMux1(nDataOutReg1), .sDataInMux2(nDataOutReg2), .sDataInMux3(0), .sDataInMux4(0), .sDataInMux5(0), .sDataInMux6(nDataOutReg6), .sDataInMux7(nDataOutReg7),
.sSelMux(cSelDecoA),

.sDataOutMux(nBusA)
);

multiplexor #(.SELECTION(3), .DATAWIDTH(8)) multiplexor_unitBusB
(
.sDataInMux0(nDataOutReg0), .sDataInMux1(nDataOutReg1), .sDataInMux2(nDataOutReg2), .sDataInMux3(0), .sDataInMux4(0), .sDataInMux5(0), .sDataInMux6(nDataOutReg6), .sDataInMux7(nDataOutReg7),
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

statemachine #(.SELECTIONALU(3), .SELECTIONDECO(3)) statemachine_unit0
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


