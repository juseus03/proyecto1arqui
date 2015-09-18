module statemachine#(
	parameter SELECTIONALU = 3,
	parameter SELECTIONDECO = 4
)
(
input wire clk, lowRst,sOverflow,sCarry,sNegative,sZero,sPar,sStart,
    output reg [SELECTIONDECO-1:0] sSelDecoA,sSelDecoB,sSelDecoC,
    output reg [SELECTIONALU-1:0] sSelAlu
);

//Declaracion de estados
	parameter sWaitStart= 			6'b000000;
	parameter sStateLeerRP0=		6'b000001;
	parameter sStateLeerRP1=		6'b000010;
	parameter sStateLeerRP2=		6'b000011;
	parameter sStateLeerRP3=		6'b000100;
	parameter sStateLeerRP4=		6'b000101;
	parameter sStateEscribirR0=		6'b000110;
	parameter sStateEscribirR0_0=		6'b000111;
	parameter sStateEscribirR0_1=		6'b001000;
	parameter sStateEscribirR0_2=		6'b001001;
	parameter sStateEscribirR0_3=		6'b001010;
	parameter sStateEscribirR1=		6'b001011;
	parameter sStateEscribirR1_0=		6'b001100;
	parameter sStateEscribirR1_1=		6'b001101;
	parameter sStateEscribirR1_2=		6'b001110;
	parameter sStateEscribirR1_3=		6'b001111;
	parameter sStateEscribirR1_4=		6'b010000;
	parameter sStateEscribirR1_5=		6'b010001;
	parameter sStateEscribirR1_6=		6'b010010;
	parameter sStateEscribirR2=		6'b010011;
	parameter sStateEscribirR2_0=		6'b010100;
	parameter sStateEscribirR2_1=		6'b010101;
	parameter sStateEscribirR2_2=		6'b010110;
	parameter sStateEscribirR2_3=		6'b010111;
	parameter sStateEscribirR2_4=		6'b011000;
	parameter sStateEscribirR2_5=		6'b011001;
	parameter sStateEscribirR2_6=		6'b011010;
	parameter sStateEscribirR2_7=		6'b011011;
	parameter sStateEscribirR3=		6'b011100;
	parameter sStateEscribirR3_0=		6'b011101;
	parameter sStateEscribirR3_1=		6'b011110;
	parameter sStateEscribirR3_2=		6'b011111;
	parameter sStateEscribirR3_3=		6'b100000;
	parameter sStateEscribirR3_4=		6'b100001;
	parameter sStateEscribirR3_5=		6'b100010;
	parameter sStateEscribirR3_6=		6'b100011;
	parameter sStateEscribirR4=		6'b100100;
	parameter sStateEscribirR4_0=		6'b100101;
	parameter sStateEscribirR4_1=		6'b100110;
	parameter sStateEscribirR4_2=		6'b100111;
	parameter sStateEscribirR4_3=		6'b101000;
	parameter sStateLeerR0=			6'b101001;
	parameter sStateLeerR1=			6'b101010;
	parameter sStateLeerR2=			6'b101011;
	parameter sStateLeerR3=			6'b101100;
	parameter sStateRestarRP0RP1=		6'b101101;
	parameter sStateRestarR0RP2=		6'b101110;
	parameter sStateRestarR0RP3=		6'b101111;
	parameter sStateRestarR0RP4=		6'b110000;
	parameter sStateRestarR1RP2=		6'b110001;
	parameter sStateRestarR1RP3=		6'b110010;
	parameter sStateRestarR1RP4=		6'b110011;
	parameter sStateRestarR2RP3=		6'b110100;
	parameter sStateRestarR2RP4=		6'b110101;
	parameter sStateRestarR3RP4=		6'b110110;
	parameter sStateLeerRP3_0=		6'b110111;
	parameter sStateLeerRP4_0=		6'b111000;
	parameter sStateDone=			6'b111001;
	
	reg done;
//signal declaration
	reg [5:0] sState, rState;
// state register
	always @ (posedge clk, negedge lowRst)
	if (lowRst==0)
		rState <= sWaitStart;
	else
		rState <= sState;

