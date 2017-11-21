module condition_check(input [31:0] reg1, reg2, input[1:0] raw_condition, output refined_condition);
	reg refined_condition_reg = 0;
	always @(raw_condition)begin
		if (raw_condition == 2'b00)begin
			if (reg1 == 32'd0)
				refined_condition_reg = 1;
			else
				refined_condition_reg = 0;
		end
		
		if (raw_condition == 2'b01)begin
			if (reg1 == reg2)
				refined_condition_reg = 0;
			else
				refined_condition_reg = 1;
		end
		
		if (raw_condition == 2'b10)begin
			refined_condition_reg = 1;
		end
	end
	
	assign refined_condition = refined_condition_reg;
	
endmodule