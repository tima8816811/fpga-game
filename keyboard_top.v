`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/07 01:24:20
// Design Name: 
// Module Name: keyboard_top
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


module keyboard_top(
input wire clk ,
input wire PS2C ,
input wire PS2D ,
input wire  clr ,
output wire L,U,R,D
 );
wire  clk25;
wire [15:0] xkey;

clkdiv U1 (.clk(clk),
  .clr(clr), .clk25(clk25)
  );

keyboard U2 (.clk25(clk25),
  .clr(clr), .PS2C(PS2C), .PS2D(PS2D), .xkey(xkey)
);

db U3(
.clk(clk),
.clr(clr),
.xkey(xkey),
.L(L),
.R(R),
.D(D),
.U(U)
);


endmodule
