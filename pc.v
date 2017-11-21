module pc(input rst, we, input [31:0] in , output [31:0] out);
	reg[31:0] data;
	always @(posedge we) begin
		if (rst)
			data <= 32'b0;
		else	
			data <= in;
	end
	assign out = data;
endmodule