`timescale 1ns / 1ps
module UART(CLK,RST,Tx_done,Data_in,Data_out,Tx_count,flag_sig,TX_States,RX_States,RX_Data,Rx_count);
input CLK;
input RST;
input [7:0]Data_in;
output [4:0]Tx_count;
output [4:0]Rx_count;
output wire Tx_done;
output Data_out;
output  [7:0]RX_Data;
////test signals//////////////
output flag_sig;
output [1:0]TX_States;
output [1:0]RX_States;
/////////////////////////////


Baud_rate_gen BAUD_RATE_GENERATOR(.flag(flag_sig),.clk(CLK),.rst(RST));
UART_TX UART_TRA(.t_done(Tx_done),.data_out(Data_out),.data(Data_in),.clk(CLK),.rst(RST),.tx_count(Tx_count),.flag_in(flag_sig),.ps(TX_States));
UART_RX UART_REC(.r_done(r_done),.rx_data(RX_Data),.rx_data_in(Data_out),.clk(CLK),.rst(RST),.rx_count(Rx_count),.flag_in(flag_sig),.ps(RX_States));
endmodule