// next state logic
	always @ (*)
	case (rState)
	 sWaitStart: 	sState= (sStart==1)?sStateRestarRP0RP1:sWaitStart;		
	 sStateRestarRP0RP1:    if(sNegative == 1)sState=sStateLeerRP1;else sState=sStateLeerRP0;
	 sStateLeerRP1:		sState=sStateEscribirR0;
	 sStateEscribirR0:	sState=sStateLeerRP0;
	 sStateLeerRP0:		sState=sStateEscribirR1;
	 sStateEscribirR1:	sState=sStateRestarR0RP2;//
	 sStateLeerRP0:		sState=sStateEscribirR0_0;
	 sStateEscribirR0_0:	sState=sStateLeerRP1;
	 sStateLeerRP1:		sState=sStateEscribirR1_0;
	 sStateEscribirR1:      sState=sStateRestarR0RP2;//
	 sStateRestarR0RP2:     if(sNegative == 1)sState=sStateLeerR1;else sState=sStateRestarR1RP2;
	 sStateLeerR1:		sState=sStateEscribirR2;
	 sStateEscribirR2:	sState=sStateLeerR0;
	 sStateLeerR0:		sState=sStateEscribirR1_1;	
	 sStateEscribirR1_1:	sState=sStateLeerRP2;
	 sStateLeerRP2:		sState=sStateEscribirR0_1;
	 sStateEscribirR0_1:	sState=sStateRestarR0RP3;//
	 sStateRestarR1RP2:	if(sNegative == 1)sState=sStateLeerR1;else sState=sStateLeerRP2;
	 sStateLeerR1:		sState=sStateEscribirR2_0;
	 sStateEscribirR2_0:	sState=sStateLeerRP2;
	 sStateLeerRP2:		sState=sStateEscribirR1_2;
	 sStateEscribirR1_2:    sState=sStateRestarR0RP3;//
	 sStateLeerRP2:	 	sState=sStateEscribirR2_1;
	 sStateEscribirR2_1:	sState=sStateRestarR0RP3;//
	 sStateRestarR0RP3:     if(sNegative == 1)sState=sStateLeerR2;else sState=sStateRestarR1RP3;
	 sStateLeerR2:		sState=sStateEscribirR3;
	 sStateEscribirR3:	sState=sStateLeerR1;
	 sStateLeerR1:		sState=sStateEscribirR2_2;	
	 sStateEscribirR2_2:	sState=sStateLeerR0;
	 sStateLeerR0:		sState=sStateEscribirR1_3;
	 sStateEscribirR1_3:	sState=sStateLeerRP3;
	 sStateLeerRP3:		sState=sStateEscribirR0_2;
	 sStateEscribirR0:	sState=sStateRestarR0RP4; //
	 sStateRestarR1RP3:	if(sNegative == 1)sState=sStateLeerR2;else sState=sStateRestarR2RP3;
	 sStateLeerR2:		sState=sStateEscribirR3_0;
	 sStateEscribirR3_0:	sState=sStateLeerR1;
	 sStateLeerR1:		sState=sStateEscribirR2_3;
	 sStateEscribirR2_3:	sState=sStateLeerRP3;
	 sStateLeerRP3:		sState=sStateEscribirR1_4;
	 sStateEscribirR1_4:  	sState=sStateRestarR0RP4; //
	 sStateRestarR2RP3:	if(sNegative == 1)sState=sStateLeerR2; else sState=sStateLeerRP3_0;
	 sStateLeerR2:		sState=sStateEscribirR3_1;
	 sStateEscribirR3_1:	sState=sStateLeerRP3;
	 sStateLeerRP3:		sState=sStateEscribirR2_4;
	 sStateEscribirR2_4:	sState=sStateRestarR0RP4;//
	 sStateLeerRP3_0:	sState=sStateEscribirR3_2;
	 sStateEscribirR3_2:	sState=sStateRestarR0RP4;//
	 sStateRestarR0RP4:     if(sNegative == 1)sState=sStateLeerR3;else sState=sStateRestarR1RP4;
	 sStateLeerR3:		sState=sStateEscribirR4;
	 sStateEscribirR4:	sState=sStateLeerR2;
	 sStateLeerR2:		sState=sStateEscribirR3_3;	
	 sStateEscribirR3_3:	sState=sStateLeerR1;
	 sStateLeerR1:		sState=sStateEscribirR2_5;
	 sStateEscribirR2_5:	sState=sStateLeerR0;
	 sStateLeerR0:		sState=sStateEscribirR1_5;	
	 sStateEscribirR1_5:	sState=sStateLeerRP4;
	 sStateLeerRP4:		sState=sStateEscribirR0_3;
	 sStateEscribirR0:	sState=sStateDone; //
	 sStateRestarR1RP4:	if(sNegative == 1)sState=sStateLeerR3;else sState=sStateRestarR2RP4;
	 sStateLeerR3:		sState=sStateEscribirR4_0;
	 sStateEscribirR4_0:	sState=sStateLeerR2;
	 sStateLeerR2:		sState=sStateEscribirR3_4;
	 sStateEscribirR3_4:	sState=sStateLeerR1;
	 sStateLeerR1:		sState=sStateEscribirR2_6;
	 sStateEscribirR2_6:	sState=sStateLeerRP4;
	 sStateLeerRP4:		sState=sStateEscribirR1_6;
	 sStateEscribirR1_6:  	sState=sStateDone; //
	 sStateRestarR2RP4:	if(sNegative == 1)sState=sStateLeerR3;else sState=sStateRestarR3RP4;
	 sStateLeerR3:		sState=sStateEscribirR4_1;
	 sStateEscribirR4_1:	sState=sStateLeerR2;
	 sStateLeerR2:		sState=sStateEscribirR3_5;
	 sStateEscribirR3_5:	sState=sStateLeerRP4;
	 sStateLeerRP4:		sState=sStateEscribirR2_7;
         sStateEscribirR2_7:	sState=sStateDone;//
	 sStateRestarR3RP4:	if(sNegative == 1)sState=sStateLeerR3;else sState=sStateLeerRP4_0;
	 sStateLeerR3:		sState=sStateEscribirR4_2;
	 sStateEscribirR4_2:	sState=sStateLeerRP4;
	 sStateLeerRP4:		sState=sStateEscribirR3_6;
	 sStateEscribirR3_6:	sState=sStateDone;//
	 sStateLeerRP4_0:	sState=sStateEscribirR4_3;
	 sStateEscribirR4_3:	sState=sStateDone;
	 sStateDone: sState=sStateDone;

	default: sState = sWaitStart;
	endcase

