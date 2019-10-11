module Top (Clk,Rst_n,Rx,Tx,RxData);

///////////////Inputs/////////////////

input Clk;					//clock
input Rst_n;				//reset
input Rx;					//Rx pin

/////////////Outputs////////////////

output Tx;					//Tx pin
output [7:0] RxData;		//to LEDs

wire [7:0] TxData;
wire RxDone;
wire TxDone;
wire tick;
wire TxEn;
wire RxEn;
wire [3:0] NBits;
wire [15:0] BaudRate;

assign RxEn = 1'b1;
assign TxEn = 1'b1;
assign BaudRate = 16'd325;			// baudrate = 9600 --> 325, 115200 --> 27
assign NBits = 4'b1000;

UART_rs232_rx I_RS232RX(
	.Clk(Clk),
	.Rst_n(Rst_n),
	.RxEn(RxEn),
	.RxData(RxData),
	.RxDone(RxDone),
	.Rx(Rx),
	.Tick(tick),
	.NBits(NBits)
	);
	
UART_rs232_tx I_RS232TX(
	.Clk(Clk),
	.Rst_n(Rst_n),
	.TxEn(TxEn),
	.TxData(TxData),
	.TxDone(TxDone),
	.Tx(Tx),
	.Tick(tick),
	.NBits(NBits)
	);
	
UART_baudrate_generator I_BAUDGEN(
	.Clk(Clk),
	.Rst_n(Rst_n),
	.Tick(tick),
	.Baudrate(BaudRate)
	);
	
endmodule
