`timescale 1ns / 1ps
module UART_RX(r_done,rx_data,rx_data_in,clk,rst,rx_count,flag_in,ps,start_sig);
input clk,rst,flag_in,start_sig;
input rx_data_in;
output reg [7:0]rx_data;
output reg r_done;
output reg [4:0]rx_count;
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
            rx_count<= 4'd0;
            r_done <= 0;
            rx_data <= 8'b00000000;
        end
    else
        begin
            ps <= ns;
        end
end

always@(*)
begin
    case(ps)
        idle:begin
                ns = (rx_data_in == 1)?start:idle;
             end
             
        start:begin
                ns = (rx_data_in == 0)?trans:start;
             end
              
        trans:begin
                if(flag_in)
                    begin
                        if(rx_count== 4'd8)
                           begin
                             rx_count= 0;
                             ns = stop;
                           end
                        else
                            begin
                                rx_data[rx_count] = rx_data_in;
                                rx_count= rx_count+ 1;
                                ns = trans;
                            end    
                    end
                   
                   else
                       ns = trans;
                   
              end
              
        stop:begin
               r_done = 1;
               ns = stop;
             end 
    endcase
end       
endmodule
