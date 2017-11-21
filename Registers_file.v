module Registers_file(
	input clk,
	input rst,
	input [4:0]src1,
	input [4:0]src2,
	input [4:0]dest,
	input [31:0]Write_val,
	input Write_EN,
	
	output [31:0]reg1,
	output [31:0]reg2
);

	reg[31:0] register[31:0];
	reg[31:0] n;
	reg[31:0] reg1_reg, reg2_reg;
	
	initial begin
		register[0] = 32'b0;
	end
	
	always @(negedge clk) begin
		if (rst) begin
			for (n=0; n<32; n=n+1) register[n] = n;
		end
		
		if (Write_EN)
			if (dest != 5'b0)
				register[dest] = Write_val;
	end

	always @(src1) begin
		reg1_reg <= register[src1];
	end

	always @(src2) begin
		reg2_reg <= register[src2];
	end
	
	assign reg1 = reg1_reg;
	assign reg2 = reg2_reg;
	
endmodule