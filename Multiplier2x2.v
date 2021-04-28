module Multiplier2x2 (a, b, c);
input [1:0] a;
input [1:0] b;
output [3:0] c;

	wire [1:0] aNot, bNot;
	not nota0 (aNot[0], a[0]);
	not nota1 (aNot[1], a[1]);
	not notb0 (bNot[0], b[0]);
	not notb1 (bNot[1], b[1]);

	and andc3 (c[3], a[1], a[0], b[1], b[0]);
	
	wire i0, i1;
	and andi0 (i0, a[1], aNot[0], b[1]);
	and andi1 (i1, a[1], b[1], bNot[0]);
	or orc2 (c[2], i0, i1);

	wire j0, j1, j2, j3;
	and andj0 (j0, a[1], bNot[1], b[0]);
	and andj1 (j1, a[1], aNot[0], b[0]);
	and andj2 (j2, aNot[1], a[0], b[1]);
	and andj3 (j3, a[0], b[1], bNot[0]);
	or orc1 (c[1], j0, j1, j2, j3);

	and andc0 (c[0], a[0], b[0]);

endmodule 