`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/23 21:50:32
// Design Name: 
// Module Name: db
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


module db(
input btn,clk,clr,
output out
);
reg d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16;

always @(posedge clk or posedge clr)
    begin
        if (clr)
            begin
                d1 <= 0;
                d2 <= 0;
                d3 <= 0;
                d4 <= 0;
                d5 <= 0;
                d6 <= 0;
                d7 <= 0;
                d8 <= 0;
                d9 <= 0;
                d10 <= 0;
                d11 <= 0;
                d12 <= 0;
                d13 <= 0;
                d14 <= 0;
                d15 <= 0;
                d16 <= 0;
             end
         else
            begin
                d1 <= btn;
                d2 <= d1;
                d3 <= d2;
                d4 <= d3;
                d5 <= d4;
                d6 <= d5;
                d7 <= d6;
                d8 <= d7;
                d9 <= d8;
                d10 <= d9;
                d11 <= d10;
                d12 <= d11;
                d13 <= d12;
                d14 <= d13;
                d15 <= d14;
                d16 <= d15;
             end
          end
assign out = ~d15&d14;
endmodule
