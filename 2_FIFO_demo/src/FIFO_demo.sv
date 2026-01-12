module FIFO_demo(
	input logic CLOCK0_50,
	input logic [1:0] KEY, // the keys' are active low
	input logic [3:0] SWITCH,
	output logic [2:0] LED_2_0,
	output logic LED_7,
	output logic LED_5
);

/* 
	clk - 5MHz
	rst - SWITCH[0]
	wr_en - KEY[0]
	rd_en - KEY[1]
	data_in - SWITCH[3:1]
	data_out - LED[2:0]
	full - LED[5]
	empty - LED[7]
	
	the buttons are passed through debounce modules
	
 */
	
	logic clk;
	logic [4:0] leds;
	logic [1:0] keys_out;

	
	iopll u_pll(
		.refclk(CLOCK0_50),
		.rst(SWITCH[0]), // the reset is active high
		.outclk_0(clk)
	);
	
	debounce#(.COUNTER_BITS(18)) db_key_0(
		.clk(clk),
		.rst(SWITCH[0]),
		.btn(~KEY[0]),
		.db_tick(keys_out[0])
	);
	
	debounce#(.COUNTER_BITS(18)) db_key_1(
		.clk(clk),
		.rst(SWITCH[0]),
		.btn(~KEY[1]),
		.db_tick(keys_out[1])
	);
	


	
	
	

	fifo_sync2#(
		.DATA_BITS(3),
		.ADDR_BITS(4)) u_fifo(.clk(clk),
											 .rst(SWITCH[0]),
											 .data_in(SWITCH[3:1]), // SWITCH[3:1]
											 .data_out(leds[2:0]), // LED_2_0
											 .wr_en(keys_out[0]),
											 .rd_en(keys_out[1]),
											 .empty(leds[4]), // LED_7
											 .full(leds[3]) // LED_5
											 );
											 
	assign LED_2_0 = ~leds[2:0];
	assign LED_7 = ~leds[4];
	assign LED_5 = ~leds[3];

endmodule