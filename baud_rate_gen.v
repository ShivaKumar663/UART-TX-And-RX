`timescale 1ns / 1ps

/* The baud rate generator is used to generate baud rate, here we are using generating the baudrate of 9600 which is derived from the 100 MHZ clk
   here we will take a count which will count upto 10417 we have obtained this value by dividing our freq/baud_rate...the data transfer takes place in 
   UART Protocol based on the baud_tick we are generating as by the name it is asynchronous it does not depends on the clock */


module Baud_rate_gen(flag,clk,rst);
input clk,rst;
output reg flag;
reg [13:0]count;

parameter baud_tick = 10417;


always@(posedge clk)
begin
    if(rst)
        begin
            count <= 0;
            flag <= 0;
         end
        
   else if(count == baud_tick)
    begin
        count <= 0;
        flag <= 1;
    end  
    
    else
        begin
            count <= count + 1;
            flag <= 0;
        end   
    
end

endmodule
