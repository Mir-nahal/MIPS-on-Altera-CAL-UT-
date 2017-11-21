module alu(
	input[31:0] inA,
	input[31:0] inB,
	input[3:0] aluOp,
	output reg[31:0] outY);

	localparam[3:0] addOp=4'b0000, subOp=4'b0010;
	localparam[3:0] andOp=4'b0100, orOp=4'b0101, norOp=4'b0110, xorOp=4'b0111;
	localparam[3:0] shlOp=4'b1000, shrOp=4'b1010, shrAOp=4'b1001;
	always @(inA or inB or aluOp) begin
		case (aluOp) 
			addOp:begin
				outY = inA + inB;
			end 
			subOp: begin
				outY = inA - inB;
			end
			andOp: begin
				outY = inA & inB;
			end
			orOp:  begin
				outY = inA | inB;
			end
			norOp: begin
				outY = ~(inA | inB);
			end
			xorOp:  begin
				outY = inA ^ inB;
			end
			shlOp: begin
				outY = inA << inB;
			end
			shrOp: begin
				outY = inA >> inB;
			end
			shrAOp: begin
				outY = inA >>> inB;
			end
		endcase
	end

endmodule