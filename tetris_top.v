`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/15 22:41:17
// Design Name: 
// Module Name: tetris_top
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

module tetris_top(
input clk,clr,moveT,move_down,isdie,shift,remove_1,remove_2,gen_random,stop,auto_down,clk_n,
input U,D,L,R,
output hsync_t,vsync_t,
output [3:0] r_t,g_t,b_t,
output move_comp,shift_finish,down_comp,die,remove_2_finish);

wire [239:0] M_OUT;
wire [4:0] n;
wire [3:0] m;
wire [6:0] BLOCK;
wire [199:0] data_out;

tetris x1(
.clk(clk),
.clr(clr),
.gen_random(gen_random),
.moveT(moveT),
.move_down(move_down),
.isdie(isdie),
.shift(shift),
.remove_1(remove_1),
.remove_2(remove_2),
.u(U),
.l(L),
.r(R),
.d(D),
.move_comp(move_comp),
.shift_finish(shift_finish),
.down_comp(down_comp),
.die(die),
.M_OUT(M_OUT),
.n(n),
.m(m),
.BLOCK(BLOCK),
.remove_2_finish(remove_2_finish),
.stop(stop),
.auto_down(auto_down)
);

merge x2(
.clk(clk),
.clr(clr),
.M_OUT(M_OUT),
.BLOCK(BLOCK),
.y_pos(n),
.x_pos(m),
.data_out(data_out)
);

vga_t x3(
.clk_n(clk_n),
.clr(clr),
.num(data_out),
.hsync_t(hsync_t),
.vsync_t(vsync_t),
.r_t(r_t),
.g_t(g_t),
.b_t(b_t)
);
endmodule
