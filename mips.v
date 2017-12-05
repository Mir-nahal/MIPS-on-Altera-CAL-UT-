module mips(
	input rst,
	input clk,
	output[31:0] d_fetch,
	output[31:0] d_decode,
	output[31:0] d_execute,
	output[31:0] d_memory,
	output[31:0] d_write_back);

	wire IF_flush;
	assign IF_flush = oIDReg_br_taken | oID_br_taken;

	wire oHD_detected;
	
	wire[1:0] oFW_src1_decider;
	wire[1:0] oFW_src2_decider;
	wire[1:0] oFW_ST_Val_decider;
	
	wire[31:0] oIF_pc;
	wire[31:0] oIF_instruction;
	IF_Stage i_fetch
	(
		clk,
		rst,
		oHD_detected,
		oIDReg_br_taken,
		oIDReg_val2,
		oIF_pc,
		oIF_instruction
	);

	wire[31:0] oIFReg_pc;
	wire[31:0] oIFReg_instruction;
	IF_Stage_reg i_fetch_reg
	(
		clk,
		rst,
		IF_flush,
		oHD_detected,
		oIF_pc,
		oIF_instruction,
		oIFReg_pc,
		oIFReg_instruction
	);

	wire[4:0] oID_dest;
	wire[31:0] oID_reg2;
	wire[31:0] oID_val1;
	wire[31:0] oID_val2;
	wire oID_br_taken;
	wire[3:0] oID_exe_cmd;
	wire oID_mem_r_en;
	wire oID_mem_w_en;
	wire oID_wb_en;
	wire[4:0] oID_src1;
	wire[4:0] oID_selected_src2;
	wire oID_is_immediate;
	wire[1:0] oID_br_type;
	wire[4:0] oID_fw_src2;
	ID_Stage i_decode
	(
		clk,
		rst,
		// From IF
		oIFReg_instruction,
		// From RegFile
		oRegFile_reg1,
		oRegFile_reg2,
		// To RegFile
		oID_src1,
		oID_selected_src2,
		// TO ID_Stage_reg
		oID_dest,
		oID_reg2,
		oID_val1,
		oID_val2,
		oID_br_taken,
		oID_exe_cmd,
		// MEM_Signals
		oID_mem_r_en,
		oID_mem_w_en,
		//
		oID_wb_en,
		oID_is_immediate,
		oID_br_type,
		// for forawrding
		oID_fw_src2
	);

	wire[4:0] oIDReg_dest;
	wire[31:0] oIDReg_reg2;
	wire[31:0] oIDReg_val2;
	wire[31:0] oIDReg_val1;
	wire[31:0] oIDReg_pc;
	wire oIDReg_br_taken;
	wire[3:0] oIDReg_exe_cmd;
	wire oIDReg_mem_r_en;
	wire oIDReg_mem_w_en;
	wire oIDReg_wb_en;
	wire[4:0] oIDReg_src1;
	wire[4:0] oIDReg_fw_src2;
	ID_Stage_reg i_decode_reg
	(
		clk,
		rst,
		oID_dest,
		oID_reg2,
		oID_val2,
		oID_val1,
		oIFReg_pc,
		oID_br_taken & ~oHD_detected,
		oID_exe_cmd,
		oID_mem_r_en,
		oID_mem_w_en & ~oHD_detected,
		oID_wb_en & ~oHD_detected,
		oID_src1,
		oID_fw_src2,
		oIDReg_dest,
		oIDReg_reg2,
		oIDReg_val2,
		oIDReg_val1,
		oIDReg_pc,
		oIDReg_br_taken,
		oIDReg_exe_cmd,
		oIDReg_mem_r_en,
		oIDReg_mem_w_en,
		oIDReg_wb_en,
		oIDReg_src1,
		oIDReg_fw_src2
	);

	wire[31:0] oEXE_alu_result;
	EXE_stage i_exe
	(
		clk,
		oIDReg_exe_cmd,
		oIDReg_val1,
		oIDReg_val2,
		
		oEXEReg_alu_result,
		oWB_Write_value,
		
		oFW_src1_decider,
		oFW_src2_decider,
		
		oEXE_alu_result
	);

	wire oEXEReg_wb_en;
	wire oEXEReg_mem_r_en;
	wire oEXEReg_mem_w_en;
	wire[31:0] oEXEReg_pc;
	wire[31:0] oEXEReg_alu_result;
	wire[31:0] oEXEReg_st_val;
	wire[31:0] oEXEReg_dest;
	EXE_stage_reg i_exe_reg
	(
		clk,
		rst,
		oIDReg_wb_en,
		oIDReg_mem_r_en,
		oIDReg_mem_w_en,
		oIDReg_pc,
		oEXE_alu_result,
		oIDReg_reg2,
		oIDReg_dest,
		
		oFW_ST_Val_decider,
		oEXEReg_alu_result,
		oWB_Write_value,
		
		oEXEReg_wb_en,
		oEXEReg_mem_r_en,
		oEXEReg_mem_w_en,
		oEXEReg_pc,
		oEXEReg_alu_result,
		oEXEReg_st_val,
		oEXEReg_dest
	);


	wire[31:0] oMEM_mem_read_value;
	MEM_stage i_mem
	(
		clk,
		//MEM_signals
		oEXEReg_mem_r_en,
		oEXEReg_mem_w_en,
		
		oEXEReg_alu_result,
		oEXEReg_st_val,
		
		//MEM_signals
		oMEM_mem_read_value
	);

	wire oMEMReg_WB_en;
	wire oMEMReg_MEM_R_EN;
	wire[31:0] oMEMReg_ALU_result;
	wire[31:0] oMEMReg_Mem_read_value;
	wire[31:0] oMEMReg_Dest;
	MEM_stage_reg i_mem_reg
	(
		clk,
		rst,
		oEXEReg_wb_en,
		//MEM_signals
		oEXEReg_mem_r_en,
		//memory address
		oEXEReg_alu_result,
		oMEM_mem_read_value,
		oEXEReg_dest,
		
		oMEMReg_WB_en,
		//MEM_signals
		oMEMReg_MEM_R_EN,
		oMEMReg_ALU_result,
		oMEMReg_Mem_read_value,
		oMEMReg_Dest
	);

	wire oWB_WB_en;
	wire[31:0] oWB_Write_value;
	wire[31:0] oWB_Dest;
	WB_stage i_wb
	(
		clk,
		oMEMReg_WB_en,
		oMEMReg_MEM_R_EN,
		
		oMEMReg_ALU_result,
		oMEMReg_Mem_read_value,
		oMEMReg_Dest,
		
		oWB_WB_en,
		oWB_Write_value,
		oWB_Dest
	);
	
	wire[31:0] oRegFile_reg1;
	wire[31:0] oRegFile_reg2;
	Registers_file i_register_file
	(
		clk,
		rst,
		oID_src1,
		oID_selected_src2,
		oWB_Dest,
		oWB_Write_value,
		oWB_WB_en,
		
		oRegFile_reg1,
		oRegFile_reg2
	);
	
	hazard_Detection_Unit i_HD(
		oID_src1,
		oID_selected_src2,
		oIDReg_dest,
		oIDReg_mem_r_en,
		oEXEReg_dest,
		oEXEReg_mem_r_en,
		
		oID_is_immediate,
		oID_br_type,
		
		oHD_detected
	);
	
	forwarding_Unit i_FW(
		oIDReg_src1,
		oIDReg_fw_src2,
		oIDReg_dest,
		oIDReg_mem_w_en,
		oEXEReg_wb_en,
		oEXEReg_dest,
		oWB_Dest,
		oWB_WB_en,
		
		oFW_src1_decider,
		oFW_src2_decider,
		oFW_ST_Val_decider
	);
	
	assign d_fetch = oIFReg_pc;
	assign d_decode = oIDReg_pc;
	assign d_execute = oEXEReg_pc;
	
	assign d_memory = oIF_pc;
endmodule