module statemachine#(
	parameter SELECTIONALU = 3,
	parameter SELECTIONDECO = 3
)
(
input wire clk, lowRst,sOverflow,sCarry,sNegative,sZero,sPar,sStart,
    output reg [SELECTIONDECO-1:0] sSelDecoA,sSelDecoB,sSelDecoC,
    output reg [SELECTIONALU-1:0] sSelAlu
);

//Declaracion de estados
	parameter sWaitStart= 			3'b000;
	parameter sStateLeerRP0= 			3'b001;
	parameter sStateShiftIzq= 			3'b010;
	parameter sStateEscribirR0= 			3'b011;
	parameter sStateDone=			3'b111;
	
	reg done;
//signal declaration
	reg [2:0] sState, rState;
// state register
	always @ (posedge clk, posedge lowRst)
	if (lowRst==0)
		rState <= sWaitStart;
	else
		rState <= sState;

// next state logic
	always @ (*)
	case (rState)
	 sWaitStart: 			sState= (sStart==1)?sStateLeerRP0:sWaitStart;		
	 sStateLeerRP0:			sState=sStateShiftIzq;
	 sStateShiftIzq:		sState=sStateEscribirR0;
	 sStateEscribirR0:		sState=sStateDone;
	 sStateDone: sState=sStateDone;

	default: sState = sWaitStart;
	endcase

// next state logic
// sSelDecoC = 3'b111 NO SE ESCRIBE EN NINGUN REGISTRO
	always @ (*)
	case (rState)
	 sWaitStart: 		begin sSelDecoA = 3'b000; sSelDecoB = 3'b000; sSelDecoC = 3'b111; sSelAlu = 3'b000; end		
	 sStateLeerRP0:		begin sSelDecoA = 3'b110; sSelDecoB = 3'b000; sSelDecoC = 3'b111; sSelAlu = 3'b000; end
	 sStateShiftIzq:	begin sSelDecoA = 3'b110; sSelDecoB = 3'b000; sSelDecoC = 3'b111; sSelAlu = 3'b100; end
	 sStateEscribirR0:	begin sSelDecoA = 3'b110; sSelDecoB = 3'b000; sSelDecoC = 3'b000; sSelAlu = 3'b100; end
	 sStateDone:		begin sSelDecoA = 3'b000; sSelDecoB = 3'b000; sSelDecoC = 3'b111; sSelAlu = 3'b000; end	
	endcase
endmodule
