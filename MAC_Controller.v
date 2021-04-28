module MAC_Controller (clk, rst, start, CMReady, ldArgs, seli, CMStart, init0Acc, ldAcc, ready);
input clk;
input rst;
input start;
input CMReady;
output ldArgs;
output [1:0] seli;
output CMStart;
output init0Acc;
output ldAcc;
output ready;
	
	// D -> input of regs, V->output of regs
	wire [3:0] D, V;
	
	wire [3:0] Vnot;
	wire startNot, CMReadyNot;
	not notV0 (Vnot[0], V[0]);
	not notV1 (Vnot[1], V[1]);
	not notV2 (Vnot[2], V[2]);
	not notV3 (Vnot[3], V[3]);
	not notStart (startNot, start);
	not notCMReady (CMReadyNot, CMReady);


	// Calculating Next State
	
	//assign D[3] = (V2 & V1 & V0) | (V3 & ~V2) | (V3 & ~V0);
	wire [2:0] i;
	and andi0 (i[0], V[2], V[1], V[0]);
	and andi1 (i[1], V[3], Vnot[2]);
	and andi2 (i[2], V[3], Vnot[0]);
	or orD3 (D[3], i[2], i[1], i[0]);

	//assign D[2] = (~V3 & V2 & ~V1) | (V2 & ~V0) | (~CMReady & V3 & V1 & V0) | (CMReady & ~V3 & ~V2 & V1 & V0);
	wire [3:0] j;
	and andj0 (j[0], Vnot[3], V[2], Vnot[1]);
	and andj1 (j[1], V[2], Vnot[0]);
	and andj2 (j[2], CMReadyNot, V[3], V[1], V[0]);
	and andj3 (j[3], CMReady, Vnot[3], Vnot[2], V[1], V[0]);
	or orD2 (D[2], j[3], j[2], j[1], j[0]);

	//assign D[1] = (~CMReady & ~V3 & ~V1 & V0) | (V1 & ~V0) | (~CMReady & ~V3 & ~V2 & V0) 
	//	| (~V3 & ~V2 & ~V1 & V0) | (CMReady & V3 & ~V2 & V0);
	wire [4:0] m;
	and andm0 (m[0], CMReadyNot, Vnot[3], Vnot[1], V[0]);
	and andm1 (m[1], V[1], Vnot[0]);
	and andm2 (m[2], CMReadyNot, Vnot[3], Vnot[2], V[0]);
	and andm3 (m[3], Vnot[3], Vnot[2], Vnot[1], V[0]);
	and andm4 (m[4], CMReady, V[3], Vnot[2], V[0]);
	or orD1 (D[1], m[4], m[3], m[2], m[1], m[0]);

	//assign D[1] = (~CMReady & ~V3 & ~V2 & V1) | (~V3 & V2 & ~V1 & ~V0) | (~CMReady & V3 & ~V2 & ~V1) 
	//	| (CMReady & ~V3 & V2 & ~V1) | (CMReady & V2 & ~V0) | (CMReady & V3 & V1) 
	//	| (start & ~V3 & ~V1 & ~V0) | (~CMReady & ~V2 & V1 & ~V0);
	wire [9:0] n;
	and andn0 (n[0], CMReadyNot, Vnot[3], Vnot[2], V[1]);
	and andn1 (n[1], Vnot[3], V[2], Vnot[1], Vnot[0]);
	and andn2 (n[2], CMReadyNot, V[3], Vnot[2], Vnot[1]);
	and andn3 (n[3], CMReady, Vnot[3], V[2], Vnot[1]);
	and andn4 (n[4], CMReady, V[2], Vnot[0]);
	and andn5 (n[5], CMReady, V[3], V[1]);
	and andn6 (n[6], start, Vnot[3], Vnot[1], Vnot[0]);
	and andn7 (n[7], CMReadyNot, Vnot[2], V[1], Vnot[0]);
	or orn8 (n[8], n[0], n[1], n[2], n[3]);
	or orn9 (n[9], n[4], n[5], n[6], n[7]);
	or orD0 (D[0], n[8], n[9]);


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
	
	and andInit0Acc(init0Acc, Vnot[3], Vnot[2], Vnot[1], V[0]);
	assign ldArgs = init0Acc;

	//assign CMStart = (~V[3] & ~V[2] & V[1] & ~V[0]) | (~V[3] & V[2] & ~V[1] & V[0]) 
	//	| (V[3] & ~V[2] & ~V[1] & ~V[0]) | (V[3] & ~V[2] & V[1] & V[0]);
	wire [3:0] o;
	and ando0 (o[0], Vnot[3], Vnot[2], V[1], Vnot[0]);
	and ando1 (o[1], Vnot[3], V[2], Vnot[1], V[0]);
	and ando2 (o[2], V[3], Vnot[2], Vnot[1], Vnot[0]);
	and ando3 (o[3], V[3], Vnot[2], V[1], V[0]);
	or orCMStart (CMStart, o[3], o[2], o[1], o[0]);

	//assign seli[0] = (~V[3] & V[2]) | (V[3] & ~V[2] & V[1]) | (V[2] & ~V[1]);
	wire [2:0] p;
	and andp0 (p[0], Vnot[3], V[2]);
	and andp1 (p[1], V[3], Vnot[2], V[1]);
	and andp2 (p[2], V[2], Vnot[1]);
	or orSeli0 (seli[0], p[2], p[1], p[0]);


	//assign seli[1] = (V[3] & ~V[2]) | (~V[1] & ~V[0]);
	wire [1:0] q;
	and andq0 (q[0], V[3], Vnot[2]);
	and andq1 (q[1], Vnot[1], Vnot[0]);
	or orSeli1 (seli[1], q[1], q[0]);

	//assign ldAcc = (~V[3] & V[2] & ~V[1] & ~V[0]) | (~V[3] & V[2] & V[1] & V[0]) 
	//	| (V[3] & ~V[2] & V[1] & ~V[0]) | (V[3] & V[2] & ~V[1] & V[0]);
	wire [3:0] r;
	and andr0 (r[0], Vnot[3], V[2], Vnot[1], Vnot[0]);
	and andr1 (r[1], Vnot[3], V[2], V[1], V[0]);
	and andr2 (r[2], V[3], Vnot[2], V[1], Vnot[0]);
	and andr3 (r[3], V[3], V[2], Vnot[1], V[0]);
	or orldAcc (ldAcc, r[3], r[2], r[1], r[0]);

endmodule 