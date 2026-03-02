`timescale 1ns / 1ps

module UART_TX(t_done,data_out,data,clk,rst,tx_count,flag_in,ps);
input clk,rst,flag_in;
input [7:0]data;
output reg data_out;
output reg t_done;
output reg [4:0]tx_count;
reg start_bit;
reg idle_bit;
reg stop_bit;
output reg [1:0] ps;
reg [1:0] ns;


parameter idle = 2'b00,start = 2'b01,trans = 2'b10,stop = 2'b11;


always@(posedge clk)
begin
    if(rst)
        begin
            ps <= idle;
            tx_count <= 4'd0;       
            t_done <= 0;
        end
    else
        begin
            ps <= ns;
        end
end

always@(*)
begin
            start_bit = 0;
            idle_bit  = 1;
            stop_bit  = 1;
    
    case(ps)
        idle:begin
                data_out = idle_bit;
                ns = start;
             end
             
        start:begin
                data_out = start_bit;
                ns = trans;
              end
              
        trans:begin
                if(flag_in)
                    begin
                        if(tx_count == 4'd8)
                           begin
                             tx_count = 0;
                             ns = stop;
                           end
                        else
                            begin
                                data_out = data[tx_count];
                                tx_count = tx_count + 1;
                                ns = trans;
                            end    
                    end
                   
                   else
                       ns = trans;
                   
              end
              
        stop:begin
               data_out = stop_bit;
               ns = stop;
               t_done = 1;
             end 
    endcase
end       
endmodule
