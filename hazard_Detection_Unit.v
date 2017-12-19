module hazard_Detection_Unit(
	input[4:0] src1,
	input[4:0] src2,
	input[4:0] Exe_Dest,
	input Exe_WB,
	input Exe_Mem_Read_En,
	input[4:0] Mem_Dest,
	input Mem_WB,
	
	input is_immediate,
	input is_branch,
	input[1:0] br_type,
	
	output hazard_Detected
);

reg hazard_reg = 0;

always@(*) begin
	hazard_reg = 0;
	
	if (is_immediate == 0) begin
		if (Exe_Mem_Read_En) begin
			if (src1 == Exe_Dest || src2 == Exe_Dest)
				hazard_reg = 1;
		end
	end
	
	if (is_immediate == 1) begin
		if (Exe_Mem_Read_En) begin
			if (src1 == Exe_Dest)
				hazard_reg = 1;
		end		
	end
	
	if (is_branch == 1) begin // currenct instr is BEZ or BNE
		if (Exe_WB && (src1 == Exe_Dest || src2 == Exe_Dest)) begin
			hazard_reg = 1;
		end
		if (Mem_WB && (src1 == Mem_Dest || src2 == Mem_Dest)) begin
			hazard_reg = 1;
		end
	end
end

assign hazard_Detected = hazard_reg;

endmodule