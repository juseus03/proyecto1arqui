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

module	fixedregister #(
	parameter DATAWIDTH = 8,
	parameter INITREG = 5
	)
	(	input		clk,lowRst,
		//input		[DATAWIDTH-1:0]	DataInReg,
		output reg	[DATAWIDTH-1:0]	DataOutReg 
	);
	//SIGNAL DECLARATION
	reg [DATAWIDTH-1:0] rDataReg0;
	reg [DATAWIDTH-1:0] sDataReg0;
	
	//REGISTER
	always @(posedge clk, negedge lowRst)
		if (lowRst == 0) begin
			rDataReg0 <= 0;
			//rDataReg0 <= INITREG;
		end else begin
			DataOutReg <= INITREG;
		end	
	//OUTPUT LOGIC
	//always @ (*)
	//	sDataReg0 <= rDataReg0;
	//	DataOutReg <= rDataReg0;
endmodule
