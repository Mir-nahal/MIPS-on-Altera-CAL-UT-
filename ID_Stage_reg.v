module ID_Stage_reg
	(
		input clk,
		input rst,
		input[4:0] dest_in,
		input[31:0] reg2_in,
		input[31:0] val2_in,
		input[31:0] val1_in,
		input[31:0] pc_in,
		input br_taken_in,
		input[3:0] exe_cmd_in,
		input mem_r_en_in,
		input mem_w_en_in,
		input wb_en_in,
		output reg[4:0] dest,
		output reg[31:0] reg2,
		output reg[31:0] val2,
		output reg[31:0] val1,
		output reg[31:0] pc,
		output reg br_taken,
		output reg[3:0] exe_cmd,
		output reg mem_r_en,
		output reg mem_w_en,
		output reg wb_en
	);

	always @(posedge clk) begin
		if (rst) begin
			dest <= 5'b0;
			reg2 <= 32'b0;
			val2 <= 32'b0;
			val1 <= 32'b0;
			pc <= 32'b0;
			br_taken <= 1'b0;
			exe_cmd <= 4'b0;
			mem_r_en <= 1'b0;
			mem_w_en <= 1'b0;
			wb_en <= 1'b0;
		end
		else begin
			dest <= dest_in;
			reg2 <= reg2_in;
			val2 <= val2_in;
			val1 <= val1_in;
			pc <= pc_in;
			br_taken <= br_taken_in;
			exe_cmd <= exe_cmd_in;
			mem_r_en <= mem_r_en_in;
			mem_w_en <= mem_w_en_in;
			wb_en <= wb_en_in;
		end
	end
	
endmodule