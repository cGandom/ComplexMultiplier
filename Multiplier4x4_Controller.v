module Multiplier4x4_Controller (clk, rst, start, ready, ldA, ldB, init0Res, selA, selB, shiftSel, ldRes);
input clk;
input rst;
input start;
output ready;
output ldA;
output ldB;
output init0Res;
output selA; 
output selB; 
output[1:0] shiftSel;
output ldRes;

	// D -> input of regs, V->output of regs
	wire [2:0] D, V;
	
	wire [2:0] Vnot;
	wire startNot;
	not notV0 (Vnot[0], V[0]);
	not notV1 (Vnot[1], V[1]);
	not notV2 (Vnot[2], V[2]);
	not notStart (startNot, start);


	// Calculating Next State

	wire [1:0] i;
	and andD2i0 (i[0], V[2], Vnot[1]);
	and andD2i1 (i[1], V[1], V[0]);
	or orD2 (D[2], i[1], i[0]);

	wire [2:0] j;
	and andD1j0 (j[0], Vnot[2], V[1], Vnot[0]);
	and andD1j1 (j[1], start, V[2], V[0]);
	and andD1j2 (j[2], startNot, Vnot[1], V[0]);
	or orD1 (D[1], j[2], j[1], j[0]);

	wire [2:0] k;
	and andD0k0 (k[0], V[2], Vnot[1], Vnot[0]);
	and andD0k1 (k[1], start, Vnot[2], Vnot[1]);
	and andD0k2 (k[2], Vnot[2], V[1], Vnot[0]);
	or orD0 (D[0], k[2], k[1], k[0]);


	// Registers

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
	
	and andReady (ready, Vnot[2], Vnot[1], Vnot[0]);
	
	and andLdA (ldA, Vnot[2], V[1], Vnot[0]);
	assign ldB = ldA;
	assign init0Res = ldA;

	xor xorSelA (selA, V[1], V[0]);

	and andSelB (selB, V[2], Vnot[0]);

	wire m;
	and andM0 (m, V[1], V[0]);
	or orLdRes (ldRes, V[2], m);

	and andShiftSel0 (shiftSel[0], V[2], Vnot[1]);
	and andShiftSel1 (shiftSel[1], V[1], Vnot[0]);
	

endmodule 
