module Multiplier4x4 (clk, rst, A, B, start, res, ready);
input clk;
input rst;
input [3:0] A;
input [3:0] B;
input start;
output [7:0] res;
output ready;

	wire selA, selB, ldA, ldB, ldRes, init0Res;
	wire [1:0] shiftSel;

	Multiplier4x4_Datapath datapath (
			.clk(clk), 
			.rst(rst), 
			.A(A), 
			.B(B), 
			.selA(selA), 
			.selB(selB), 
			.ldA(ldA), 
			.ldB(ldB), 
			.shiftSel(shiftSel), 
			.ldRes(ldRes), 
			.init0Res(init0Res), 
			.res(res)
			);

	Multiplier4x4_Controller controller (
			.clk(clk), 
			.rst(rst), 
			.start(start), 
			.ready(ready), 
			.ldA(ldA), 
			.ldB(ldB), 
			.init0Res(init0Res), 
			.selA(selA), 
			.selB(selB), 
			.shiftSel(shiftSel), 
			.ldRes(ldRes)
			);

endmodule
