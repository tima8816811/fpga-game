`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/06 22:07:29
// Design Name: 
// Module Name: tb
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


module tb();
    reg clk;
    reg clr;
    reg up;
    reg left;
    reg right;
    reg down;
    
    wire vsync;
    wire hsync;
    
    
    wire [3:0] r,g,b;
    
    top u(
        .clk(clk),
        .clr(clr),
        .up(up),
        .left(left),
        .right(right),
        .down(down),
        .vsync(vsync),
        .hsync(hsync),
        .r(r),
        .g(g),
        .b(b)
        );
    
    initial
    begin
        #0 clk = 0;
        #0 clr = 1;
        #10 clr = 0;  
        #100 down = 1;
        #100 down = 0;
    //    #100 down = 1;
      //  #100 down = 0;
       // #100 right=1;
       #100 right=1;
       #100 right=0;
         #100 right=1;
       #100 right=0;
         #500 right=1;
       #100 right=0;
      //  #100 right=0;
       // #12500000 right=1;
       // #12500000 right=0;
        
    end
    
    always #1 clk = ~clk;
    
endmodule
