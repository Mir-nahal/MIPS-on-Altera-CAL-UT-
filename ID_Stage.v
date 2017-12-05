module ID_Stage
	(
		input clk,
		input rst,
		// From IF
		input[31:0] instruction,
		// From RegFile
		input[31:0] reg1val,
		input[31:0] reg2val,
		// To RegFile
		output[4:0] src1,
		output[4:0] selected_src2,
		// TO ID_Stage_reg
		output[4:0] dest,
		output[31:0] reg2,
		output[31:0] val1,
		output[31:0] val2,
		output br_taken,
		output[3:0] exe_cmd,
		// MEM_Signals
		output mem_r_en,
		output mem_w_en,
		//
		output wb_en,
		output is_immediate,
		output[1:0] br_type,
		// for forwarding
		output[4:0] fw_src2
	);
	
//	wire[1:0] br_type;
	wire is_branch;
//	wire is_immediate;
	wire st_or_bne;
	control_unit i_control_unit(
		instruction[31:26],
		exe_cmd,
		br_type,
		is_branch,
		is_immediate,
		st_or_bne,
		mem_r_en,
		mem_w_en,
		wb_en
	);
	
	wire o_condition_check;
	condition_check i_condition_check(
		reg1val,
		reg2val,
		br_type,
		o_condition_check
	);

	wire[31:0] extended_immediate;
	sign_extension i_sign_extension(
		instruction[15:0],
		extended_immediate
	);

	mux_32 i_mux_32(
		reg2val,
		extended_immediate,
		is_immediate,
		val2
	);

	mux_5 i_mux_5(
		instruction[15:11],
		instruction[25:21],
		st_or_bne,
		selected_src2
	);

	assign br_taken = is_branch & o_condition_check;
	
	assign src1 = instruction[20:16];
	assign dest = instruction[25:21];
	assign reg2 = reg2val;
	assign val1 = reg1val;
	
	assign fw_src2 = is_immediate ? instruction[15:11] : 5'd0;
endmodule