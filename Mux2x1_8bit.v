module Mux2x1_8bit (inp0, inp1, out, sel);
input [7:0] inp0;
input [7:0] inp1;
input sel;
output [7:0] out;

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

	wire [1:0] m;
	and andm0 (m[0], inp0[4], selNot);
	and andm1 (m[1], inp1[4], sel);
	or orOut4 (out[4], m[0], m[1]);

	wire [1:0] n;
	and andn0 (n[0], inp0[5], selNot);
	and andn1 (n[1], inp1[5], sel);
	or orOut5 (out[5], n[0], n[1]);

	wire [1:0] o;
	and ando0 (o[0], inp0[6], selNot);
	and ando1 (o[1], inp1[6], sel);
	or orOut6 (out[6], o[0], o[1]);

	wire [1:0] p;
	and andp0 (p[0], inp0[7], selNot);
	and andp1 (p[1], inp1[7], sel);
	or orOut7 (out[7], p[0], p[1]);

endmodule 