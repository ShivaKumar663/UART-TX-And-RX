`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.08.2025 09:12:12
// Design Name: 
// Module Name: baud_rate_gen\
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


module baud_rate_gen(flag,clk,rst);
 reg [7:0] baud_rate;
output reg flag;
input clk,rst;

always@(posedge clk)
begin
    if(rst)
        begin
            baud_rate <= 0;
            flag <= 0;
         end
        
   else if(baud_rate == 145)
    begin
        baud_rate <= 0;
        flag <= 1;
    end  
    
    else
        begin
            baud_rate <= baud_rate + 1;
            flag <= 0;
        end   
    
end

endmodule
