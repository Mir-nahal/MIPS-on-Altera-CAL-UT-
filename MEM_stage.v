module MEM_stage(
	input clk,
	//MEM_signals
	input MEM_R_EN_in,
	input MEM_W_EN_in,
	
	input [31:0]ALU_result_in,
	input [31:0]ST_val,
	
	//MEM_signals
	output [31:0]MEM_read_value
);

	reg [31:0]memory[0:63];
//	reg [31:0]MEM_read_value_reg;
	
	always @(posedge clk)begin
		if (MEM_W_EN_in)
			memory[(ALU_result_in - 32'd1024) & ~(32'd3)] = ST_val;
	end
	
//	always @(negedge clk) begin
//			if (MEM_R_EN_in)
//				MEM_read_value_reg = memory[(ALU_result_in - 32'd1024) & ~(32'd3)];
//	end
	
	assign MEM_read_value = MEM_R_EN_in ? memory[(ALU_result_in - 32'd1024) & ~(32'd3)] : 32'dx;
endmodule