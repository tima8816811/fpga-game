`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/23 21:50:32
// Design Name: 
// Module Name: db
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


module db(
    input clk,
	input clr,
    input [15:0] xkey,
	
	output reg L,
	output reg R,
	output reg U,
	output reg D
);
 
	reg [31:0]clk_cnt;
	reg L_last,left;
	reg R_last,right;
	reg U_last,up;
	reg D_last,down;
	
	always@(posedge clk or posedge clr) begin
	   if (clr) begin
	       left <=0;
	       right <=0;
	       up <=0;
	       down <=0;
	   end
	   else if ((xkey[7:0])==8'b0001_1100)begin
	       left <= 1;
	       end
	   else if ((xkey[7:0])==8'b0010_0011)begin
	       right <= 1;
	       end
	   else if ((xkey[7:0])==8'b0001_1101)begin
	       up <= 1;
	       end
	   else if ((xkey[7:0])==8'b0001_1011)begin
	       down <= 1;
	       end
	   else begin
	       left <=0;
	       right <=0;
	       up <=0;
	       down <=0;     
	       end    
	end
	
	always@(posedge clk or posedge clr) begin
		if(clr) begin
			clk_cnt <= 0;
			L <= 0;
			U <= 0;
			D <= 0;
			R <= 0;
					
			L_last <= 0;
			U_last <= 0;
			D_last <= 0;
			R_last <= 0;					
		end	
		else begin
			if(clk_cnt ==187500) begin //5_000000
				clk_cnt <= 0;
				L_last <= left;
				R_last <= right;
				U_last <= up;
				D_last <= down;
					
				if(L_last == 0 && left == 1) 
					L <= 1;
				if(R_last == 0 && right == 1)
					R <= 1;
				if(U_last == 0 && up == 1)
					U <= 1;
				if(D_last == 0 && down == 1)
					D <= 1;
			end						
			else begin
				clk_cnt <= clk_cnt + 1;
				L <= 0;
				R <= 0;
				U <= 0;
				D <= 0;
			end
		end	
	end				
endmodule
