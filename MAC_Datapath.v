module MAC_Datapath (clk, rst, X0, X1, X2, X3, Y0, Y1, Y2, Y3, ldArgs, seli, CMStart, init0Acc, ldAcc, res, CMReady);
input clk;
input rst;
input [7:0] X0;
input [7:0] X1;
input [7:0] X2;
input [7:0] X3;
input [7:0] Y0;
input [7:0] Y1;
input [7:0] Y2;
input [7:0] Y3;
input ldArgs;
input [1:0]seli;
input CMStart;
input init0Acc;
input ldAcc;
output [19:0] res;
output CMReady;

	
	wire [7:0] X0stored, X1stored, X2stored, X3stored;
	wire [7:0] Y0stored, Y1stored, Y2stored, Y3stored;

	Register #(.WIDTH(8)) regX0 (
			.clk(clk),
			.rst(rst),
			.d(X0),
			.en(ldArgs),
			.q(X0stored)
			);

	Register #(.WIDTH(8)) regX1 (
			.clk(clk),
			.rst(rst),
			.d(X1),
			.en(ldArgs),
			.q(X1stored)
			);

	Register #(.WIDTH(8)) regX2 (
			.clk(clk),
			.rst(rst),
			.d(X2),
			.en(ldArgs),
			.q(X2stored)
			);

	Register #(.WIDTH(8)) regX3 (
			.clk(clk),
			.rst(rst),
			.d(X3),
			.en(ldArgs),
			.q(X3stored)
			);

	Register #(.WIDTH(8)) regY0 (
			.clk(clk),
			.rst(rst),
			.d(Y0),
			.en(ldArgs),
			.q(Y0stored)
			);

	Register #(.WIDTH(8)) regY1 (
			.clk(clk),
			.rst(rst),
			.d(Y1),
			.en(ldArgs),
			.q(Y1stored)
			);

	Register #(.WIDTH(8)) regY2 (
			.clk(clk),
			.rst(rst),
			.d(Y2),
			.en(ldArgs),
			.q(Y2stored)
			);

	Register #(.WIDTH(8)) regY3 (
			.clk(clk),
			.rst(rst),
			.d(Y3),
			.en(ldArgs),
			.q(Y3stored)
			);

	wire [7:0] selectedX, selectedY;
	
	Mux4x1_8bit muxSelX (
			.inp0(X0stored),
			.inp1(X1stored),
			.inp2(X2stored),
			.inp3(X3stored),
			.sel(seli),
			.out(selectedX)
			);

	Mux4x1_8bit muxSelY (
			.inp0(Y0stored),
			.inp1(Y1stored),
			.inp2(Y2stored),
			.inp3(Y3stored),
			.sel(seli),
			.out(selectedY	)
			);

	wire [15:0] multResult;

	ComplexMultiplier complexmult (
			.clk(clk), 
			.rst(rst), 
			.X(selectedX), 
			.Y(selectedY), 
			.start(CMStart), 
			.res(multResult), 
			.ready(CMReady)
			);

	wire [19:0] multResultSE;
	ComplexSignExtend signext (
			.inp(multResult),
			.out(multResultSE)
			);

	
	wire [19:0] adderResult;
	ComplexAdder_10bit complexadder (	
			.A(res), 
			.B(multResultSE), 
			.sum(adderResult), 
			.coReal(), 
			.coImag()
			);

	
	RegWithInit_20bit accReg (
			.clk(clk),
			.rst(rst),
			 .d(adderResult), 
			.en(ldAcc), 
			.init(init0Acc), 
			.q(res)
			);


endmodule 