module statemachine#(
	parameter SELECTIONALU = 3,
	parameter SELECTIONDECO = 3
)
(
input wire clk, lowRst,sOverflow,sCarry,sNegative,sZero,
    output reg [SELECTIONDECO-1:0] sSelDecoA,sSelDecoB,sSelDecoC,
    output reg [SELECTIONALU-1:0] sSelAlu
);

//Declaracion de estados
	parameter sStateReset= 			3'b000;
	parameter sStateLeerRegProg0=		3'b001;
	parameter sStateLeerRegProg1=		3'b010;
	parameter sStateSumar=			3'b011;
	parameter sStateEscribirR0_inic=	3'b100;
	parameter sStateDone=			3'b111;
	
	reg done;
//signal declaration
	reg [4:0] sState, rState;
// state register
	always @ (posedge clk, negedge lowRst)
	if (lowRst==0)
		rState <= sStateReset;
	else
		rState <= sState;

// next state logic
	always @ (*)
	case (rState)
	sStateReset: sState= sStateLeerRegProg0;
	sStateLeerRegProg0:		sState= sStateLeerRegProg1;
	sStateLeerRegProg1:		sState= sStateSumar; 
	sStateSumar:			sState=sStateEscribirR0_inic;	 
	sStateEscribirR0_inic:  	sState= sStateDone;
	sStateDone:			sState=sStateDone;

	default: sState = sStateReset;
	endcase

// next state logic
// sSelDecoC = 3'b111 NO SE ESCRIBE EN NINGUN REGISTRO
	always @ (*)
	case (rState)
	

	sStateReset:  	begin sSelDecoA = 3'b000; sSelDecoB = 3'b000; sSelDecoC = 3'b111; sSelAlu = 3'b000; end //reset
	//Inicializacion
	sStateLeerRegProg0:	begin sSelDecoA = 3'b110; sSelDecoB = 3'b000; sSelDecoC = 3'b111; sSelAlu = 3'b000; end//RD RP0
	sStateLeerRegProg1:	begin sSelDecoA = 3'b110; sSelDecoB = 3'b111; sSelDecoC = 3'b111; sSelAlu = 3'b000; end//RD RP1
	sStateSumar:	 	begin sSelDecoA = 3'b110; sSelDecoB = 3'b111; sSelDecoC = 3'b000; sSelAlu = 3'b010; end// RP0+RP1
	sStateDone:	 	begin sSelDecoA = 3'b000; sSelDecoB = 3'b111; sSelDecoC = 3'b000; sSelAlu = 3'b000; end// Done
	endcase
endmodule
