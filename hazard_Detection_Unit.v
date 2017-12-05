module hazard_Detection_Unit(
	input[4:0] src1,
	input[4:0] src2,
	input[4:0] Exe_Dest,
	input Exe_WB,
	input[4:0] Mem_Dest,
	input Mem_WB,
	
	input is_immediate,
	input[1:0] br_type,
	
	output hazard_Detected
);

reg hazard_reg = 0;

always@(*) begin
	hazard_reg = 0;
	
	if (is_immediate == 0) begin
		if (Exe_WB) begin
			if (src1 == Exe_Dest || src2 == Exe_Dest)
				hazard_reg = 1;
		end
//		if (Mem_WB) begin
//			if (src1 == Mem_Dest || src2 == Mem_Dest)
//				hazard_reg = 1;
//		end
	end
	
	if (is_immediate == 1) begin
		if (Exe_WB) begin
			if (src1 == Exe_Dest)
				hazard_reg = 1;
			
			if (br_type == 2'b01) begin // if branch not equal
				if (src2 == Exe_Dest)
					hazard_reg = 1;
			end
		end
		
		if (Mem_WB) begin
//			if (src1 == Mem_Dest)
//				hazard_reg = 1;
			
			if (br_type == 2'b00 || br_type == 2'b01) begin // if branch not equal or branch zero
				if (src2 == Mem_Dest)
					hazard_reg = 1;
			end
		end
		
	end
end

assign hazard_Detected = hazard_reg;

endmodule