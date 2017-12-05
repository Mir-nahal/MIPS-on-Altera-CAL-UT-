module forwarding_Unit(
		input[4:0] src1,
		input[4:0] src2,
		input[4:0] ST_src,
		input EXE_MEM_W_EN,
		input MEM_MEM_WB_EN,
		input[4:0] MEM_Dest,
		input[4:0] WR_Dest,
		input WB_EN,
		
		output reg[1:0] src1_decider,
		output reg[1:0] src2_decider,
		output reg[1:0] ST_Val_decider);

always@(*) begin
	src1_decider = 2'd0;
	src2_decider = 2'd0;
	ST_Val_decider = 2'd0;
	
	if (MEM_MEM_WB_EN) begin
		if (src1 == MEM_Dest)
			src1_decider = 2'b01;
		if (src2 == MEM_Dest)
			src2_decider = 2'b01;
		if (ST_src == MEM_Dest)
			ST_Val_decider = 2'b01;
	end
	
	if (WB_EN) begin
		if (src1 == WR_Dest)
			src1_decider = 2'b10;
		if (src2 == WR_Dest)
			src2_decider = 2'b10;
		if (ST_src == WR_Dest)
			ST_Val_decider = 2'b10;
	end
	
end
		
endmodule