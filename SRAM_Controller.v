module SRAM_Controller(
	input clk,
	input rst,
	// TO THE MEMORY STAGE UNIT
	input [17:0] SRAM_address,
	input [31:0] SRAM_write_data,
	input SRAM_re_en,
	input SRAM_we_en,
	output [31:0] SRAM_read_data, // DONE
	output reg ready,
	// TO THE SRAM PINS
	inout reg [15:0] SRAM_DATA, // DONE
	output reg [17:0] SRAM_ADDRESS, // DONE
	output reg SRAM_UB_N_O, //GND
	output reg SRAM_LB_N_O, //GND
	output reg SRAM_WE_N_O, // DONE
	output reg SRAM_CE_N_O, //GND
	output reg SRAM_OE_N_O //GND
);

	reg[1:0] counter = 2'b0;
	reg[15:0] first_part;
	reg[15:0] second_part;
	
	always @(posedge clk) begin
		if (SRAM_re_en || SRAM_we_en) begin
			counter = counter + 2'b01;
		end
		else begin
			counter = 2'b0;
		end
	end
	
	assign SRAM_WE_N_O = (SRAM_we_en && (counter == 2'b0 || counter == 2'b01));
	
	assign SRAM_ADDRESS = SRAM_address;
	
	assign SRAM_DATA = (SRAM_we_en && counter == 2'b0) ? SRAM_write_data[15:0] :
				(SRAM_we_en && counter == 2'b01) ? SRAM_write_data[31:16]:
				32'bZ;

	assign first_part = (SRAM_re_en && counter == 2'b0) ? SRAM_DATA : first_part;
	assign second_part = (SRAM_re_en && counter == 2'b01) ? SRAM_DATA : second_part;

	assign SRAM_read_data = {second_part, first_part};

	assign ready = (SRAM_we_en || SRAM_re_en) && counter != 2'b11 ? 0 : 1;

	assign SRAM_UB_N_O = 0;
	assign SRAM_LB_N_O = 0;
	assign SRAM_CE_N_O = 0;
	assign SRAM_OE_N_O = 0;
endmodule