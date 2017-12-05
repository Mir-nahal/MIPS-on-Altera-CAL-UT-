module hazard_Detection_Unit(
	input[4:0] src1,
	input[4:0] src2,
	input[4:0] Exe_Dest,
	input Exe_MEM_R,
	input[4:0] Mem_Dest,
	input Mem_MEM_R,
	
	input is_immediate,
	input st_or_bne,
	
	output hazard_Detected
);

reg hazard_reg = 0;

always@(*) begin
	hazard_reg = 0;
	
	if (is_immediate == 0) begin
		if (Exe_MEM_R) begin
			if (src1 == Exe_Dest || src2 == Exe_Dest)
				hazard_reg = 1;
		end
//		if (Mem_MEM_R) begin
//			if (src1 == Mem_Dest || src2 == Mem_Dest)
//				hazard_reg = 1;
//		end
	end
	
	if (is_immediate == 1) begin
		if (Exe_MEM_R) begin
			if (src1 == Exe_Dest)
				hazard_reg = 1;
			
			if (st_or_bne) begin
				if (src2 == Exe_Dest)
					hazard_reg = 1;
			end
		end
		
		if (Mem_MEM_R) begin
//			if (src1 == Mem_Dest)
//				hazard_reg = 1;
			
			if (st_or_bne) begin
				if (src2 == Mem_Dest)
					hazard_reg = 1;
			end
		end
		
	end
end

assign hazard_Detected = hazard_reg;

endmodule