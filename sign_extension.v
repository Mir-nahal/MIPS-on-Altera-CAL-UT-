module sign_extension(input signed [15:0] in, output signed [31:0] out);
	//assign out = {in[15] ? 16'b1 : 16'b0, in};
	//assign out = 32'(signed'(in));
	assign out = in;
endmodule