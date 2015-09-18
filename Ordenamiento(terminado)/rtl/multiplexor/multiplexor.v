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
	parameter SELECTION = 4,		//NUMBER OF SELECTION BITS
	parameter DATAWIDTH = 9
	)
	(
	input 			[DATAWIDTH-1:0]		sDataInMux0,sDataInMux1,sDataInMux2,sDataInMux3,sDataInMux4,sDataInMux5,sDataInMux6,sDataInMux7,sDataInMux8,sDataInMux9,sDataInMux10,
	input			[SELECTION-1:0] 	sSelMux,
	output reg		[DATAWIDTH-1:0] 	sDataOutMux
	);
	always@(*)
	begin
	case (sSelMux)	
	// Example to more outputs: WaitStart: begin sResetCounter = 0; sCuenteUP = 0; end
		4'b0000: sDataOutMux = sDataInMux0; 
		4'b0001: sDataOutMux = sDataInMux1;//R0
		4'b0010: sDataOutMux = sDataInMux2;//R1
		4'b0011: sDataOutMux = sDataInMux3;//R2
		4'b0100: sDataOutMux = sDataInMux4;//R3
		4'b0101: sDataOutMux = sDataInMux5;//R4
		4'b0110: sDataOutMux = sDataInMux6;//RP0
		4'b0111: sDataOutMux = sDataInMux7;//RP1
		4'b1000: sDataOutMux = sDataInMux8;//RP2
		4'b1001: sDataOutMux = sDataInMux9;//RP3
		4'b1010: sDataOutMux = sDataInMux10;//RP4
		default :   sDataOutMux = sDataInMux0; // channel 0 is selected 
		endcase
end
endmodule
