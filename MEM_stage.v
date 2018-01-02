module MEM_stage(
	input clk,
	input rst,
	//MEM_signals
	input MEM_R_EN_in,
	input MEM_W_EN_in,
	
	input [31:0]ALU_result_in,
	input [31:0]ST_val,
	
	//MEM_signals
	output [31:0]MEM_read_value,
	output ready,
	
	inout [15:0] o_mem_SRAM_DATA, 
	output [17:0] o_mem_SRAM_ADDRESS,
	output o_mem_SRAM_UB_N_O,
	output o_mem_SRAM_LB_N_O,
	output o_mem_SRAM_WE_N_O,
	output o_mem_SRAM_CE_N_O,
	output o_mem_SRAM_OE_N_O
);

//	reg [31:0]memory[0:63];
//	reg [31:0]MEM_read_value_reg;
	
//	always @(posedge clk)begin
//		if (MEM_W_EN_in)
//			memory[(ALU_result_in - 32'd1024) & ~(32'd3)] = ST_val;
//	end
	
	SRAM_Controller i_SRAM_controller(
		clk,
		rst,
		ALU_result_in[17:0], // address
		ST_val, // data
		MEM_R_EN_in,
		MEM_W_EN_in,
		MEM_read_value,
		ready,
		
		o_mem_SRAM_DATA, 
		o_mem_SRAM_ADDRESS,
		o_mem_SRAM_UB_N_O,
		o_mem_SRAM_LB_N_O,
		o_mem_SRAM_WE_N_O,
		o_mem_SRAM_CE_N_O,
		o_mem_SRAM_OE_N_O
	);

	
//	always @(negedge clk) begin
//			if (MEM_R_EN_in)
//				MEM_read_value_reg = memory[(ALU_result_in - 32'd1024) & ~(32'd3)];
//	end
	
//	assign MEM_read_value = MEM_R_EN_in ? memory[(ALU_result_in - 32'd1024) & ~(32'd3)] : 32'dx;
endmodule