module mux_32 (input [31:0] a, b, input decider, output [31:0] choosen);
	assign choosen = decider ? b : a;
endmodule