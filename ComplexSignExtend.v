module ComplexSignExtend (inp, out);
input [15:0] inp;
output [19:0] out;

	assign out[19:10] = {inp[15], inp[15], inp[15:8]};
	assign out[9:0] = {inp[7], inp[7], inp[7:0]};

endmodule
