module Adder_10bit (A, B, sum, co);
input [9:0] A;
input [9:0] B;
output [9:0] sum;
output co;

	wire [8:0] carry;

	FA fa0 (.a(A[0]), .b(B[0]), .ci(1'b0), .s(sum[0]), .co(carry[0]));
	FA fa1 (.a(A[1]), .b(B[1]), .ci(carry[0]), .s(sum[1]), .co(carry[1]));
	FA fa2 (.a(A[2]), .b(B[2]), .ci(carry[1]), .s(sum[2]), .co(carry[2]));
	FA fa3 (.a(A[3]), .b(B[3]), .ci(carry[2]), .s(sum[3]), .co(carry[3]));
	FA fa4 (.a(A[4]), .b(B[4]), .ci(carry[3]), .s(sum[4]), .co(carry[4]));
	FA fa5 (.a(A[5]), .b(B[5]), .ci(carry[4]), .s(sum[5]), .co(carry[5]));
	FA fa6 (.a(A[6]), .b(B[6]), .ci(carry[5]), .s(sum[6]), .co(carry[6]));
	FA fa7 (.a(A[7]), .b(B[7]), .ci(carry[6]), .s(sum[7]), .co(carry[7]));
	FA fa8 (.a(A[8]), .b(B[8]), .ci(carry[7]), .s(sum[8]), .co(carry[8]));
	FA fa9 (.a(A[9]), .b(B[9]), .ci(carry[8]), .s(sum[9]), .co(co));

endmodule 