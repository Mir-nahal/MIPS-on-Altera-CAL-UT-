module EXE_stage
	(
		input clk,
		input[3:0] exe_cmd,
		input[31:0] val1,
		input[31:0] val2,
		
		input[31:0] mem_alu_result,
		input[31:0] wb_result_wb,
		
		input[1:0] src1_decider,
		input[1:0] src2_decider,
		
		output[31:0] alu_result
	);
	
	wire[31:0] decided_src1;
	wire[31:0] decided_src2;
	wire[31:0] air;
	
	mux_32bit_4to1 src1_decider_mux(
		val1, mem_alu_result, wb_result_wb, air, 
		src1_decider, 
		decided_src1);
		
	mux_32bit_4to1 src2_decider_mux(
		val2, mem_alu_result, wb_result_wb, air, 
		src2_decider, 
		decided_src2);
	
	alu i_alu(
		decided_src1,
		decided_src2,
		exe_cmd,
		alu_result
	);

endmodule