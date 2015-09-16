//---------------------------------------------------------------------------
// SharkBoad ExampleModule
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

module	dataregister #(
	parameter DATAWIDTH = 8
	)
	(	input wire		clk,lowRst,lowWr,
		input wire		[DATAWIDTH-1:0]	DataIn,
		output wire		[DATAWIDTH-1:0]	DataOut
	);
	//SIGNAL DECLARATION
	reg [DATAWIDTH-1:0] rDataReg;
	reg [DATAWIDTH-1:0] sDataReg;
	reg [DATAWIDTH-1:0] sDataOut;
	
	//REGISTER
	always @(posedge clk, posedge lowRst)
		if (lowRst == 0) begin
			rDataReg <= 0;
		end else begin
			rDataReg <= sDataReg;
		end	
	//INPUT LOGIC
	//assign sDataReg = (lowWr) ? rDataReg : DataIn;
	always @ (lowWr,DataIn,rDataReg)
		if (lowWr == 0) begin
			sDataReg <= DataIn;
		end else begin
			sDataReg <= rDataReg;
		end
	//OUTPUT LOGIC
	always @ (rDataReg)
		sDataOut <= rDataReg;
		
	assign DataOut = sDataOut;
			
endmodule
