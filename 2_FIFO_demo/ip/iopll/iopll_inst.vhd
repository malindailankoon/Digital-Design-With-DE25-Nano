	component iopll is
		port (
			refclk   : in  std_logic := 'X'; -- clk
			rst      : in  std_logic := 'X'; -- reset
			outclk_0 : out std_logic         -- clk
		);
	end component iopll;

	u0 : component iopll
		port map (
			refclk   => CONNECTED_TO_refclk,   --  refclk.clk
			rst      => CONNECTED_TO_rst,      --   reset.reset
			outclk_0 => CONNECTED_TO_outclk_0  -- outclk0.clk
		);

