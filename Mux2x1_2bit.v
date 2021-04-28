module Mux2x1_2bit (inp0, inp1, out, sel);
input [1:0] inp0;
input [1:0] inp1;
input sel;
output [1:0] out;

	wire selNot;
	not selNotGate (selNot, sel);

	wire i0, i1;
	and andi0 (i0, inp0[0], selNot);
	and andi1 (i1, inp1[0], sel);
	or orOut0 (out[0], i0, i1);

	wire j0, j1;
	and andj0 (j0, inp0[1], selNot);
	and andj1 (j1, inp1[1], sel);
	or orOut1 (out[1], j0, j1);

endmodule
