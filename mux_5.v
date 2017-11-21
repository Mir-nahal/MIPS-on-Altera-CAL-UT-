module mux_5 (input [4:0] a, b, input decider, output [4:0] choosen);
	assign choosen = decider ? b : a;
endmodule