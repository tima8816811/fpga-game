`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/06 00:18:05
// Design Name: 
// Module Name: apple
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


module apple(
	input clk,
	input clr,	
	input [5:0]head_x,
	input [5:0]head_y,
	
	output reg [5:0]apple_x,
	output reg [4:0]apple_y,
	output reg add_cube
);

	reg [31:0]clk_cnt;
	reg [10:0]random_num;
	
	always@(posedge clk)
		random_num <= random_num + 999;  //用加法產生隨機數
	//隨機數高5位為食物X坐標 低5位為蘋果Y坐標
	always@(posedge clk or posedge clr) begin
		if(clr) begin
			clk_cnt <= 0;
			apple_x <= 12;
			apple_y <= 5;
			add_cube <= 0;
		end
		else begin
			clk_cnt <= clk_cnt+1;
			if(clk_cnt == 250_00_000) begin
				clk_cnt <= 0;
				if(apple_x == head_x && apple_y == head_y) begin
					add_cube <= 1;
					apple_x <= (random_num[10:5] > 36) ? (random_num[10:5] - 25) : (random_num[10:5] == 0) ? 1 : random_num[10:5];
					apple_y <= (random_num[4:0] > 28) ? (random_num[4:0] - 3) : (random_num[4:0] == 0) ? 1:random_num[4:0];
				end   //判斷隨機數是否超出頻幕坐標範圍 將隨機數轉換為下個蘋果的X Y坐標
				else
					add_cube <= 0;
			end
		end
	end
endmodule
