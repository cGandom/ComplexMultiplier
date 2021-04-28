module ComplexMultiplier_Datapath (clk, rst, X, Y, ldX, ldY, selX, selY, startMul, 
				addBarSub, ldRR, ldIR, initRR, initIR, selA, mulReady, res);
input clk;
input rst;
input [7:0] X;
input [7:0] Y;
input ldX;
input ldY;
input selX; 
input selY; 
input startMul; 
input addBarSub;
input ldRR;
input ldIR;
input initRR; 
input initIR; 
input selA; 
output mulReady;
output [15:0] res;

	wire [7:0] Xstored, Ystored;
	
	Register #(.WIDTH(8)) regX (
			.clk(clk),
			.rst(rst),
			.d(X),
			.en(ldX),
			.q(Xstored)
			);

	Register #(.WIDTH(8)) regY (
			.clk(clk),
			.rst(rst),
			.d(Y),
			.en(ldY),
			.q(Ystored)
			);

	wire [3:0] selectedX, selectedY;
	
	Mux2x1_4bit muxSelX (
			.inp0(Xstored[7:4]),
			.inp1(Xstored[3:0]),
			.sel(selX),
			.out(selectedX)
			);
	
	Mux2x1_4bit muxSelY (
			.inp0(Ystored[7:4]),
			.inp1(Ystored[3:0]),
			.sel(selY),
			.out(selectedY)
			);

	wire [7:0] multResult;

	Multiplier4x4 mult4x4 (
			.clk(clk),
			.rst(rst),
			.A(selectedX),
			.B(selectedY),
			.start(startMul),
			.res(multResult),
			.ready(mulReady)
			);

	wire [7:0] selectedA, adderResult;

	AdderAndSubtractor_8bit addnsub (
			.A(selectedA), 
			.B(multResult), 
			.res(adderResult), 
			.co(), 
			.addBarSub(addBarSub)
			);

	RegWithInit_8bit RealResReg (
			.clk(clk),
			.rst(rst),
			.d(adderResult),
			.en(ldRR),
			.init(initRR),
			.q(res[15:8])
			);

	RegWithInit_8bit ImagResReg (
			.clk(clk),
			.rst(rst),
			.d(adderResult),
			.en(ldIR),
			.init(initIR),
			.q(res[7:0])
			);

	Mux2x1_8bit muxSelA (
			.inp0(res[15:8]),
			.inp1(res[7:0]),
			.sel(selA),
			.out(selectedA)
			);

endmodule 