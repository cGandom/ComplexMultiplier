module Mux2x1_4bit (inp0, inp1, out, sel);
input [3:0] inp0;
input [3:0] inp1;
input sel;
output [3:0] out;

	wire selNot;
	not selNotGate (selNot, sel);

	wire [1:0] i;
	and andi0 (i[0], inp0[0], selNot);
	and andi1 (i[1], inp1[0], sel);
	or orOut0 (out[0], i[0], i[1]);

	wire [1:0] j;
	and andj0 (j[0], inp0[1], selNot);
	and andj1 (j[1], inp1[1], sel);
	or orOut1 (out[1], j[0], j[1]);

	wire [1:0] k;
	and andk0 (k[0], inp0[2], selNot);
	and andk1 (k[1], inp1[2], sel);
	or orOut2 (out[2], k[0], k[1]);

	wire [1:0] l;
	and andl0 (l[0], inp0[3], selNot);
	and andl1 (l[1], inp1[3], sel);
	or orOut3 (out[3], l[0], l[1]);

endmodule
