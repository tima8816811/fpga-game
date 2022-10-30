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
wire move,store,start,judge,win;
wire move_able,judge_able;
wire blink;
wire [2:0] vga_control;
wire [3:0] code;
wire [799:0] data_q,data_b;
wire clk_n;
wire hsync_i,vsync_i;
wire hsync_m,vsync_m;
wire [3:0] r_m,g_m,b_m,r_i,g_i,b_i;

wire hsync_t,vsync_t;
wire [3:0] r_t,g_t,b_t;

wire hold,gen_random,shift,move_down,remove_1,remove_2,stop,moveT,isdie,auto_down;
wire shift_finish,remove_2_finish,down_comp,move_comp,die;

db u1 (
.clk(clk),
.clr(clr),
.up(up),
.down(down),
.left(left),
.right(right),
.L(L),
.U(U),
.R(R),
.D(D)
);

control c1(
.clk(clk),
.clr(clr),
.U(U),
.L(L),
.R(R),
.D(D),
.move_able(move_able),
.judge_able(judge_able),
.move(move),
.store(store),
.start(start),
.judge(judge),
.win(win),
.vga_control(vga_control),
.blink(blink),
.shift_finish(shift_finish),
.remove_2_finish(remove_2_finish),
.down_comp(down_comp),
.move_comp(move_comp),
.die(die),
.hold(hold),
.gen_random(gen_random),
.shift(shift),
.move_down(move_down),
.remove_1(remove_1),
.remove_2(remove_2),
.stop(stop),
.moveT(moveT),
.isdie(isdie),
.auto_down(auto_down)
);

maze_top t1(
.clk(clk),
.clr(clr),
.move(move),
.store(store),
.start(start),
.judge(judge),
.U(U),
.L(L),
.R(R),
.D(D),
.vga_control(vga_control),
.clk_n(clk_n),
.hsync_m(hsync_m),
.vsync_m(vsync_m),
.r_m(r_m),
.g_m(g_m),
.b_m(b_m),
.move_able(move_able),
.judge_able(judge_able)
);

tetris_top tt2(
.clk(clk),
.clr(clr),
.moveT(moveT),
.move_down(move_down),
.isdie(isdie),
.shift(shift),
.remove_1(remove_1),
.remove_2(remove_2),
.gen_random(gen_random),
.move_comp(move_comp),
.shift_finish(shift_finish),
.down_comp(down_comp),
.die(die),
.remove_2_finish(remove_2_finish),
.U(U),
.L(L),
.R(R),
.D(D),
.clk_n(clk_n),
.hsync_t(hsync_t),
.vsync_t(vsync_t),
.r_t(r_t),
.g_t(g_t),
.b_t(b_t),
.stop(stop),
.auto_down(auto_down)
);

clk_unit c2(
.clk(clk),
.rst(clr),
.clk_n(clk_n)
);
	
vga_interface v2(
.clk(clk_n),
.clr(clr),
.hsync_i(hsync_i),
.vsync_i(vsync_i),
.r_i(r_i),
.g_i(g_i),
.b_i(b_i)
);

mux_vga m1(
.clk(clk),
.clr(clr),
.r_m(r_m),
.g_m(g_m),
.b_m(b_m),
.r_i(r_i), 
.g_i(g_i),
.b_i(b_i),
.r_t(r_t),
.g_t(g_t),
.b_t(b_t),
.hsync_m(hsync_m),
.vsync_m(vsync_m),
.hsync_i(hsync_i),
.vsync_i(vsync_i),
.hsync_t(hsync_t),
.vsync_t(vsync_t),
.blink(blink),
.vga_control(vga_control),
.vsync(vsync),
.hsync(hsync),
.r(r),
.g(g),
.b(b)
);
endmodule