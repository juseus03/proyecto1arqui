//---------------------------------------------------------------------------
// SharkBoad/CondorBoard ExampleModule
// Fredy Segura Q.
// Josnelihurt Rodriguez Barajas
// fsegura@uniandes.edu.co
// j.rodriguez52@uniandes.edu.co
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

module alu #(
	parameter DATAWIDTH = 8,
	parameter SELECTION = 3		//NUMBER OF SELECTION BITS
)
(	input[DATAWIDTH-1:0] sDataInBusA,sDataInBusB,
	input[SELECTION-1:0] sSelAlu,
	output reg [DATAWIDTH-1:0] sDataOutBusC,
	output reg sOverflow,sCarry,sNegative,sZero,sPar
);
//reg [DATAWIDTH-1:0] sDataOutBusCtemp;
//reg sZero, sNegative, sCarry, sOverflow;

	//INPUT LOGIC
	always@(*)
	begin
	case (sSelAlu)	
		3'b000: sDataOutBusC = sDataInBusA; //DEJA PASAR
		3'b001: sDataOutBusC = sDataInBusA - sDataInBusB;
		3'b010: sDataOutBusC = sDataInBusA + sDataInBusB;
		3'b011: sDataOutBusC = sDataInBusA>>1;
		3'b100: sDataOutBusC = sDataInBusA<<1;
		3'b101: sDataOutBusC = sDataInBusA; //DEJA PASAR;
		3'b110: sDataOutBusC = sDataInBusA; //DEJA PASAR;
		3'b111: sDataOutBusC = sDataInBusA; //DEJA PASAR;
		default : sDataOutBusC = sDataInBusA; // channel 0 is selected
	endcase
	end
wire[DATAWIDTH:0] dummyV;
assign dummyV=sDataOutBusC;
	//OUTPUT LOGIC
	always@(*)
	begin
	
	//SE PUEDE HACER MEJOR ASI:
	//assign sZero = (sDataOutBusC == 0) ? 1:0;

	if (sDataOutBusC==0)
		sZero = 1;
	else	
		sZero = 0;
	
	if (sDataOutBusC[DATAWIDTH-1] == 1)
		sNegative = 1;
	else	
		sNegative = 0;

	if (sDataOutBusC[0]==0)
		sPar=1;
	else
		sPar=0;



	//FALTA ESPECIFICAR sCarry y sOverflow POR AHORA TIENEN CERO
	if(!(sDataInBusA[DATAWIDTH-1] ^ sDataInBusB[DATAWIDTH-1]))
	begin
		if((~sDataOutBusC[DATAWIDTH-1])==sDataInBusB[DATAWIDTH-1])
		sOverflow = 1;
		else
		sOverflow = 0;
	end		
	
	else 
	sOverflow = 0;
	
	if(dummyV[DATAWIDTH])
	sCarry =  1;
	else
	sCarry =  0;
	
	end
endmodule


