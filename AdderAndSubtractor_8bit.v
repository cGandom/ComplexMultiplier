module AdderAndSubtractor_8bit (A, B, res, co, addBarSub);
input [7:0] A;
input [7:0] B;
input addBarSub;
output [7:0] res;
output co;

	wire [7:0] Binput;
	xor xorBinput0 (Binput[0], B[0], addBarSub);
	xor xorBinput1 (Binput[1], B[1], addBarSub);
	xor xorBinput2 (Binput[2], B[2], addBarSub);
	xor xorBinput3 (Binput[3], B[3], addBarSub);
	xor xorBinput4 (Binput[4], B[4], addBarSub);
	xor xorBinput5 (Binput[5], B[5], addBarSub);
	xor xorBinput6 (Binput[6], B[6], addBarSub);
	xor xorBinput7 (Binput[7], B[7], addBarSub);

	wire [6:0] carry;

	FA fa0 (.a(A[0]), .b(Binput[0]), .ci(addBarSub), .s(res[0]), .co(carry[0]));
	FA fa1 (.a(A[1]), .b(Binput[1]), .ci(carry[0]), .s(res[1]), .co(carry[1]));
	FA fa2 (.a(A[2]), .b(Binput[2]), .ci(carry[1]), .s(res[2]), .co(carry[2]));
	FA fa3 (.a(A[3]), .b(Binput[3]), .ci(carry[2]), .s(res[3]), .co(carry[3]));
	FA fa4 (.a(A[4]), .b(Binput[4]), .ci(carry[3]), .s(res[4]), .co(carry[4]));
	FA fa5 (.a(A[5]), .b(Binput[5]), .ci(carry[4]), .s(res[5]), .co(carry[5]));
	FA fa6 (.a(A[6]), .b(Binput[6]), .ci(carry[5]), .s(res[6]), .co(carry[6]));
	FA fa7 (.a(A[7]), .b(Binput[7]), .ci(carry[6]), .s(res[7]), .co(co));

endmodule 
