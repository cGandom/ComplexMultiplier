`timescale 1ns/1ns

module TestBench_MAC ();
	reg [3:0] X0real, X0imag, Y0real, Y0imag;
	reg [3:0] X1real, X1imag, Y1real, Y1imag;
	reg [3:0] X2real, X2imag, Y2real, Y2imag;
	reg [3:0] X3real, X3imag, Y3real, Y3imag;
	reg start;
	wire ready;
	wire signed [9:0] resReal, resImag;

	reg rst = 0;
	reg clk = 1;
	always #37 clk = ~clk;

	MAC 	mac(
			.clk(clk), 
			.rst(rst), 
			.X0({X0real, X0imag}),
			.X1({X1real, X1imag}),
			.X2({X2real, X2imag}),
			.X3({X3real, X3imag}),
			.Y0({Y0real, Y0imag}),
			.Y1({Y1real, Y1imag}),
			.Y2({Y2real, Y2imag}),
			.Y3({Y3real, Y3imag}),
			.start(start), 
			.res({resReal, resImag}), 
			.ready(ready)
			);

	integer i;
	initial begin
		rst = 0;
		start = 0;
		#20
		rst = 1;
		#50
		rst = 0;
		#50

		for (i = 0; i < 128; i= i+1) begin
			X0real = $unsigned($random)%8; X0imag = $unsigned($random)%8;
			X1real = $unsigned($random)%8; X1imag = $unsigned($random)%8;
			X2real = $unsigned($random)%8; X2imag = $unsigned($random)%8;
			X3real = $unsigned($random)%8; X3imag = $unsigned($random)%8;
			Y0real = $unsigned($random)%8; Y0imag = $unsigned($random)%8;
			Y1real = $unsigned($random)%8; Y1imag = $unsigned($random)%8;
			Y2real = $unsigned($random)%8; Y2imag = $unsigned($random)%8;
			Y3real = $unsigned($random)%8; Y3imag = $unsigned($random)%8;
			#40
			start = 1;
			#100
			start = 0;
			#10
			while (!ready) #100;
			#300;

		end
		
		$stop;
	end

	
	integer GoldenCalc0Real, GoldenCalc0Imag;
	integer GoldenCalc1Real, GoldenCalc1Imag;
	integer GoldenCalc2Real, GoldenCalc2Imag;
	integer GoldenCalc3Real, GoldenCalc3Imag;
	integer GoldenResultReal, GoldenResultImag;
	always @(posedge ready) begin
		GoldenCalc0Real = X0real*Y0real - X0imag*Y0imag; GoldenCalc0Imag = X0real*Y0imag + X0imag*Y0real;
		GoldenCalc1Real = X1real*Y1real - X1imag*Y1imag; GoldenCalc1Imag = X1real*Y1imag + X1imag*Y1real;
		GoldenCalc2Real = X2real*Y2real - X2imag*Y2imag; GoldenCalc2Imag = X2real*Y2imag + X2imag*Y2real;
		GoldenCalc3Real = X3real*Y3real - X3imag*Y3imag; GoldenCalc3Imag = X3real*Y3imag + X3imag*Y3real;
		
		GoldenResultReal = GoldenCalc0Real + GoldenCalc1Real + GoldenCalc2Real + GoldenCalc3Real;
		GoldenResultImag = GoldenCalc0Imag + GoldenCalc1Imag + GoldenCalc2Imag + GoldenCalc3Imag; 

		if (^X2real !== 1'bX) begin
			$display("X0=(%0d + %0di)\tX1=(%0d + %0di)\tX2=(%0d + %0di)\tX3=(%0d + %0di)",
					 X0real, X0imag, X1real, X1imag, X2real, X2imag, X3real, X3imag);
			$display("Y0=(%0d + %0di)\tY1=(%0d + %0di)\tY2=(%0d + %0di)\tY3=(%0d + %0di)",
					 Y0real, Y0imag, Y1real, Y1imag, Y2real, Y2imag, Y3real, Y3imag);

			if ((GoldenResultReal == resReal) && (GoldenResultImag == resImag))
				$display("res=(%0d + %0di)\t \tGoldenResult=(%0d + %0di) \t\t\t\t\tcorrect",
					 resReal, resImag, GoldenResultReal, GoldenResultImag);
			else
				$display("res=(%0d + %0di)\t \tGoldenResult=(%0d + %0di) \t\t\t\t\tWRONG_RESULT",
					 resReal, resImag, GoldenResultReal, GoldenResultImag);
			$display("==============================================================");
		end
	end



endmodule
