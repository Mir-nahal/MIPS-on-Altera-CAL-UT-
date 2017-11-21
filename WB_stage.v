module WB_stage(
	input clk,
	input WB_en_in,
	input MEM_R_EN,
	
	input [31:0]ALU_result,
	input [31:0]Mem_read_value,
	input [31:0]Dest_in,
	
	output WB_en,
	output [31:0]Write_value,
	output [31:0]Dest
);
	mux_32 i_mux_32 (ALU_result, Mem_read_value, MEM_R_EN, Write_value);
	assign Dest = Dest_in;
	assign WB_en = WB_en_in;

endmodule