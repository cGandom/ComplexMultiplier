module ComplexAdder_10bit (A, B, sum, coReal, coImag);
input [19:0] A;
input [19:0] B;
output [19:0] sum;
output coReal;
output coImag;

	Adder_10bit adderReal (
			.A(A[19:10]),
			.B(B[19:10]),
			.sum(sum[19:10]),
			.co(coReal)
			);

	Adder_10bit adderImag (
			.A(A[9:0]),
			.B(B[9:0]),
			.sum(sum[9:0]),
			.co(coImag)
			);

endmodule 