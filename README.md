# Digital-Design-With-DE25-Nano
A collection of digital design projects implemented on the Terasic DE25-Nano. Each directory contains a standalone Quartus project, including all necessary source and config files.


## 1) basic_io_testing
just checks how the switches and the LEDs of the board works. The 4 switches and 2 keys are connected to 6 LEDs. note that the keys are acive low, meaning when pressed the logic will be 1. also the LEDs are active low as well, ie. when the corresponding pin is 0 the led will light up.

## 2) FIFO_demo
A simple demonstration of a synchronous FIFO buffer. This demo uses switches to set input data and two buttons to control reading from and writing to the buffer. Note that the keys should pass through a debounce module to work properly. Without debouncing, the FIFO buffer may appear to fill up instantly after the first write (in reality, the bouncing effect causes the write enable signal to trigger rapidly).
