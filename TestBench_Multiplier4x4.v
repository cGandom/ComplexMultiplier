`timescale 1ns/1ns

module TestBench_Multiplier4x4 ();

	reg [3:0] A, B;
	reg start;
	wire ready;
	wire [7:0] res;

	reg rst = 0;
	reg clk = 1;
	always #37 clk = ~clk;

	Multiplier4x4 mult (
			.clk(clk),
			.rst(rst),
			.A(A),
			.B(B),
			.start(start),
			.ready(ready),
			.res(res)
			);

	integer i, j;
	initial begin
		rst = 0;
		start = 0;
		#20
		rst = 1;
		#50
		rst = 0;
		#50
		/*A = 10;
		B = 12;
		#40
		start = 1;
		#100
		start = 0;
		#3000*/
		
		for (i = 0; i < 16; i= i+1) begin
			for (j = 0; j < 16; j = j+1) begin
				A = i;
				B = j;
				#40
				start = 1;
				#100
				start = 0;
				#10
				while (!ready) #40;
				#50;
			end
		end

		$stop;
	end

	integer GoldenResult;
	always @(posedge ready) begin
		GoldenResult = A*B;
		if ((^A !== 1'bX) && (^B !== 1'bX)) begin
			if (GoldenResult == res)
				$display("A=%0d\tB=%0d\t-> res=%0d\t \tGoldenResult=%0d \t\t\tcorrect", A, B, res, GoldenResult);
			else
				$display("A=%0d\tB=%0d\t-> res=%0d\t \tGoldenResult=%0d \t\t\tWRONG_RESULT", A, B, res, GoldenResult);
		end
	end


endmodule
