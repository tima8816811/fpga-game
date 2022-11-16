`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/28 21:57:15
// Design Name: 
// Module Name: vga_interface
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


module vga_interface(
input clk,clr,
output reg hsync_i,vsync_i,
output [3:0] r_i,g_i,b_i
);

reg[9:0]xsync_i,ysync_i;
reg [3:0] r_r,g_r,b_r;
wire vidon;

always @(posedge clk) 
    begin
    if (clr) begin  
      xsync_i <= 10'd0;
    end
    else if (xsync_i == 10'd799) begin
      xsync_i <= 10'd0;
    end
    else begin
      xsync_i <= xsync_i + 1;
    end
  end

always @(posedge clk ) 
  begin
    if (clr) begin
      ysync_i <= 10'd0;
    end
    else if (ysync_i == 10'd524) begin
      ysync_i <= 10'd0;
    end
    else if (xsync_i == 10'd799) begin
      ysync_i <= ysync_i + 1;
    end
  end

  always @(posedge clk  ) begin
    if (clr) begin
      hsync_i <= 1'b0;
    end
    else if (xsync_i == 799) begin
      hsync_i <=1'b0;
    end
    else if (xsync_i == 95) begin
      hsync_i <= 1'b1;
    end
  end

always @(posedge clk ) begin
    if (clr) begin
      vsync_i <= 1'b0;
    end
    else if (ysync_i == 0) begin
      vsync_i <=1'b0;
    end
    else if (ysync_i == 1) begin
      vsync_i <= 1'b1;
    end
  end

assign vidon = (xsync_i > 143) && (xsync_i < 784) && (ysync_i > 34) && (ysync_i < 515);

always @ (posedge clk)
		begin

			if (ysync_i < 135)
				begin              
					r_r <= 4'h0;    
					b_r <= 4'h0;
					g_r <= 4'h0;
				end 		
				
			else if (ysync_i >= 135 && ysync_i < 138)
				begin 
					if (xsync_i < 355)
						begin 
							r_r <= 4'h0;    
							b_r <= 4'h0;
							g_r <= 4'h0;
						end  
					else if (xsync_i >= 355 && xsync_i < 381)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end
					else if (xsync_i >= 401 && xsync_i < 427)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 	
					else if (xsync_i >= 447 && xsync_i < 473)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 
					else if (xsync_i >= 493 && xsync_i < 519)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 	
				    else 
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end	
					end  
					
		      else if (ysync_i >= 138 && ysync_i < 152)
				begin 
					if (xsync_i < 355)
						begin 
							r_r <= 4'h0;    
							b_r <= 4'h0;
							g_r <= 4'h0;
						end  
					else if (xsync_i >= 355 && xsync_i < 358)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 
					else if (xsync_i >= 401 && xsync_i < 404)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end		
				    else if (xsync_i >= 424 && xsync_i < 427)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 
					else if (xsync_i >= 447 && xsync_i < 450)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end	 
					else if (xsync_i >= 493 && xsync_i < 496)
						begin 
							r_r <= 4'hf;  
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 	
					else if (xsync_i >= 516 && xsync_i < 519)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 	
				    else 
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end	
					end
					
			 else if (ysync_i >= 152 && ysync_i < 155)
				begin 
					if (xsync_i < 355)
						begin 
							r_r <= 4'h0;    
							b_r <= 4'h0;
							g_r <= 4'h0;
						end  
					else if (xsync_i >= 355 && xsync_i < 381)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end
					else if (xsync_i >= 401 && xsync_i < 427)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end
					else if (xsync_i >= 447 && xsync_i < 450)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end
					else if (xsync_i >= 461 && xsync_i < 473)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end	
					else if (xsync_i >= 493 && xsync_i < 519)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 	
					else 
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end
					end
			  
			  else if (ysync_i >= 155 && ysync_i < 180)
				begin 
					if (xsync_i < 355)
						begin 
							r_r <= 4'h0;    
							b_r <= 4'h0;
							g_r <= 4'h0;
						end  
					else if (xsync_i >= 355 && xsync_i < 358)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 
					else if (xsync_i >= 401 && xsync_i < 404)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end	
					else if (xsync_i >= 447 && xsync_i < 450)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 
					else if (xsync_i >= 470 && xsync_i < 473)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 
					else if (xsync_i >= 493 && xsync_i < 496)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 	
					else if (xsync_i >= 516 && xsync_i < 519)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end	
					else 
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end	
					end
				else if (ysync_i >= 180 && ysync_i < 183)
				    begin
				        if(xsync_i >= 447 && xsync_i < 473)
				            begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 
						else begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end	
					end
					
					
			     else if (ysync_i >= 360 && ysync_i < 363)
				begin 
					if (xsync_i < 355)
						begin 
							r_r <= 4'h0;    
							b_r <= 4'h0;
							g_r <= 4'h0;
						end  
					else if (xsync_i >= 355 && xsync_i < 381)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end
					else if (xsync_i >= 401 && xsync_i < 427)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 	
					else if (xsync_i >= 447 && xsync_i < 473)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 
					else if (xsync_i >= 493 && xsync_i < 519)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 	
				    else 
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end	
					end  
		      else if (ysync_i >= 363 && ysync_i < 377)
				begin 
					if (xsync_i < 355)
						begin 
							r_r <= 4'h0;    
							b_r <= 4'h0;
							g_r <= 4'h0;
						end  
					else if (xsync_i >= 355 && xsync_i < 358)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 
					else if (xsync_i >= 401 && xsync_i < 404)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end		
				    else if (xsync_i >= 424 && xsync_i < 427)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 
					else if (xsync_i >= 447 && xsync_i < 450)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end	 
					else if (xsync_i >= 459 && xsync_i < 462)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end	
					else if (xsync_i >= 470 && xsync_i < 473)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end		
					else if (xsync_i >= 493 && xsync_i < 496)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 	
				    else 
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end	
					end
					
			 else if (ysync_i >= 377 && ysync_i < 380)
				begin 
					if (xsync_i < 355)
						begin 
							r_r <= 4'h0;    
							b_r <= 4'h0;
							g_r <= 4'h0;
						end  
					else if (xsync_i >= 355 && xsync_i < 358)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end
					else if (xsync_i >= 368 && xsync_i < 381)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end	
					else if (xsync_i >= 401 && xsync_i < 427)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end
					else if (xsync_i >= 447 && xsync_i < 450)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end
					else if (xsync_i >= 459 && xsync_i < 462)
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end	
					else if (xsync_i >= 470 && xsync_i < 473)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end	
					else if (xsync_i >= 493 && xsync_i < 519)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 	
					else 
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end
					end
			  
			  else if (ysync_i >= 380 && ysync_i < 405)
				begin 
					if (xsync_i < 355)
						begin 
							r_r <= 4'h0;    
							b_r <= 4'h0;
							g_r <= 4'h0;
						end  
					else if (xsync_i >= 355 && xsync_i < 358)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 
					else if (xsync_i >= 378 && xsync_i < 381)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 	
					else if (xsync_i >= 401 && xsync_i < 404)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end	
					else if (xsync_i >= 424 && xsync_i < 427)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end		
					else if (xsync_i >= 447 && xsync_i < 450)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end
					else if (xsync_i >= 459 && xsync_i < 462)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end	
					else if (xsync_i >= 470 && xsync_i < 473)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end				
					else if (xsync_i >= 493 && xsync_i < 496)
						begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 
					else 
						begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end	
					end
					
				else if (ysync_i >= 405 && ysync_i < 408)
				    begin
				        if(xsync_i >= 355 && xsync_i < 383)
				            begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end 
						else if(xsync_i >= 493 && xsync_i < 519)
				            begin 
							r_r <= 4'hf;   
							b_r <= 4'hf;
							g_r <= 4'hf;
						end
						else begin 
							r_r <= 4'h0;   
							b_r <= 4'h0;
							g_r <= 4'h0;
						end	
					end  
		end          
         
    assign r_i = (xsync_i > 144 && xsync_i <= 783 && ysync_i > 35 && ysync_i <= 514) ? r_r : 4'h0;
	assign b_i = (xsync_i > 144 && xsync_i <= 783 && ysync_i > 35 && ysync_i <= 514) ? b_r : 4'h0;
	assign g_i = (xsync_i > 144 && xsync_i <= 783 && ysync_i > 35 && ysync_i <= 514) ? g_r : 4'h0;
  
endmodule

