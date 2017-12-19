module IF_Stage
	(
		input clk,
		input rst,
		input freez,
		input br_taken,
		input [31:0] br_offset,
		output [31:0] pc,
		output [31:0] instruction
	);
	wire [31:0] adder_to_pc;
	wire [31:0] instr_out;
	
	pc_adder i_pc_adder(freez ? 32'd0 : (br_taken == 0 ? 32'd4 : ((br_offset  << 2)- 32'd4)), pc, adder_to_pc);
	pc i_pc(rst, clk, adder_to_pc, pc);
	instruction_memory i_instruction_memory(pc, instruction);	
endmodule