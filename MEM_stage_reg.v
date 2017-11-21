module MEM_stage_reg(
	input clk,
	input rst,
	
	input WB_en_in,
	//MEM_signals
	input MEM_R_EN_in,
	//memory address
	input [31:0]ALU_result_in,
	input [31:0]Mem_read_value_in,
	input [31:0]Dest_in,
	
	output reg WB_en,
	//MEM_signals
	output reg MEM_R_EN,
	output reg [31:0]ALU_result,
	output reg [31:0]Mem_read_value,
	output reg [31:0]Dest
);
	always @(posedge clk)begin
		if (rst) begin
			WB_en = 1'b0;
			MEM_R_EN = 1'b0;
			ALU_result = 32'b0;
			Mem_read_value = 32'b0;
			Dest = 32'b0;
		end
		else begin
			WB_en = WB_en_in;
			MEM_R_EN = MEM_R_EN_in;
			ALU_result = ALU_result_in;
			Mem_read_value = Mem_read_value_in;
			Dest = Dest_in;
		end
	end

endmodule