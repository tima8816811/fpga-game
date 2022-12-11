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
input clk,clr,PS2D,PS2C,
output hsync,vsync,
output [3:0] r,g,b
);

wire U,R,L,D;
wire move,store,start,judge,win;
wire move_able,judge_able;
wire blink;
wire [3:0] vga_control;
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

wire s_die,s_play,s_start;
wire hsync_s,vsync_s;
wire [3:0] r_s,g_s,b_s;
wire hit_wall,hit_body;

wire hsync_win,vsync_win;
wire [3:0] r_win,g_win,b_win;

wire hsync_lose,vsync_lose;
wire [3:0] r_lose,g_lose,b_lose;

keyboard_top u1 (
.clk(clk),
.clr(clr),
.PS2D(PS2D),
.PS2C(PS2C),
.L(L),
.R(R),
.D(D),
.U(U)	
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
.auto_down(auto_down),
.s_start(s_start),
.s_play(s_play),
.s_die(s_die),
.hit_wall(hit_wall),
.hit_body(hit_body)
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
.r_s(r_s),
.g_s(g_s),
.b_s(b_s),
.hsync_m(hsync_m),
.vsync_m(vsync_m),
.hsync_i(hsync_i),
.vsync_i(vsync_i),
.hsync_t(hsync_t),
.vsync_t(vsync_t),
.vsync_s(vsync_s),
.hsync_s(hsync_s),
.blink(blink),
.vga_control(vga_control),
.vsync(vsync),
.hsync(hsync),
.r(r),
.g(g),
.b(b),
.hsync_lose(hsync_lose),
.vsync_lose(vsync_lose),
.r_lose(r_lose),
.g_lose(g_lose),
.b_lose(b_lose),
.hsync_win(hsync_win),
.vsync_win(vsync_win),
.r_win(r_win),
.g_win(g_win),
.b_win(b_win)
);

snake_top s1(
.clk(clk),
.clr(clr),
.clk_n(clk_n),
.U(U),
.L(L),
.R(R),
.D(D), 
.s_start(s_start),
.s_play(s_play),
.s_die(s_die),
.vsync_s(vsync_s),
.hsync_s(hsync_s),
.r_s(r_s),
.g_s(g_s),
.b_s(b_s),
.hit_wall(hit_wall),
.hit_body(hit_body)
);

vga_win v3(
.clk(clk_n),
.clr(clr),
.hsync_i(hsync_win),
.vsync_i(vsync_win),
.r(r_win),
.g(g_win),
.b(b_win)
);

vga_lose v4(
.clk(clk_n),
.clr(clr),
.hsync_i(hsync_lose),
.vsync_i(vsync_lose),
.r(r_lose),
.g(g_lose),
.b(b_lose)
);
endmodule
