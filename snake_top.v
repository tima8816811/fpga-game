`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/04 00:15:31
// Design Name: 
// Module Name: snake_top
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

module snake_top(
    input clk,
	input clr,
	input clk_n,
	input L,
	input R,
	input U,
	input D,
	input s_start,s_play,s_die,
		
	output  hsync_s,
	output  vsync_s,
	output [3:0] r_s,g_s,b_s,
	output hit_wall,
	output hit_body
    );
    
    wire [9:0]x_pos;
	wire [9:0]y_pos;
    wire [1:0]snake;
	wire add_cube;
	wire [5:0]apple_x;
	wire [4:0]apple_y;
	wire [6:0]cube_num;
	wire [5:0]head_y;
	wire [5:0]head_x;
	wire add_cube;
	
    snake s1(
    .clk(clk),
	.clr(clr),
	.L(L),
	.R(R),
	.U(U),
	.D(D),
	.x_pos(x_pos),
	.y_pos(y_pos), 
	.s_start(s_start),
	.s_play(s_play),
	.s_die(s_die),
	.snake(snake),
	.hit_body(hit_body), 
	.hit_wall(hit_wall),
	.cube_num(cube_num),
	.head_y(head_y),
	.head_x(head_x),
	.add_cube(add_cube)
    );
    
    apple s2 (
    .clk(clk),
	.clr(clr),
	.head_y(head_y),
	.head_x(head_x),
	.apple_x(apple_x),
	.apple_y(apple_y),
	.add_cube(add_cube)
    );
    
    vga_s s3(
    .clk(clk_n),
	.clr(clr),
	.snake(snake),
	.apple_x(apple_x),
	.apple_y(apple_y),
	.x_pos(x_pos),
	.y_pos(y_pos),	
	.hsync_s(hsync_s),
	.vsync_s(vsync_s),
	.r_s(r_s),
	.g_s(g_s),
	.b_s(b_s)
    );
    
endmodule
