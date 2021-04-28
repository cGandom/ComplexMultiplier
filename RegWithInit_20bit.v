module RegWithInit_20bit (clk, rst, d, en, init, q);
input clk;
input rst;
input [19:0] d;
input en;
input init;
output [19:0] q;

	wire initNot;
	not notInit (initNot, init);

	wire [19:0] regInput;
	and and0 (regInput[0], d[0], initNot);
	and and1 (regInput[1], d[1], initNot);
	and and2 (regInput[2], d[2], initNot);
	and and3 (regInput[3], d[3], initNot);
	and and4 (regInput[4], d[4], initNot);
	and and5 (regInput[5], d[5], initNot);
	and and6 (regInput[6], d[6], initNot);
	and and7 (regInput[7], d[7], initNot);
	and and8 (regInput[8], d[8], initNot);
	and and9 (regInput[9], d[9], initNot);
	and and10 (regInput[10], d[10], initNot);
	and and11 (regInput[11], d[11], initNot);
	and and12 (regInput[12], d[12], initNot);
	and and13 (regInput[13], d[13], initNot);
	and and14 (regInput[14], d[14], initNot);
	and and15 (regInput[15], d[15], initNot);
	and and16 (regInput[16], d[16], initNot);
	and and17 (regInput[17], d[17], initNot);
	and and18 (regInput[18], d[18], initNot);
	and and19 (regInput[19], d[19], initNot);

	wire regEn;
	or orRegEn (regEn, en, init);

	Register #(.WIDTH(20)) reg20 (
			.clk(clk),
			.rst(rst),
			.d(regInput),
			.en(regEn),
			.q(q)
			);

endmodule  
