module IF_Stage_reg
	(
		input clk,
		input rst,
		input flush,
		input freez,
		input [31:0] pc_in,
		input [31:0] instruction_in,
		output reg [31:0] pc,
		output reg [31:0] instruction
	);

	 always @(posedge clk) begin
		if (rst || flush) begin
			pc <= 32'b0;
			instruction <= 32'b0;
		end
		else if (freez == 0) begin
			instruction <= instruction_in;
			pc <= pc_in;
		end
	end
endmodule