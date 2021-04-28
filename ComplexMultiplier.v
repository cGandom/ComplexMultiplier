module ComplexMultiplier (clk, rst, X, Y, start, res, ready);
input clk;
input rst;
input [7:0] X;
input [7:0] Y;
input start;
output [15:0] res;
output ready;

	wire ldX, ldY, initRR, initIR, startMul;
	wire selX, selY, addBarSub, selA, ldRR, ldIR;
	wire mulReady;

	ComplexMultiplier_Datapath datapath (
			.clk(clk), 
			.rst(rst), 
			.X(X), 
			.Y(Y), 
			.ldX(ldX), 
			.ldY(ldY), 
			.selX(selX), 
			.selY(selY), 
			.startMul(startMul), 
			.addBarSub(addBarSub), 
			.ldRR(ldRR), 
			.ldIR(ldIR), 
			.initRR(initRR), 
			.initIR(initIR), 
			.selA(selA), 
			.mulReady(mulReady), 
			.res(res)
			);

	ComplexMultiplier_Controller controller (
			.clk(clk), 
			.rst(rst), 
			.start(start), 
			.mulReady(mulReady), 
			.ldX(ldX), 
			.ldY(ldY), 
			.initRR(initRR),
			.initIR(initIR), 
			.startMul(startMul), 
			.selX(selX), 
			.selY(selY), 
			.addBarSub(addBarSub), 
			.selA(selA), 
			.ldRR(ldRR), 
			.ldIR(ldIR),
			.ready(ready)
			);




endmodule
