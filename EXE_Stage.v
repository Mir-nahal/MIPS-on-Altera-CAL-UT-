module EXE_stage
	(
		input clk,
		input[3:0] exe_cmd,
		input[31:0] val1,
		input[31:0] val2,
		
		output[31:0] alu_result
	);
	
	alu i_alu(
		val1,
		val2,
		exe_cmd,
		alu_result
	);

endmodule