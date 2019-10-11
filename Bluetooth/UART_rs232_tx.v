module UART_rs232_tx (Clk,Rst_n,TxEn,TxData,TxDone,Tx,Tick,NBits);

//////////Inputs/////////

input Clk, Rst_n, TxEn, Tick;
input [3:0]NBits;
input [7:0]TxData;

/////////Outputs////////

output Tx;
output TxDone;

//States of the state machine

parameter IDLE = 1'b0, WRITE = 1'b1;

reg State, Next;						//current and next states
reg TxDone = 1'b0;					//notifying whether transmission is finished
reg Tx;									//input value
reg write_enable = 1'b0;			//activate or deactivate transmission
reg start_bit = 1'b1;				//start bit is made or not
reg stop_bit = 1'b0;					//stop bit is made or not

reg [4:0] Bit = 5'b00000;			//current bit
reg [3:0] counter = 4'b0000;		//counter for the tick pulses
reg [7:0] in_data = 8'b00000000;	//input data to be transmitted
reg [1:0] R_edge;						//to avoid bounce in the write enable pin
wire D_edge;							

//////////////////State Machine/////////////////////

///////////////////Reset/////////////////////

always @ (posedge Clk or negedge Rst_n)
begin
	if (!Rst_n)		State <= IDLE;			//Reset
	else 				State <= Next;
end

/////////////////Next State//////////////////

always @ (State or D_edge or TxData or TxDone)
begin
	case (State)
		IDLE: if (D_edge)			Next = WRITE;
				else 					Next = IDLE;
		WRITE: if (TxDone)		Next = IDLE;
				 else 				Next = WRITE;
		default 						Next = IDLE;
	endcase
end

////////////////Enabling Write//////////////////

always @ (State)
begin
	case (State)
		WRITE:begin
					write_enable <= 1'b1;
				end
		IDLE: begin
					write_enable <= 1'b0;
				end
	endcase
end

///////////////Writing data transmission output////////////////

always @ (posedge Tick)
begin
	if (!write_enable)
	begin
		TxDone <= 1'b0;
		start_bit <= 1'b1;
		stop_bit <= 1'b0;
	end
	
	if (write_enable)
	begin
		counter <= counter + 1;
		
		if (start_bit & !stop_bit)
		begin
			Tx <= 1'b0;
			in_data <= TxData;
		end
		
		if ((counter == 4'b1111) & (start_bit))
		begin
			start_bit <= 1'b0;
			in_data <= {1'b0,in_data[7:1]};
			Tx <= in_data[0];						//counter <= 4'b0000
		end
		
		if ((counter == 4'b1111) & (!start_bit) & (Bit < NBits - 1))
		begin
			in_data <= {1'b0,in_data[7:1]};
			Bit <= Bit + 1;
			Tx <= in_data[0];
			start_bit <= 1'b0;
			counter <= 4'b0000;
		end
		
		if ((counter == 4'b1111) & (Bit == NBits - 1) & (!stop_bit))
		begin 
			Tx <= 1'b1;
			counter <= 4'b0000;
			stop_bit <= 1'b1;
		end
		
		if ((counter == 4'b1111) & (Bit == NBits - 1) & (stop_bit))
		begin
			Bit <= 4'b0000;
			TxDone <= 1'b1;
			counter <= 4'b0000;
		end
	end
end

////////////////Detection of input enable/////////////////

always @ (posedge Clk or negedge Rst_n)
begin
	if (!Rst_n)
	begin
		R_edge <= 2'b00;
	end
	
	else
	begin
		R_edge <= {R_edge[0], TxEn};
	end
end
assign D_edge = !R_edge[1] & R_edge[0];

endmodule
