module control_unit(input[5:0] opcode,
	output[3:0] execute_cmnd,
	output [1:0] branch_type,
	output is_branch, is_immediate,
	output ST_or_BNE,
	output mem_read, mem_write,
	output wb_en);

	reg[3:0] alu_cmd_reg = 4'd0;
	reg[1:0] branch_type_reg = 2'bx;
	reg is_branch_reg = 0,
		 is_immediate_reg = 0,
		 ST_or_BNE_reg = 0,
		 mem_read_reg = 0, mem_write_reg = 0,
		 wb_en_reg = 1;
//	reg [1:0]condition_reg = 2'b0;

	always @(*) begin
		case (opcode)
			6'd0 : alu_cmd_reg = 4'bx;
			6'd1 : alu_cmd_reg = 4'd0;
			6'd3 : alu_cmd_reg = 4'b0010;
			6'd5 : alu_cmd_reg = 4'b0100;
			6'd6 : alu_cmd_reg = 4'b0101;
			6'd7 : alu_cmd_reg = 4'b0110;
			6'd8 : alu_cmd_reg = 4'b0111;
			6'd9 : alu_cmd_reg = 4'b1000;
 			6'd10 : alu_cmd_reg = 4'b1000;
			6'd11 : alu_cmd_reg = 4'b1001;
			6'd12 : alu_cmd_reg = 4'b1010;
			6'd32 : alu_cmd_reg = 4'b0000;
			6'd33 : alu_cmd_reg = 4'b0010;
			6'd36 : alu_cmd_reg = 4'b0000;
			6'd37 : alu_cmd_reg = 4'b0000;
			6'd40 : alu_cmd_reg = 4'bx;
			6'd41 : alu_cmd_reg = 4'bx;
			6'd42 : alu_cmd_reg = 4'bx;
		endcase

		if (opcode == 6'b101000 || opcode == 6'b101001 || opcode == 6'b101010)begin
			is_branch_reg = 1;
			branch_type_reg = opcode[1:0];		
		end
		else begin
			is_branch_reg = 0;
			branch_type_reg = 2'dx;
		end

		if(opcode == 6'b100000 ||
			opcode == 6'b100001 ||
			opcode == 6'b100100 ||
			opcode == 6'b100101 ||
			opcode == 6'b101000 ||
			opcode == 6'b101001 ||
			opcode == 6'b101010)
			is_immediate_reg = 1;
		else 
			is_immediate_reg = 0;
			
		if (opcode == 6'b100101 || opcode == 6'b101001)
			ST_or_BNE_reg = 1;
		else
			ST_or_BNE_reg = 0;
		
		if (opcode == 6'b100101)
			mem_write_reg = 1;
		else
			mem_write_reg = 0;
			
		if (opcode == 6'b100100)
			mem_read_reg = 1;
		else
			mem_read_reg = 0;
			
		if (
			opcode == 6'b000000 || 
			opcode == 6'b100101 || 
			opcode == 6'b101000 || 
			opcode == 6'b101001 || 
			opcode == 6'b101010)
			wb_en_reg = 0;
		else
			wb_en_reg = 1;
			
//		if (opcode == 6'b101000)
//			condition_reg[0] = 1;
//		else 
//			condition_reg[0] = 0;
//		
//		if (opcode == 6'b101001)
//			condition_reg[1] = 1;
//		else 
//			condition_reg[1] = 0;
			
	end

	assign execute_cmnd = alu_cmd_reg;
	
	assign is_branch = is_branch_reg ;
	assign branch_type = branch_type_reg;
	
	assign is_immediate = is_immediate_reg;
	
	assign ST_or_BNE = ST_or_BNE_reg;
	
	assign mem_write = mem_write_reg;
	assign mem_read = mem_read_reg;
	
	assign wb_en = wb_en_reg;
	
//	assign condition = condition_reg;
endmodule
