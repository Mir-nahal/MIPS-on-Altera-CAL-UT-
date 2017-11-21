module pc_adder(input [31:0] a, b, output [31:0] out);
	reg [31:0] temp;
	always @(*) begin
		temp = a + b;
	end
	assign out =  temp;
endmodule