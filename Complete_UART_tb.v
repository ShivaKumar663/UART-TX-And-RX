`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.08.2025 16:19:39
// Design Name: 
// Module Name: Complete_UART_tb
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


module Complete_UART_tb();


    reg main_clk;
    reg main_reset,TX_start;
    wire [7:0]UART_out;
    wire tx_done;
    reg [7:0]UART_in;
    wire RX_done;

    Complete_UART dut (TX_start,UART_out,UART_in,main_clk,main_reset,RX_done,tx_done,flag_out);
    
    initial begin
        UART_in = 8'b0000_1111;
    end
    
    initial begin
        main_clk = 0;
        forever #5 main_clk = ~main_clk;
    end

    initial begin
        #1 main_reset = 1;
        #6 main_reset = 0;
        #1 TX_start = 1;
        #10000 $finish;
    end
    
    initial begin
    $monitor($time,"tx_done = %b,data_in = %b,data_out = %b,rx_done =%b",tx_done,UART_in,UART_out,RX_done);
    end
    
    
endmodule