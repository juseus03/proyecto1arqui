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
	parameter sWaitStart= 			4'b0000;
	parameter sStateLeerRP0=		4'b0001;
	parameter sStateEscribirR2=		4'b0010;
	parameter sStateLeerRp1=		4'b0011;
	parameter sStateEscribirR1=		4'b0100;
	parameter sStateLeerR1=			4'b0101;
	parameter sStateLeerR0R2=		4'b0110;
	parameter sStateSumarR0R2=		4'b0111;
	parameter sStateShiftR1=		4'b1000;
	parameter sStateEscribirR1Shift=	4'b1001;
	parameter sStateShiftR2=		4'b1010;
	parameter sStateEscribirR2Shift=	4'b1011;
	parameter sStateDone=			4'b1111;
	
	reg done;
//signal declaration
	reg [3:0] sState, rState;
// state register
	always @ (posedge clk, posedge lowRst)
	if (lowRst==0)
		rState <= sWaitStart;
	else
		rState <= sState;

// next state logic
	always @ (*)
	case (rState)
	 sWaitStart: 	sState= (sStart==1)?sStateLeerRP0:sWaitStart;		
	 sStateLeerRP0:		sState=sStateEscribirR2;
	 sStateEscribirR2:	sState=sStateLeerRp1;
	 sStateLeerRp1:		sState=sStateEscribirR1;
	 sStateEscribirR1:	sState=sStateLeerR1;	
	 sStateLeerR1:		if (sZero==0) begin if(sPar==1)
				sState=sStateShiftR1;
				else
				sState=sStateLeerR0R2;end
				else
				sState=sStateDone;
	 sStateLeerR0R2:	sState=sStateSumarR0R2;	
	 sStateSumarR0R2:	sState=sStateShiftR1;	
	 sStateShiftR1:		sState=sStateEscribirR1Shift;
	 sStateEscribirR1Shift:	sState=sStateShiftR2;
	 sStateShiftR2:		sState=sStateEscribirR2Shift;
	 sStateEscribirR2Shift:	sState=sStateLeerR1;
	 sStateDone: sState=sStateDone;

	default: sState = sWaitStart;
	endcase

// next state logic
// sSelDecoC = 3'b111 NO SE ESCRIBE EN NINGUN REGISTRO
	always @ (*)
	case (rState)
	 sWaitStart: 		begin sSelDecoA = 3'b000; sSelDecoB = 3'b000; sSelDecoC = 3'b111; sSelAlu = 3'b000; end		
	 sStateLeerRP0:		begin sSelDecoA = 3'b110; sSelDecoB = 3'b000; sSelDecoC = 3'b111; sSelAlu = 3'b000; end
	 sStateEscribirR2:	begin sSelDecoA = 3'b110; sSelDecoB = 3'b000; sSelDecoC = 3'b010; sSelAlu = 3'b000; end	
	 sStateLeerRp1:		begin sSelDecoA = 3'b111; sSelDecoB = 3'b000; sSelDecoC = 3'b111; sSelAlu = 3'b000; end
	 sStateEscribirR1:	begin sSelDecoA = 3'b111; sSelDecoB = 3'b000; sSelDecoC = 3'b001; sSelAlu = 3'b000; end	
	 sStateLeerR1:		begin sSelDecoA = 3'b001; sSelDecoB = 3'b000; sSelDecoC = 3'b111; sSelAlu = 3'b000; end	
	 sStateLeerR0R2:	begin sSelDecoA = 3'b000; sSelDecoB = 3'b010; sSelDecoC = 3'b111; sSelAlu = 3'b010; end
	 sStateSumarR0R2:	begin sSelDecoA = 3'b000; sSelDecoB = 3'b010; sSelDecoC = 3'b000; sSelAlu = 3'b010; end	
	 sStateShiftR1:		begin sSelDecoA = 3'b001; sSelDecoB = 3'b000; sSelDecoC = 3'b111; sSelAlu = 3'b011; end
	 sStateEscribirR1Shift:	begin sSelDecoA = 3'b001; sSelDecoB = 3'b000; sSelDecoC = 3'b001; sSelAlu = 3'b011; end
	 sStateShiftR2:		begin sSelDecoA = 3'b010; sSelDecoB = 3'b000; sSelDecoC = 3'b111; sSelAlu = 3'b100; end
	 sStateEscribirR2Shift:	begin sSelDecoA = 3'b010; sSelDecoB = 3'b000; sSelDecoC = 3'b010; sSelAlu = 3'b100; end
	 sStateDone:		begin sSelDecoA = 3'b000; sSelDecoB = 3'b000; sSelDecoC = 3'b111; sSelAlu = 3'b000; end	
	endcase
endmodule
