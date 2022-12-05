`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/06 22:04:48
// Design Name: 
// Module Name: clk_unit
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


module clk_unit(
	clk,
	rst,
	clk_n
	);
	input clk, rst;
	output clk_n;

    reg clk_n;
    reg clk_tmp;
    always @(posedge clk_tmp or posedge rst) begin
       if (rst) begin  
        clk_n <= 0;
       end
      else begin
        clk_n <= ~clk_n;
      end
    end
    
    always @(posedge clk or posedge rst)
    begin
        if (rst)
            clk_tmp <= 0;
        else
            clk_tmp <= ~clk_tmp;
    end
endmodule
