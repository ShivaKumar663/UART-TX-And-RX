`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.08.2025 11:30:10
// Design Name: 
// Module Name: UART_Transmitter_ony
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


module UART_Transmitter_ony(tx_done,tx_start,clock,d_in,reset,d_out,flag);

output  tx_done;
input tx_start,clock,reset,flag;
input [7:0]d_in;
output [7:0] d_out;
//output [2:0] op_count;
//output [2:0] t_count;

UART_Trans Transmitter(.t_done(tx_done),.t_start(tx_start),.idle_bit(idle_bit),.data_out(d_out),.stop_bit(stop_bit),.data(d_in),.start_bit(start_bit),.clk1(clock),.rst1(reset),.flag_in(flag),.count(count),.tx_count(tx_count));


endmodule



module UART_Trans(t_done,t_start,idle_bit,data_out,stop_bit,data,start_bit,clk1,rst1,flag_in,count,tx_count);
output reg [7:0]data_out;
output reg t_done;
output reg idle_bit;
output reg stop_bit;
output reg [2:0]tx_count;
input [7:0]data;
input t_start;
output reg start_bit;
input clk1,rst1,flag_in;
output reg [2:0]count;
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
            tx_count <= 7;
            start_bit <= 1;
            idle_bit <= 0;
            t_done <= 0;
            stop_bit <= 0;
            data_out <= 0;
            
        end
   else   
   case(ps)
    idle:begin
        idle_bit <= t_start?0:1;
        stop_bit <=0;
        count <= 0;
    end
    
    start:begin
        start_bit <= 0;
        stop_bit <=0;
        t_done <= 0;
    end
    
    trans:begin
        if(count < 8) //efficient
            begin
                if(flag_in) begin
                data_out[tx_count] <= data[count];
                count <= count + 1;
                tx_count <= tx_count-1;
                end
            end
     end
     
     stop:begin
        stop_bit <= 1;
        idle_bit <= 1;
        t_done <= 1;
     end
    
endcase
end

always@(*)
begin
    case(ps)
        idle:begin
                ns = t_start?start:idle;
             end
             
        start:begin
                ns = trans;
              end
              
        trans:begin
                ns = (tx_count == 0)? stop:trans;
              end
              
        stop:begin
               ns = stop;
               
             end 
    endcase
end       
         
endmodule
