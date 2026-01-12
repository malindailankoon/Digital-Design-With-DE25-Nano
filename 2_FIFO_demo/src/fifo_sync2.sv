module fifo_sync2#(
	parameter DATA_BITS = 8,
	parameter ADDR_BITS = 4
)(
	input logic [DATA_BITS-1:0] data_in,
	input logic rst, clk, wr_en, rd_en,
	output logic [DATA_BITS-1:0] data_out,
	output logic full, empty
);

	localparam FIFO_DEPTH = (1<<ADDR_BITS);
	logic [DATA_BITS-1:0] memory [0:FIFO_DEPTH-1];
	logic [ADDR_BITS-1:0] wr_ptr, rd_ptr;
	logic [ADDR_BITS:0] counter;
	logic valid_write, valid_read;
	
	assign empty = ~|counter; // the reduction NOR operator returns 1 if 
									  // any of counter's bits are 1
	assign full = counter[ADDR_BITS]; // the moment the buffer becomes full, 
												 // the msb of counter becomes 1
	
	assign valid_write = wr_en && !full;
	assign valid_read = rd_en && !empty;
	
	always_ff @(posedge clk, posedge rst) begin
		if (rst) begin
			counter <= '0;
			rd_ptr <= '0;
			wr_ptr <= '0;
		end
		else begin
			case ({valid_write , valid_read})
				2'b01: counter <= counter - 1;
				2'b10: counter <= counter + 1;
				default: counter <= counter; 
			endcase
			
			if (valid_write) begin
				memory[wr_ptr] <= data_in;
				wr_ptr <= wr_ptr + 1'b1;
			end
			
			if (valid_read) begin
				data_out <= memory[rd_ptr];
				rd_ptr <= rd_ptr + 1'b1;
			end
		end
	end

endmodule


