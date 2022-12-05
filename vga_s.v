module vga_s(
	input clk,
	input clr,
	
	input [1:0]snake,
	input [5:0]apple_x,
	input [4:0]apple_y,
	output reg[9:0]x_pos,
	output reg[9:0]y_pos,	
	output reg hsync_s,
	output reg vsync_s,
	output [3:0] r_s,g_s,b_s 
);
    reg [11:0] color_out;
	reg [19:0]clk_cnt;
	reg [9:0]line_cnt;
	reg clk_25M;
	
	parameter NONE = 2'b00;
	parameter HEAD = 2'b01;
	parameter BODY = 2'b10;
	parameter WALL = 2'b11;
	
	parameter HEAD_COLOR = 12'b0000_1111_0000;
	parameter BODY_COLOR = 12'b0000_1111_0000;
	
	
	reg [3:0]lox;
	reg [3:0]loy;
		
	always@(posedge clk or posedge clr) begin
		if(clr) begin
			clk_cnt <= 0;
			line_cnt <= 0;
			hsync_s <= 1;
			vsync_s <= 1;
		end
		else begin
		    x_pos <= clk_cnt - 144;
			y_pos <= line_cnt - 33;	
			if(clk_cnt == 0) begin
			    hsync_s <= 0;
				clk_cnt <= clk_cnt + 1;
            end
			else if(clk_cnt == 96) begin
				hsync_s <= 1;
				clk_cnt <= clk_cnt + 1;
            end
			else if(clk_cnt == 799) begin
				clk_cnt <= 0;
				line_cnt <= line_cnt + 1;
			end
			else clk_cnt <= clk_cnt + 1;
			if(line_cnt == 0) begin
				vsync_s <= 0;
            end
			else if(line_cnt == 2) begin
				vsync_s <= 1;
			end
			else if(line_cnt == 521) begin
				line_cnt <= 0;
				vsync_s <= 0;
			end
			
			if(x_pos >= 0 && x_pos < 640 && y_pos >= 0 && y_pos < 480) begin
			    lox = x_pos[3:0];
				loy = y_pos[3:0];						
				if(x_pos[9:4] == apple_x && y_pos[9:4] == apple_y)
					case({loy,lox})
						8'b0000_0000:color_out = 12'b0000_0000_0000;
						default:color_out = 12'b0000_0000_1111;
					endcase						
				else if(snake == NONE)
					color_out = 12'b0000_0000_0000;
				else if(snake == WALL)
					color_out = 3'b101;
				else if(snake == HEAD|snake == BODY) begin   //根據當前掃描到的點是哪一部分輸出相應顏色
					case({lox,loy})
						8'b0000_0000:color_out = 12'b0000_0000_0000;
						default:color_out = (snake == HEAD) ?  HEAD_COLOR : BODY_COLOR;
					endcase
				end
			end
		    else
			    color_out = 12'b0000_0000_0000;
		end
    end
    
    assign r_s = color_out[3:0];
    assign g_s = color_out[7:4];
    assign b_s = color_out[11:8];
    
endmodule
