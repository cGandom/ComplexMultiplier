module ComplexMultiplier_Controller (clk, rst, start, mulReady, ldX, ldY, initRR,
			 initIR, startMul, selX, selY, addBarSub, selA, ldRR, ldIR, ready);
input clk;
input rst;
input start;
input mulReady;
output reg ldX;
output reg ldY;
output reg initRR;
output reg initIR;
output reg startMul;
output reg selX;
output reg selY;
output reg addBarSub;
output reg selA;
output reg ldRR;
output reg ldIR;
output reg ready;

	parameter Idle = 4'd0, Wait = 4'd1, Load = 4'd2,
		 	Real1_1 = 4'd3, Real1_2 = 4'd4, Real1_3 = 4'd5,
			Real2_1 = 4'd6, Real2_2 = 4'd7, Real2_3 = 4'd8,
			Imag1_1 = 4'd9, Imag1_2 = 4'd10, Imag1_3 = 4'd11,
			Imag2_1 = 4'd12, Imag2_2 = 4'd13, Imag2_3 = 4'd14;

	reg [3:0] ps, ns;

	always @ (ps or start or mulReady) begin
		ns = 4'd0;
		case (ps)
		Idle: ns = start? Wait: Idle;
		Wait: ns = ~start? Load: Wait;
		Load: ns = Real1_1;

		Real1_1: ns = ~mulReady? Real1_2: Real1_1;
		Real1_2: ns = mulReady? Real1_3: Real1_2;
		Real1_3: ns = Real2_1;

		Real2_1: ns = ~mulReady? Real2_2: Real2_1;
		Real2_2: ns = mulReady? Real2_3: Real2_2;
		Real2_3: ns = Imag1_1;

		Imag1_1: ns = ~mulReady? Imag1_2: Imag1_1;
		Imag1_2: ns = mulReady? Imag1_3: Imag1_2;
		Imag1_3: ns = Imag2_1;

		Imag2_1: ns = ~mulReady? Imag2_2: Imag2_1;
		Imag2_2: ns = mulReady? Imag2_3: Imag2_2;
		Imag2_3: ns = Idle;

		default: ns = Idle;
		endcase
	end


	always @(ps) begin
		{ldX, ldY, initRR, initIR, startMul, 
		selX, selY, addBarSub, selA, ldRR, ldIR, ready} = 12'b0;
		case (ps)
		Idle: ready = 1'b1;
		Wait: ;
		Load: {ldX, ldY, initRR, initIR, startMul} = 5'b11110;

		Real1_1: {selX, selY, startMul} = 3'b001;
		Real1_2: {selX, selY} = 2'b00;
		Real1_3: {addBarSub, selA, ldRR, startMul} = 4'b0010;

		Real2_1: {selX, selY, startMul} = 3'b111;
		Real2_2: {selX, selY} = 2'b11;
		Real2_3: {addBarSub, selA, ldRR, startMul} = 4'b1010;

		Imag1_1: {selX, selY, startMul} = 3'b011;
		Imag1_2: {selX, selY} = 2'b01;
		Imag1_3: {addBarSub, selA, ldIR, startMul} = 4'b0110;

		Imag2_1: {selX, selY, startMul} = 3'b101;
		Imag2_2: {selX, selY} = 2'b10;
		Imag2_3: {addBarSub, selA, ldIR, startMul} = 4'b0110;
		endcase

	end

	always @(posedge clk or posedge rst) begin
		if (rst) ps <= 4'b0;
		else ps <= ns;
	end


endmodule 