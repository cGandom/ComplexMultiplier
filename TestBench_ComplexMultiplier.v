`timescale 1ns/1ns

module TestBench_ComplexMultiplier();

	reg [3:0] Xreal, Ximag, Yreal, Yimag;
	reg start;
	wire ready;
	wire signed [7:0] resReal, resImag;

	reg rst = 0;
	reg clk = 1;
	always #37 clk = ~clk;

	ComplexMultiplier complexmult (
			.clk(clk), 
			.rst(rst), 
			.X({Xreal, Ximag}), 
			.Y({Yreal, Yimag}), 
			.start(start), 
			.res({resReal, resImag}), 
			.ready(ready)
			);

	integer i, j, m, n;
	initial begin
		rst = 0;
		start = 0;
		#20
		rst = 1;
		#50
		rst = 0;
		#50
		
		for (i = 0; i < 8; i= i+1) begin
			for (j = 0; j < 8; j = j+1) begin
				for (m = 0; m < 8; m = m+1) begin
					for (n = 0; n < 8; n = n+1) begin
						Xreal = i;
						Ximag = j;
						Yreal = m;
						Yimag = n;
						#40
						start = 1;
						#100
						start = 0;
						#10
						while (!ready) #100;
						#300;
					end
				end
			end
		end

		$stop;
	end
	
	integer GoldenResultReal, GoldenResultImag;
	always @(posedge ready) begin
		GoldenResultReal = Xreal*Yreal - Ximag*Yimag;
		GoldenResultImag = Xreal*Yimag + Ximag*Yreal;
		if ((^Xreal !== 1'bX) && (^Ximag !== 1'bX) && (^Yreal !== 1'bX) && (^Yimag !== 1'bX)) begin
			if ((GoldenResultReal == resReal) && (GoldenResultImag == resImag))
				$display("X=(%0d + %0di)\tY=(%0d + %0di)\t-> res=(%0d + %0di)\t \t\t\tGoldenResult=(%0d + %0di) \t\t\t\tcorrect",
					 Xreal, Ximag, Yreal, Yimag, resReal, resImag, GoldenResultReal, GoldenResultImag);
			else
				$display("X=(%0d + %0di)\tY=(%0d + %0di)\t-> res=(%0d + %0di)\t \t\t\tGoldenResult=(%0d + %0di) \t\t\t\tWRONG_RESULT", 
					Xreal, Ximag, Yreal, Yimag, resReal, resImag, GoldenResultReal, GoldenResultImag);
		end
	end


endmodule
