`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.08.2025 11:28:45
// Design Name: 
// Module Name: Complete_UART
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Complete_UART(TX_start,UART_out,UART_in,main_clk,main_reset,RX_done,tx_done,flag_out);
output [7:0]UART_out;
output RX_done;
output tx_done,flag_out;
input [7:0]UART_in;
input main_clk,main_reset,TX_start;
wire [7:0] data_bridge;

baud_rate_gen BAUD_RATE_GENERATOR(.flag(flag_out),.clk(main_clk),.rst(main_reset));
UART_Transmitter_ony Transmitter(.tx_done(tx_done),.tx_start(TX_start),.clock(main_clk),.d_in(UART_in),.reset(main_reset),.d_out(data_bridge),.flag(flag_out));
UART_Rx Receiver(.rx_start(tx_done),.rx_flag(flag_out),.bit_in(data_bridge),.Rx_output(UART_out),.rx_done(RX_done),.R_reset(main_reset),.R_clk(main_clk));


endmodule
