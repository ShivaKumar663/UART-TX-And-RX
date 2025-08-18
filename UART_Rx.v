`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.08.2025 10:03:25
// Design Name: 
// Module Name: UART_Rx
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


module UART_Rx(rx_start,rx_flag,bit_in,Rx_output,rx_done,R_reset,R_clk);

output [7:0] Rx_output;
output rx_done;
input [7:0]bit_in;
input rx_start,R_clk,R_reset,rx_flag;


 UART_Rece Uart_Receiver(.r_done(rx_done),.r_start(rx_start),.idle_bit(idle_bit),.data_out(Rx_output),.stop_bit(stop_bit),.data_in(bit_in),.start_bit(start_bit),.clk1(R_clk),.rst1(R_reset),.flag_in(rx_flag),.count(count),.rx_count(rx_count));

endmodule



module UART_Rece(r_done,r_start,idle_bit,data_out,stop_bit,data_in,start_bit,clk1,rst1,flag_in,count,rx_count);
output reg [7:0]data_out;
output reg r_done;
output reg idle_bit;
output reg stop_bit;
output reg [2:0]rx_count;
input [7:0]data_in;
input r_start;
output reg start_bit;
input clk1,rst1,flag_in;
output reg [3:0]count;
reg [1:0] ps,ns;

parameter idle = 2'b00,start = 2'b01,trans = 2'b10,stop = 2'b11;


always@(posedge clk1 or posedge rst1)
begin
    if(rst1)
        begin
            ps <= idle;
        end
    else
        begin
            ps <= ns;
        end
end


always@(posedge clk1)
begin
    if(rst1)
        begin
            count <= 0;
            rx_count <= 7;
            start_bit <= 1;
            idle_bit <= 0;
            r_done <= 0;
            stop_bit <= 0;
            data_out <= 0;
            
        end
   else   
   case(ps)
    idle:begin
        idle_bit <= r_start?0:1;
        stop_bit <=0;
        count <= 0;
    end
    
    start:begin
        start_bit <= 0;
        stop_bit <=0;
        r_done <= 0;
    end
    
    trans:begin
        if(count < 8) //efficient
            begin
                if(flag_in) begin
                data_out[rx_count] <= data_in[count];
                count <= count + 1;
                rx_count <= rx_count-1;
                end
            end
     end
     
     stop:begin
        stop_bit <= 1;
        idle_bit <= 1;
        r_done <= 1;
     end
    
endcase
end

always@(*)
begin
    case(ps)
        idle:begin
                ns = r_start?start:idle;
             end
             
        start:begin
                ns = trans;
              end
              
        trans:begin
                ns = (count == 8)? stop:trans;
              end
        stop:begin
               ns = stop;
               
             end 
    endcase
end       
         
endmodule

