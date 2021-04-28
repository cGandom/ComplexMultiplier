module MAC (clk, rst, X0, X1, X2, X3, Y0, Y1, Y2, Y3, start, res, ready);
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
input start;
output [19:0] res;
output ready;

	wire ldArgs, CMStart, init0Acc, ldAcc, CMReady;
	wire [1:0] seli;

	MAC_Datapath datapath (
			.clk(clk), 
			.rst(rst), 
			.X0(X0), 
			.X1(X1), 
			.X2(X2), 
			.X3(X3), 
			.Y0(Y0), 
			.Y1(Y1), 
			.Y2(Y2), 
			.Y3(Y3), 
			.ldArgs(ldArgs), 
			.seli(seli), 
			.CMStart(CMStart), 
			.init0Acc(init0Acc), 
			.ldAcc(ldAcc), 
			.res(res), 
			.CMReady(CMReady)
			);


	MAC_Controller controller (
			.clk(clk), 
			.rst(rst), 
			.start(start), 
			.CMReady(CMReady), 
			.ldArgs(ldArgs), 
			.seli(seli), 
			.CMStart(CMStart), 
			.init0Acc(init0Acc), 
			.ldAcc(ldAcc), 
			.ready(ready)
			);


endmodule 