module UART_rs232_rx(Clk,Rst_n,RxEn,RxData,RxDone,Rx,Tick,NBits);

//////////Inputs///////////
input Clk, Rst_n, RxEn, Rx, Tick;
input [3:0]NBits;

/////////Outputs//////////
output RxDone;
output [7:0]RxData;

//States of the state machine
parameter IDLE = 1'b0, READ = 1'b1;

reg [1:0] State, Next;					//current and next states
reg read_enable = 1'b0;					//enabling data read
reg start_bit = 1'b1;					//notifying the start bit
reg RxDone = 1'b0;						//notifying the end of data read
reg [4:0]Bit = 5'b00000;				//current bit which is reading
reg [3:0]counter = 4'b0000;			//counter for ticks
reg [7:0]Read_data = 8'b00000000;	//register for read data bits
reg [7:0]RxData;

////////State Machine/////////

////////////Reset/////////////

always @ (posedge Clk or negedge Rst_n)
begin
	if (!Rst_n)		State <= IDLE;			//Reset = low --> initial state
	else				State <= Next;			//else --> next state
end

//////////Next State//////////

always @ (State or Rx or RxEn or RxDone)
begin
	case(State)
		IDLE: if(!Rx & RxEn)		Next = READ;	//State is idle and received value is low and the recieve is enabled
				else					Next = IDLE;
		READ:	if(RxDone)			Next = IDLE;	//State is read and recieving is finished
				else					Next = READ;
		default						Next = IDLE;
	endcase
end


/////////Enabling Read///////////

always @ (State or RxDone)
begin
	case (State)
		READ:	begin
					read_enable <= 1'b1;		//Enable read in read state
				end
		
		IDLE:	begin
					read_enable <= 1'b0;		//Disable read in idle state
				end
	endcase
end

//////////Reading Data////////////

always @ (posedge Tick)
begin
	if (read_enable)
	begin
		RxDone <= 1'b0;
		counter <= counter + 1;		//increment the counter when read enabled
		
		if ((counter == 4'b1000) & (start_bit))	//start bit
		begin
			start_bit <= 1'b0;
			counter <= 4'b0000;
		end
		
		if ((counter == 4'b1111) & (!start_bit) & (Bit < NBits))		//Reading data bits
		begin
			Bit <= Bit + 1;
			Read_data <= {Rx,Read_data[7:1]};
			counter <= 4'b0000;
		end
		
		if ((counter == 4'b1111) & (Bit == NBits) & (Rx))		//stop bit
		begin
			Bit <= 4'b0000;
			RxDone <= 1'b1;
			counter <= 4'b0000;
			start_bit <= 1'b1;
		end
	end
end

////////////Assigning the output/////////////

always @ (posedge Clk)
begin
	if (NBits == 4'b1000)
	begin
		RxData[7:0] <= Read_data[7:0];
	end
	
	if (NBits == 4'b0111)
	begin
		RxData[7:0] <= {1'b0,Read_data[7:1]};
	end
	
	if (NBits == 4'b0110)
	begin
		RxData[7:0] <= {1'b0,1'b0,Read_data[7:2]};
	end
end

endmodule
