`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/27 15:57:47
// Design Name: 
// Module Name: top
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

module top(
input clk,clr,up,right,down,left,
output hsync,vsync,
output [3:0] r,g,b
);

wire U,R,L,D;
wire move,store,start;
wire move_able;
wire [3:0] code;
wire [199:0] data_out;
wire clk_n;

db u1 (
.clk(clk),
.clr(clr),
.btn(up),
.out(U)
);

db u2 (
.clk(clk),
.clr(clr),
.btn(right),
.out(R)
);

db u3 (
.clk(clk),
.clr(clr),
.btn(down),
.out(D)
);

db u4 (
.clk(clk),
.clr(clr),
.btn(left),
.out(L)
);

control c1(
.clk(clk),
.clr(clr),
.U(U),
.L(L),
.R(R),
.D(D),
.move_able(move_able),
.move(move),
.store(store),
.start(start)
);

data da1(
.clk(clk),
.clr(clr),
.move(move),
.store(store),
.start(start),
.move_able(move_able),
.data_out(data_out),
.u(U),
.l(L),
.r(R),
.d(D)
);

clk_unit c2(
.clk(clk),
.rst(rst),
.clk_n(clk_n)
);
	
vga v1(
.clk(clk_n),
.clr(clr),
.data(data_out),
.hsync(hsync),
.vsync(vsync),
.r(r),
.g(g),
.b(b)
);

endmodule