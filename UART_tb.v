`timescale 1ns / 1ps

module UART_tb;

reg CLK;
reg RST;
reg [7:0]Data_in;
wire [4:0]Tx_count;
wire Tx_done;
wire Data_out;
wire flag_sig;
wire [1:0]TX_States;
wire [4:0]Rx_count;
wire  [7:0]RX_Data;
wire [1:0]RX_States;


UART dut(CLK,RST,Tx_done,Data_in,Data_out,Tx_count,flag_sig,TX_States,RX_States,RX_Data,Rx_count);

initial begin
Data_in = 8'b11001000;
end


initial begin 
CLK = 0;
forever #5 CLK = ~CLK;
end

initial begin
RST = 1;
#6 RST = 0;
#1000 $finish;
end

endmodule
