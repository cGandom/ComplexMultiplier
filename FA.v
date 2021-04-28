module FA (a, b, ci, s, co);
input a;
input b;
input ci;
output s;
output co;
	
	wire abxor;
	xor xorab (abxor, a, b);

	xor xors (s, abxor, ci);
	
	wire i0, i1;
	and andi0 (i0, ci, abxor);
	and andi1 (i1, a, b);
	or orco (co, i0, i1);

endmodule 