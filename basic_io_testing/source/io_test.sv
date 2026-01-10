module io_test(
	input logic [1:0] KEY, // the keys are active low (press for logic 0)
	input logic [3:0] SWITCH,
	output logic [5:0] LED // the led pins are active low as well (logic 0 to turn on)
);

	assign LED = {KEY[1], KEY[0], ~SWITCH};

endmodule