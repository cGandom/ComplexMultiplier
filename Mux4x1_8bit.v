module Mux4x1_8bit (inp0, inp1, inp2, inp3, out, sel);
input [7:0] inp0;
input [7:0] inp1;
input [7:0] inp2;
input [7:0] inp3;
input [1:0] sel;
output [7:0] out;

	wire [1:0] selNot;
	not selNot0Gate (selNot[0], sel[0]);
	not selNot1Gate (selNot[1], sel[1]);

	wire [3:0] i;
	and andi0 (i[0], inp0[0], selNot[1], selNot[0]);
	and andi1 (i[1], inp1[0], selNot[1], sel[0]);
	and andi2 (i[2], inp2[0], sel[1], selNot[0]);
	and andi3 (i[3], inp3[0], sel[1], sel[0]);
	or orOut0 (out[0], i[0], i[1], i[2], i[3]);

	wire [3:0] j;
	and andj0 (j[0], inp0[1], selNot[1], selNot[0]);
	and andj1 (j[1], inp1[1], selNot[1], sel[0]);
	and andj2 (j[2], inp2[1], sel[1], selNot[0]);
	and andj3 (j[3], inp3[1], sel[1], sel[0]);
	or orOut1 (out[1], j[0], j[1], j[2], j[3]);

	wire [3:0] k;
	and andk0 (k[0], inp0[2], selNot[1], selNot[0]);
	and andk1 (k[1], inp1[2], selNot[1], sel[0]);
	and andk2 (k[2], inp2[2], sel[1], selNot[0]);
	and andk3 (k[3], inp3[2], sel[1], sel[0]);
	or orOut2 (out[2], k[0], k[1], k[2], k[3]);

	wire [3:0] l;
	and andl0 (l[0], inp0[3], selNot[1], selNot[0]);
	and andl1 (l[1], inp1[3], selNot[1], sel[0]);
	and andl2 (l[2], inp2[3], sel[1], selNot[0]);
	and andl3 (l[3], inp3[3], sel[1], sel[0]);
	or orOut3 (out[3], l[0], l[1], l[2], l[3]);

	wire [3:0] m;
	and andm0 (m[0], inp0[4], selNot[1], selNot[0]);
	and andm1 (m[1], inp1[4], selNot[1], sel[0]);
	and andm2 (m[2], inp2[4], sel[1], selNot[0]);
	and andm3 (m[3], inp3[4], sel[1], sel[0]);
	or orOut4 (out[4], m[0], m[1], m[2], m[3]);

	wire [3:0] n;
	and andn0 (n[0], inp0[5], selNot[1], selNot[0]);
	and andn1 (n[1], inp1[5], selNot[1], sel[0]);
	and andn2 (n[2], inp2[5], sel[1], selNot[0]);
	and andn3 (n[3], inp3[5], sel[1], sel[0]);
	or orOut5 (out[5], n[0], n[1], n[2], n[3]);
	
	wire [3:0] o;
	and ando0 (o[0], inp0[6], selNot[1], selNot[0]);
	and ando1 (o[1], inp1[6], selNot[1], sel[0]);
	and ando2 (o[2], inp2[6], sel[1], selNot[0]);
	and ando3 (o[3], inp3[6], sel[1], sel[0]);
	or orOut6 (out[6], o[0], o[1], o[2], o[3]);

	wire [3:0] p;
	and andp0 (p[0], inp0[7], selNot[1], selNot[0]);
	and andp1 (p[1], inp1[7], selNot[1], sel[0]);
	and andp2 (p[2], inp2[7], sel[1], selNot[0]);
	and andp3 (p[3], inp3[7], sel[1], sel[0]);
	or orOut7 (out[7], p[0], p[1], p[2], p[3]);
	
endmodule 