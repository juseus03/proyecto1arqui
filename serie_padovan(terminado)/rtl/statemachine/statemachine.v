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
	parameter sStateReset= 			5'b00000;
	parameter sStateLeerRegProg0=		5'b00001;
	parameter sStateLeerRegProg1=		5'b00010;
	parameter sStateEscribirR0_inic=	5'b00011;
	parameter sStateEscribirR1_inic=	5'b00100;
	parameter sStateEscribirR2_inic=	5'b00101;
	parameter sStateEscribirR3_inic=	5'b00110;
	parameter sStateEscribirR0_up=		5'b00111;
	parameter sStateEscribirR1_up=		5'b01000;
	parameter sStateEscribirR2_up=		5'b01001;
	parameter sStateEscribirR3_up=		5'b01010;
	parameter sStateEscribirR4_up=		5'b01011;
	parameter sStateEscribirR4_dw=		5'b01100;
	parameter sStateEscribirR0_dw=		5'b01101;
	parameter sStateEscribirR2_dw=		5'b01110;
	parameter sStateEscribirR1_dw=		5'b01111;
	parameter sStateDone=			5'b11111;
	
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
	sStateLeerRegProg0:	sState= sStateEscribirR0_inic;
	sStateEscribirR0_inic:		sState= sStateEscribirR1_inic; 	 
	sStateEscribirR1_inic:  	sState= sStateEscribirR2_inic;
	sStateEscribirR2_inic: 		sState= sStateEscribirR3_inic;
	sStateEscribirR3_inic:		sState= sStateEscribirR0_up;
	sStateEscribirR0_up:		sState=sStateEscribirR1_up; 
	sStateEscribirR1_up:		sState=sStateEscribirR2_up;
	sStateEscribirR2_up:		sState=sStateEscribirR3_up;
	sStateEscribirR3_up:		sState=sStateLeerRegProg1; 
	sStateLeerRegProg1:		sState=sStateEscribirR4_up; 
	sStateEscribirR4_up:		if(!sZero)sState=sStateEscribirR0_up; else sState=sStateEscribirR4_dw;//DOwn
	sStateEscribirR4_dw:		sState=sStateEscribirR0_dw;
	sStateEscribirR0_dw:		if(!sZero)sState=sStateEscribirR2_dw;  else sState=sStateDone;
	sStateEscribirR2_dw:		sState=sStateEscribirR1_dw;
	sStateEscribirR1_dw:		sState=sStateEscribirR4_dw;
	sStateDone:			sState=sStateDone;

	default: sState = sStateReset;
	endcase

// next state logic
// sSelDecoC = 3'b111 NO SE ESCRIBE EN NINGUN REGISTRO
	always @ (*)
	case (rState)
	

	sStateReset:  	begin sSelDecoA = 3'b000; sSelDecoB = 3'b000; sSelDecoC = 3'b111; sSelAlu = 3'b000; end //reset
	//Inicializacion
	sStateLeerRegProg0:	begin sSelDecoA = 3'b110; sSelDecoB = 3'b111; sSelDecoC = 3'b111; sSelAlu = 3'b000; end//RD RP0
	sStateLeerRegProg1:	begin sSelDecoA = 3'b101; sSelDecoB = 3'b111; sSelDecoC = 3'b111; sSelAlu = 3'b000; end//RD RP1
	sStateEscribirR0_inic:	 begin sSelDecoA = 3'b110; sSelDecoB = 3'b111; sSelDecoC = 3'b000; sSelAlu = 3'b000; end// WR R0
	sStateEscribirR1_inic:	 begin sSelDecoA = 3'b110; sSelDecoB = 3'b111; sSelDecoC = 3'b001; sSelAlu = 3'b000; end//WR R1
	sStateEscribirR2_inic:	 begin sSelDecoA = 3'b110; sSelDecoB = 3'b111; sSelDecoC = 3'b010; sSelAlu = 3'b000; end//wr R2
	sStateEscribirR3_inic:	 begin sSelDecoA = 3'b000; sSelDecoB = 3'b001; sSelDecoC = 3'b011; sSelAlu = 3'b010; end//R3=R0+R1
	
	//CuentaUP	
	sStateEscribirR0_up:	begin sSelDecoA = 3'b001; sSelDecoB = 3'b111; sSelDecoC = 3'b000; sSelAlu = 3'b000; end
	sStateEscribirR1_up:	begin sSelDecoA = 3'b010; sSelDecoB = 3'b111; sSelDecoC = 3'b001; sSelAlu = 3'b000; end
	sStateEscribirR2_up:	begin sSelDecoA = 3'b011; sSelDecoB = 3'b111; sSelDecoC = 3'b010; sSelAlu = 3'b000; end
	sStateEscribirR3_up:	begin sSelDecoA = 3'b000; sSelDecoB = 3'b001; sSelDecoC = 3'b011; sSelAlu = 3'b010; end
	sStateEscribirR4_up:	begin sSelDecoA = 3'b111; sSelDecoB = 3'b000; sSelDecoC = 3'b100; sSelAlu = 3'b001; end
	sStateDone: done=1;
	//CuenteDown	
	sStateEscribirR4_dw: 	begin sSelDecoA = 3'b000; sSelDecoB = 3'b111; sSelDecoC = 3'b100; sSelAlu = 3'b000; end
	sStateEscribirR0_dw:	begin sSelDecoA = 3'b010; sSelDecoB = 3'b100; sSelDecoC = 3'b000; sSelAlu = 3'b001; end
	sStateEscribirR2_dw:	begin sSelDecoA = 3'b001; sSelDecoB = 3'b111; sSelDecoC = 3'b010; sSelAlu = 3'b000; end
	sStateEscribirR1_dw:	begin sSelDecoA = 3'b100; sSelDecoB = 3'b111; sSelDecoC = 3'b001; sSelAlu = 3'b000; end
	endcase
endmodule
