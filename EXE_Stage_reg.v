module EXE_stage_reg
	(
		input clk,
		input rst,
		input freez,
		input wb_en_in,
		input mem_r_en_in,
		input mem_w_en_in,
		input[31:0] pc_in,
		input[31:0] alu_result_in,
		input[31:0] st_val_in,
		input[31:0] dest_in,
		
		input[1:0] st_val_decider,
		input[31:0] mem_alu_result,
		input[31:0] wb_result_wb,
		
		output reg wb_en,
		output reg mem_r_en,
		output reg mem_w_en,
		output reg[31:0] pc,
		output reg[31:0] alu_result,
		output reg[31:0] st_val,
		output reg[31:0] dest
	);
	
	wire[31:0] air;
	wire[31:0] choosen_st_val;
	
	mux_32bit_4to1 st_val_mux
		(st_val_in, mem_alu_result, wb_result_wb, air,
		st_val_decider, choosen_st_val);

	always @(posedge clk) begin
		if (rst) begin
			wb_en <= 1'b0;
			mem_r_en <= 1'b0;
			mem_w_en <= 1'b0;
			pc <= 32'b0;
			alu_result <= 32'b0;
			st_val <= 32'b0;
			dest <= 32'b0;
		end
		else if (freez == 0)begin
			wb_en <= wb_en_in;
			mem_r_en <= mem_r_en_in;
			mem_w_en <= mem_w_en_in;
			pc <= pc_in;
			alu_result <= alu_result_in;
			st_val <= choosen_st_val;
			dest <= dest_in;
		end
	end
	
endmodule