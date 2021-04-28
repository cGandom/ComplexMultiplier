module Multiplier4x4_Datapath (clk, rst, A, B, selA, selB, ldA, ldB, shiftSel, ldRes, init0Res, res);
input clk;
input rst;
input [3:0] A;
input [3:0] B;
input selA;
input selB;
input ldA;
input ldB;
input [1:0] shiftSel;
input ldRes;
input init0Res;
output [7:0] res;

	wire [3:0] Astored, Bstored;
	Register #(.WIDTH(4)) regA (
			.clk(clk),
			.rst(rst),			
			.d(A),
			.q(Astored),
			.en(ldA)
			);
	Register #(.WIDTH(4)) regB (
			.clk(clk),
			.rst(rst),			
			.d(B),
			.q(Bstored),
			.en(ldB)
			);
	
	wire [1:0] selectedA, selectedB;
	Mux2x1_2bit muxA (
			.inp0(Astored[3:2]),
			.inp1(Astored[1:0]),
			.sel(selA),
			.out(selectedA)
			);
	Mux2x1_2bit muxB (
			.inp0(Bstored[3:2]),
			.inp1(Bstored[1:0]),
			.sel(selB),
			.out(selectedB)
			);

	wire [3:0] mult2x2Res;
	Multiplier2x2 mult2x2 (
			.a(selectedA),
			.b(selectedB),
			.c(mult2x2Res)
			);

	wire [7:0] shiftedMultRes;
	Mux4x1_8bit toAdderMux (
			.inp0({mult2x2Res, 4'b0}),
			.inp1({2'b0, mult2x2Res, 2'b0}),
			.inp2({4'b0, mult2x2Res}),
			.inp3(),
			.sel(shiftSel),
			.out(shiftedMultRes)
			);

	wire [7:0] adderResult;
	Adder_8bit adder (
			.A(shiftedMultRes),
			.B(res),
			.sum(adderResult),
			.co()
			);

	RegWithInit_8bit resReg (
			.clk(clk),
			.rst(rst),
			.d(adderResult),
			.en(ldRes),
			.init(init0Res),
			.q(res)
			);

endmodule 