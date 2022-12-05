`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/02 20:12:09
// Design Name: 
// Module Name: maze_top
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


module maze_top(
input clk,clr,move,store,start,judge,vga_control,clk_n,
input U,D,L,R,
output hsync_m,vsync_m,
output [3:0] r_m,g_m,b_m,
output move_able,judge_able
);

wire [799:0] data_q,data_b;
    
data da1(
.clk(clk),
.clr(clr),
.move(move),
.store(store),
.start(start),
.judge(judge),
.move_able(move_able),
.judge_able(judge_able),
.data_q(data_q),
.data_b(data_b),
.U(U),
.L(L),
.R(R),
.D(D),
.vga_control(vga_control)
);

vga v1(
.clk(clk_n),
.clr(clr),
.data_q(data_q),
.data_b(data_b),
.hsync_m(hsync_m),
.vsync_m(vsync_m),
.r_m(r_m),
.g_m(g_m),
.b_m(b_m)
);
endmodule
