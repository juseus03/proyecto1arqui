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

module multiplexor #(
	parameter SELECTION = 3,		//NUMBER OF SELECTION BITS
	parameter DATAWIDTH = 8
	)
	(
	input 			[DATAWIDTH-1:0]		sDataInMux0,sDataInMux1,sDataInMux2,sDataInMux3,sDataInMux4,sDataInMux5,sDataInMux6,sDataInMux7,
	input			[SELECTION-1:0] 	sSelMux,
	output reg		[DATAWIDTH-1:0] 	sDataOutMux
	);
	always@(*)
	begin
	case (sSelMux)	
	// Example to more outputs: WaitStart: begin sResetCounter = 0; sCuenteUP = 0; end
		3'b000: sDataOutMux = sDataInMux0;
		3'b001: sDataOutMux = sDataInMux1;
		3'b010: sDataOutMux = sDataInMux2;
		3'b011: sDataOutMux = sDataInMux3;
		3'b100: sDataOutMux = sDataInMux4;
		3'b101: sDataOutMux = sDataInMux5;
		3'b110: sDataOutMux = sDataInMux6;
		3'b111: sDataOutMux = sDataInMux7;
		default :   sDataOutMux = sDataInMux0; // channel 0 is selected 
		endcase
end
endmodule
