module RegWithInit_8bit (clk, rst, d, en, init, q);
input clk;
input rst;
input [7:0] d;
input en;
input init;
output [7:0] q;

	wire initNot;
	not notInit (initNot, init);

	wire [7:0] regInput;
	and and0 (regInput[0], d[0], initNot);
	and and1 (regInput[1], d[1], initNot);
	and and2 (regInput[2], d[2], initNot);
	and and3 (regInput[3], d[3], initNot);
	and and4 (regInput[4], d[4], initNot);
	and and5 (regInput[5], d[5], initNot);
	and and6 (regInput[6], d[6], initNot);
	and and7 (regInput[7], d[7], initNot);

	wire regEn;
	or orRegEn (regEn, en, init);

	Register #(.WIDTH(8)) reg8 (
			.clk(clk),
			.rst(rst),
			.d(regInput),
			.en(regEn),
			.q(q)
			);

endmodule  