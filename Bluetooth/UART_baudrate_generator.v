module UART_baudrate_generator (Clk,Rst_n,Tick,Baudrate);

input Clk;
input Rst_n;
input [15:0] Baudrate;

output Tick;
reg [15:0] baudRateReg;

always @ (posedge Clk or negedge Rst_n)
	if (!Rst_n)	baudRateReg <= 16'b1;
	else if (Tick)	baudRateReg <= 16'b1;
	else baudRateReg <= baudRateReg + 1'b1;
assign Tick = (baudRateReg == Baudrate);

endmodule
