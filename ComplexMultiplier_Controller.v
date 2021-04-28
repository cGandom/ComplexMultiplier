module ComplexMultiplier_Controller (clk, rst, start, mulReady, ldX, ldY, initRR,
			 initIR, startMul, selX, selY, addBarSub, selA, ldRR, ldIR, ready);
input clk;
input rst;
input start;
input mulReady;
output ldX;
output ldY;
output initRR;
output initIR;
output startMul;
output selX;
output selY;
output addBarSub;
output selA;
output ldRR;
output ldIR;
output ready;

	// D -> input of regs, V->output of regs
	wire [3:0] D, V;
	
	wire [3:0] Vnot;
	wire startNot, mulReadyNot;
	not notV0 (Vnot[0], V[0]);
	not notV1 (Vnot[1], V[1]);
	not notV2 (Vnot[2], V[2]);
	not notV3 (Vnot[3], V[3]);
	not notStart (startNot, start);
	not notMulReady (mulReadyNot, mulReady);


	// Calculating Next State

	//assign D[3] = (V[3] & ~V[2]) | (V[3] & ~V[1]) | (mulReady & V[2] & V[1] & V[0]);
	wire [2:0] i;
	and andi0 (i[0], V[3], Vnot[2]);
	and andi1 (i[1], V[3], Vnot[1]);
	and andi2 (i[2], mulReady, V[2], V[1], V[0]);
	or orD3 (D[3], i[2], i[1], i[0]);
	
	//assign D[2] = (~mulReady & V[1] & V[0]) | (V[2] & ~V[1]) | (~V[3] & V[2] & ~V[0]) | (V[3] & V[1] & V[0]);
	wire [3:0] j;
	and andj0 (j[0], mulReadyNot, V[1], V[0]);
	and andj1 (j[1], V[2], Vnot[1]);
	and andj2 (j[2], Vnot[3], V[2], Vnot[0]);
	and andj3 (j[3], V[3], V[1], V[0]);
	or orD2 (D[2], j[3], j[2], j[1], j[0]);

	//assign D[1] = (~V[2] & V[1] & ~V[0]) | (~V[3] & V[1] & ~V[0]) | (~mulReady & V[3] & ~V[2] & ~V[1] & V[0]) 
	//		| (mulReady & ~V[3] & ~V[2] & V[1]) | (~start & ~V[3] & ~V[1] & V[0]) 
	//		| (~mulReady & ~V[3] & V[2] & V[0]) | (mulReady & V[2] & ~V[1] & V[0]);
	wire [8:0] m;
	and andm0 (m[0], Vnot[2], V[1], Vnot[0]);
	and andm1 (m[1], Vnot[3], V[1], Vnot[0]);
	and andm2 (m[2], mulReadyNot, V[3], Vnot[2], Vnot[1], V[0]);
	and andm3 (m[3], mulReady, Vnot[3], Vnot[2], V[1]);
	and andm4 (m[4], startNot, Vnot[3], Vnot[1], V[0]);
	and andm5 (m[5], mulReadyNot, Vnot[3], V[2], V[0]);
	and andm6 (m[6], mulReady, V[2], Vnot[1], V[0]);
	or orm7 (m[7], m[0], m[1], m[2], m[3]);
	or orm8 (m[8], m[4], m[5], m[6]);
	or orD1 (D[1], m[8], m[7]);
	
		
	//assign D[0] = (mulReady & ~V[3] & ~V[2] & V[1]) | (mulReady & ~V[3] & V[2] & ~V[1] & ~V[0]) | (mulReady & V[3] & ~V[2] & ~V[1])
	//		 | (start & ~V[3] & ~V[2] & ~V[1]) | (~mulReady & ~V[3] & V[1] & ~V[0]) | (~mulReady & ~V[3] & V[2] & V[1]) 
	//		 | (~mulReady & V[3] & ~V[1] & ~V[0]) | (~mulReady & V[3] & V[2] & ~V[1]) | (mulReady & ~V[2] & V[1] & ~V[0]);
	wire [11:0] n;
	and andn0 (n[0], mulReady, Vnot[3], Vnot[2], V[1]);
	and andn1 (n[1], mulReady, Vnot[3], V[2], Vnot[1], Vnot[0]);
	and andn2 (n[2], mulReady, V[3], Vnot[2], Vnot[1]);
	and andn3 (n[3], start, Vnot[3], Vnot[2], Vnot[1]);
	and andn4 (n[4], mulReadyNot, Vnot[3], V[1], Vnot[0]);
	and andn5 (n[5], mulReadyNot, Vnot[3], V[2], V[1]);
	and andn6 (n[6], mulReadyNot, V[3], Vnot[1], Vnot[0]);
	and andn7 (n[7], mulReadyNot, V[3], V[2], Vnot[1]);
	and andn8 (n[8], mulReady, Vnot[2], V[1], Vnot[0]);
	or orn9 (n[9], n[0], n[1], n[2], n[3]);
	or orn10 (n[10], n[4], n[5], n[6]);
	or orn11 (n[11], n[7], n[8]);
	or orD0 (D[0], n[11], n[10], n[9]);


	// Registers

	Register #(.WIDTH(1)) regV3 (
			.clk(clk),
			.rst(rst),
			.d(D[3]),
			.en(1'b1),
			.q(V[3])
			);

	Register #(.WIDTH(1)) regV2 (
			.clk(clk),
			.rst(rst),
			.d(D[2]),
			.en(1'b1),
			.q(V[2])
			);

	Register #(.WIDTH(1)) regV1 (
			.clk(clk),
			.rst(rst),
			.d(D[1]),
			.en(1'b1),
			.q(V[1])
			);

	Register #(.WIDTH(1)) regV0 (
			.clk(clk),
			.rst(rst),
			.d(D[0]),
			.en(1'b1),
			.q(V[0])
			);

	// Outputs

	and andready (ready, Vnot[3], Vnot[2], Vnot[1], Vnot[0]);

	and andldX (ldX, Vnot[3], Vnot[2], V[1], Vnot[0]);
	assign ldY = ldX;
	assign initRR = ldX;
	assign initIR = ldX;

	//assign startMul = (~V3 & ~V2 & V0) | (~V3 & V2 & ~V0) | (~V2 & ~V1 & V0) | (V2 & ~V1 & ~V0);
	wire [3:0] o;
	and ando0 (o[0], Vnot[3], Vnot[2], V[0]);
	and ando1 (o[1], Vnot[3], V[2], Vnot[0]);
	and ando2 (o[2], Vnot[2], Vnot[1], V[0]);
	and ando3 (o[3], V[2], Vnot[1], Vnot[0]);
	or orStartMul (startMul, o[3], o[2], o[1], o[0]);

	//assign selX = (~V3 & V2 & V1) | (V3 & V2 & ~V1);
	wire [1:0] p;
	and andp0 (p[0], Vnot[3], V[2], V[1]);
	and andp1 (p[1], V[3], V[2], Vnot[1]);
	or orSelX (selX, p[1], p[0]);

	//assign selY = (~V3 & V2 & V1) | (V3 & ~V2);
	wire [1:0] q;
	and andq0 (q[0], Vnot[3], V[2], V[1]);
	and andq1 (q[1], V[3], Vnot[2]);
	or orSelY (selY, q[1], q[0]);

	and andAddBarSub (addBarSub, V[3], Vnot[2], Vnot[1], Vnot[0]);

	//assign ldRR = (~V3 & V2 & ~V1 & V0) | (V3 & ~V2 & ~V1 & ~V0);
	wire [1:0] r;
	and andr0 (r[0], Vnot[3], V[2], Vnot[1], V[0]);
	and andr1 (r[1], V[3], Vnot[2], Vnot[1], Vnot[0]);
	or orldRR (ldRR, r[1], r[0]);

	//assign ldIR = (V3 & ~V2 & V1 & V0) | (V3 & V2 & V1 & ~V0);
	wire [1:0] s;
	and ands0 (s[0], V[3], Vnot[2], V[1], V[0]);
	and ands1 (s[1], V[3], V[2], V[1], Vnot[0]);
	or orldIR (ldIR, s[1], s[0]);

	//assign selA = (~V[2] & V[0]) | (V[1] & ~V[0]);
	wire [1:0] t;
	and andt0 (t[0], Vnot[2], V[0]);
	and andt1 (t[1], V[1], Vnot[0]);
	or orselA (selA, t[1], t[0]);

endmodule 