// next state logic
// sSelDecoC = 3'b111 NO SE ESCRIBE EN NINGUN REGISTRO
	always @ (*)
	case (rState)
	 sWaitStart: 		begin sSelDecoA = 4'b0000; sSelDecoB = 4'b0000; sSelDecoC = 4'b1000; sSelAlu = 3'b000; end	
	 sStateRestarRP0RP1:	begin sSelDecoA = 4'b0110; sSelDecoB = 4'b0111; sSelDecoC = 4'b1000; sSelAlu = 3'b001; end
	 sStateLeerRP1:		begin sSelDecoA = 4'b0000; sSelDecoB = 4'b0111; sSelDecoC = 4'b1000; sSelAlu = 3'b101; end
	 sStateEscribirR0:	begin sSelDecoA = 4'b0000; sSelDecoB = 4'b0111; sSelDecoC = 4'b0000; sSelAlu = 3'b101; end
	 sStateLeerRP0:		begin sSelDecoA = 4'b0110; sSelDecoB = 4'b0000; sSelDecoC = 4'b1000; sSelAlu = 3'b000; end
	 sStateEscribirR1:	begin sSelDecoA = 4'b0110; sSelDecoB = 4'b0000; sSelDecoC = 4'b0001; sSelAlu = 3'b000; end
         
	 sStateEscribirR0_0:	begin sSelDecoA = 4'b0110; sSelDecoB = 4'b0000; sSelDecoC = 4'b0000; sSelAlu = 3'b000; end
 	 sStateEscribirR1_0:	begin sSelDecoA = 4'b0000; sSelDecoB = 4'b0111; sSelDecoC = 4'b0001; sSelAlu = 3'b101; end

	 sStateRestarR0RP2:	begin sSelDecoA = 4'b0001; sSelDecoB = 4'b1000; sSelDecoC = 4'b1000; sSelAlu = 3'b001; end
	 sStateLeerR1:		begin sSelDecoA = 4'b0010; sSelDecoB = 4'b0000; sSelDecoC = 4'b1000; sSelAlu = 3'b000; end
	 sStateEscribirR2:	begin sSelDecoA = 4'b0010; sSelDecoB = 4'b0000; sSelDecoC = 4'b0010; sSelAlu = 3'b000; end
	 sStateLeerR0:		begin sSelDecoA = 4'b0001; sSelDecoB = 4'b0000; sSelDecoC = 4'b1000; sSelAlu = 3'b000; end
	 sStateEscribirR1_1:	begin sSelDecoA = 4'b0001; sSelDecoB = 4'b0000; sSelDecoC = 4'b0001; sSelAlu = 3'b000; end
	 sStateLeerRP2:		begin sSelDecoA = 4'b0000; sSelDecoB = 4'b1000; sSelDecoC = 4'b1000; sSelAlu = 3'b101; end
	 sStateEscribirR0_1:	begin sSelDecoA = 4'b0000; sSelDecoB = 4'b1000; sSelDecoC = 4'b0000; sSelAlu = 3'b101; end
	 sStateRestarR1RP2:	begin sSelDecoA = 4'b0010; sSelDecoB = 4'b1000; sSelDecoC = 4'b1000; sSelAlu = 3'b001; end
	 sStateEscribirR2_0:	begin sSelDecoA = 4'b0010; sSelDecoB = 4'b0000; sSelDecoC = 4'b0010; sSelAlu = 3'b000; end
	 sStateEscribirR1_2:	begin sSelDecoA = 4'b0000; sSelDecoB = 4'b1000; sSelDecoC = 4'b0001; sSelAlu = 3'b101; end
	 sStateEscribirR2_1:	begin sSelDecoA = 4'b0000; sSelDecoB = 4'b1000; sSelDecoC = 4'b0010; sSelAlu = 3'b101; end
	 sStateRestarR0RP3:	begin sSelDecoA = 4'b0001; sSelDecoB = 4'b1001; sSelDecoC = 4'b1000; sSelAlu = 3'b001; end
	 sStateLeerR2:		begin sSelDecoA = 4'b0011; sSelDecoB = 4'b0000; sSelDecoC = 4'b1000; sSelAlu = 3'b000; end
	 sStateEscribirR3:	begin sSelDecoA = 4'b0011; sSelDecoB = 4'b0000; sSelDecoC = 4'b0011; sSelAlu = 3'b000; end
	 sStateEscribirR2_2:	begin sSelDecoA = 4'b0010; sSelDecoB = 4'b0000; sSelDecoC = 4'b0010; sSelAlu = 3'b000; end
	 sStateEscribirR1_3:	begin sSelDecoA = 4'b0001; sSelDecoB = 4'b0000; sSelDecoC = 4'b0001; sSelAlu = 3'b000; end
	 sStateLeerRP3:		begin sSelDecoA = 4'b0000; sSelDecoB = 4'b1001; sSelDecoC = 4'b1000; sSelAlu = 3'b101; end
	 sStateEscribirR0_2:	begin sSelDecoA = 4'b0000; sSelDecoB = 4'b1001; sSelDecoC = 4'b0000; sSelAlu = 3'b101; end
	 sStateRestarR1RP3:	begin sSelDecoA = 4'b0010; sSelDecoB = 4'b1001; sSelDecoC = 4'b1000; sSelAlu = 3'b001; end
	 sStateEscribirR3_0:	begin sSelDecoA = 4'b0011; sSelDecoB = 4'b0000; sSelDecoC = 4'b0011; sSelAlu = 3'b000; end
         sStateEscribirR2_3:	begin sSelDecoA = 4'b0010; sSelDecoB = 4'b0000; sSelDecoC = 4'b0010; sSelAlu = 3'b000; end
	 sStateEscribirR1_4:	begin sSelDecoA = 4'b0000; sSelDecoB = 4'b1001; sSelDecoC = 4'b0001; sSelAlu = 3'b101; end
	 sStateRestarR2RP3:	begin sSelDecoA = 4'b0011; sSelDecoB = 4'b1001; sSelDecoC = 4'b1000; sSelAlu = 3'b001; end
	 sStateEscribirR3_1:	begin sSelDecoA = 4'b0011; sSelDecoB = 4'b0000; sSelDecoC = 4'b0011; sSelAlu = 3'b000; end
	 sStateEscribirR2_4:	begin sSelDecoA = 4'b0000; sSelDecoB = 4'b1001; sSelDecoC = 4'b0010; sSelAlu = 3'b101; end
	 sStateEscribirR3_2:	begin sSelDecoA = 4'b0000; sSelDecoB = 4'b1001; sSelDecoC = 4'b0011; sSelAlu = 3'b101; end

	 sStateRestarR0RP4:	begin sSelDecoA = 4'b0001; sSelDecoB = 4'b1010; sSelDecoC = 4'b1000; sSelAlu = 3'b001; end
	 sStateLeerR3:		begin sSelDecoA = 4'b0100; sSelDecoB = 4'b0000; sSelDecoC = 4'b1000; sSelAlu = 3'b000; end
	 sStateEscribirR4:	begin sSelDecoA = 4'b0100; sSelDecoB = 4'b0000; sSelDecoC = 4'b0100; sSelAlu = 3'b000; end
	 sStateEscribirR3_3:	begin sSelDecoA = 4'b0011; sSelDecoB = 4'b0000; sSelDecoC = 4'b0011; sSelAlu = 3'b000; end
 	 sStateEscribirR2_5:	begin sSelDecoA = 4'b0010; sSelDecoB = 4'b0000; sSelDecoC = 4'b0010; sSelAlu = 3'b000; end
	 sStateEscribirR1_5:	begin sSelDecoA = 4'b0001; sSelDecoB = 4'b0000; sSelDecoC = 4'b0001; sSelAlu = 3'b000; end
         sStateLeerRP4:		begin sSelDecoA = 4'b0000; sSelDecoB = 4'b1010; sSelDecoC = 4'b1000; sSelAlu = 3'b101; end
	 sStateEscribirR0_3:	begin sSelDecoA = 4'b0000; sSelDecoB = 4'b1010; sSelDecoC = 4'b0000; sSelAlu = 3'b101; end
	 sStateRestarR1RP4:	begin sSelDecoA = 4'b0010; sSelDecoB = 4'b1010; sSelDecoC = 4'b1000; sSelAlu = 3'b001; end
	 sStateEscribirR4_0:	begin sSelDecoA = 4'b0100; sSelDecoB = 4'b0000; sSelDecoC = 4'b0100; sSelAlu = 3'b000; end
	 sStateEscribirR3_4:	begin sSelDecoA = 4'b0011; sSelDecoB = 4'b0000; sSelDecoC = 4'b0011; sSelAlu = 3'b000; end
 	 sStateEscribirR2_6:	begin sSelDecoA = 4'b0010; sSelDecoB = 4'b0000; sSelDecoC = 4'b0010; sSelAlu = 3'b000; end
	 sStateEscribirR1_6:	begin sSelDecoA = 4'b0000; sSelDecoB = 4'b1010; sSelDecoC = 4'b0001; sSelAlu = 3'b101; end
	 sStateRestarR2RP4:	begin sSelDecoA = 4'b0011; sSelDecoB = 4'b1010; sSelDecoC = 4'b1000; sSelAlu = 3'b001; end
	 sStateEscribirR4_1:	begin sSelDecoA = 4'b0100; sSelDecoB = 4'b0000; sSelDecoC = 4'b0100; sSelAlu = 3'b000; end
	 sStateEscribirR3_5:	begin sSelDecoA = 4'b0011; sSelDecoB = 4'b0000; sSelDecoC = 4'b0011; sSelAlu = 3'b000; end
 	 sStateEscribirR2_7:	begin sSelDecoA = 4'b0000; sSelDecoB = 4'b1010; sSelDecoC = 4'b0010; sSelAlu = 3'b101; end
	 sStateRestarR3RP4:	begin sSelDecoA = 4'b0100; sSelDecoB = 4'b1010; sSelDecoC = 4'b1000; sSelAlu = 3'b001; end
	 sStateEscribirR4_2:	begin sSelDecoA = 4'b0100; sSelDecoB = 4'b0000; sSelDecoC = 4'b0100; sSelAlu = 3'b000; end
	 sStateEscribirR3_6:	begin sSelDecoA = 4'b0000; sSelDecoB = 4'b1010; sSelDecoC = 4'b0011; sSelAlu = 3'b101; end
	 sStateEscribirR4_3:	begin sSelDecoA = 4'b0000; sSelDecoB = 4'b1010; sSelDecoC = 4'b0100; sSelAlu = 3'b101; end
	 sStateLeerRP3_0:	begin sSelDecoA = 4'b0000; sSelDecoB = 4'b1001; sSelDecoC = 4'b1000; sSelAlu = 3'b101; end
	 sStateLeerRP4_0:	begin sSelDecoA = 4'b0000; sSelDecoB = 4'b1010; sSelDecoC = 4'b1000; sSelAlu = 3'b101; end
	 	
	 sStateDone:		begin sSelDecoA = 4'b0000; sSelDecoB = 4'b0000; sSelDecoC = 4'b1000; sSelAlu = 3'b000; end	
	endcase
endmodule
