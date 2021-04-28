`timescale 1ns/1ns

module TestBench_Multiplier2x2 ();

	reg [1:0] a, b;
	wire [3:0] c;

	Multiplier2x2 mult (
			.a(a),
			.b(b),
			.c(c)
			);

	integer i, j;
	initial begin
		for (i = 0; i < 4; i= i+1) begin
			for (j = 0; j < 4; j = j+1) begin
				a = i;
				b = j;
				#5;
			end
		end		

		$stop;
	end

	integer GoldenResult;
	always @(c) begin
		GoldenResult = a*b;
		if (GoldenResult == c)
			$display("a=%0d\tb=%0d\t -> c=%0d\t \tGoldenResult=%0d \t\t\tcorrect", a, b, c, GoldenResult);
		else
			$display("a=%0d\tb=%0d\t -> c=%0d\t \tGoldenResult=%0d \t\t\tWRONG_RESULT", a, b, c, GoldenResult);
	end

endmodule
