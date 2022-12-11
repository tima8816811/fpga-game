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

  always @(posedge clk ) begin
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
			if (ysync_i < 35)
		      begin
		          r_r <= 4'h0;   
			  b_r <= 4'h0;
			  g_r <= 4'h0;
		      end
		 else if (ysync_i >= 35 && ysync_i < 90)
		 	begin
		        	if (xsync_i < 220)
			  		begin 
						r_r <= 4'h0;    
						b_r <= 4'h0;
						g_r <= 4'h0;
					end  
		          	else if(xsync_i >= 220 && xsync_i < 230)
		                	begin
		                  		r_r <= 4'hf;   
						b_r <= 4'hf;
			  	        	g_r <= 4'hf;
					end
			   	else if(xsync_i >= 700 && xsync_i < 710)
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
			 
			 
		   else if (ysync_i >= 90 && ysync_i < 100)
			begin 
			    	if (xsync_i < 220)
					begin 
						r_r <= 4'h0;    
						b_r <= 4'h0;
						g_r <= 4'h0;
					end  
                   		else if(xsync_i >= 220 && xsync_i < 230)
		              	   begin
		                  	r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if (xsync_i >= 310 && xsync_i < 360)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 390 && xsync_i < 440)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 470 && xsync_i < 520)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 	
				else if (xsync_i >= 550 && xsync_i < 600)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 	
				else if(xsync_i >= 700 && xsync_i < 710)
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
					
		else if (ysync_i >= 100 && ysync_i < 130)
			begin 
				 if (xsync_i < 220)
					begin 
						r_r <= 4'h0;    
						b_r <= 4'h0;
						g_r <= 4'h0;
					end  
				else if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					  	b_r <= 4'hf;
					  	g_r <= 4'hf;
					end
				else if (xsync_i >= 310 && xsync_i < 320)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if (xsync_i >= 390 && xsync_i < 400)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 430 && xsync_i < 440)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end				
				else if (xsync_i >= 470 && xsync_i < 480)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if (xsync_i >= 550 && xsync_i < 560)
					begin 
						r_r <= 4'hf;  
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 	
				else if (xsync_i >= 590 && xsync_i < 600)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 	
				else if(xsync_i >= 700 && xsync_i < 710)
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
					
		else if (ysync_i >= 130 && ysync_i < 140)
			begin 
				if (xsync_i < 220)
					begin 
						r_r <= 4'h0;    
						b_r <= 4'h0;
						g_r <= 4'h0;
					end  
				else if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if (xsync_i >= 310 && xsync_i < 360)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 390 && xsync_i < 440)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 470 && xsync_i < 480)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end	
				else if (xsync_i >= 490 && xsync_i < 520)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end	
				else if (xsync_i >= 550 && xsync_i < 600)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if(xsync_i >= 700 && xsync_i < 710)
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
			  
		else if (ysync_i >= 140 && ysync_i < 170)
			begin 
				if (xsync_i < 220)
					begin 
						r_r <= 4'h0;    
						b_r <= 4'h0;
						g_r <= 4'h0;
					end  
				else if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if (xsync_i >= 310 && xsync_i < 320)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if (xsync_i >= 390 && xsync_i < 400)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end	
				else if (xsync_i >= 470 && xsync_i < 480)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if (xsync_i >= 510 && xsync_i < 520)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if (xsync_i >= 550 && xsync_i < 560)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 	
				else if (xsync_i >= 590 && xsync_i < 600)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end	
				else if(xsync_i >= 700 && xsync_i < 710)
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

		else if (ysync_i >= 170 && ysync_i < 180)
			begin
				if(xsync_i >= 220 && xsync_i < 230)
		                   	begin
		                     r_r <= 4'hf;   
					        b_r <= 4'hf;
					        g_r <= 4'hf;
					end
				else if (xsync_i >= 310 && xsync_i < 320)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if (xsync_i >= 390 && xsync_i < 400)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
			    else if(xsync_i >= 470 && xsync_i < 520)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 	
				else if (xsync_i >= 550 && xsync_i < 560)
					begin 
						r_r <= 4'hf;  
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 	
				else if (xsync_i >= 590 && xsync_i < 600)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 	
				 
				else if(xsync_i >= 700 && xsync_i < 710)
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
				
		else if (ysync_i >= 180 && ysync_i < 210)
			begin
				if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 700 && xsync_i < 710)
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
					
					
		else if (ysync_i >= 210 && ysync_i < 220)
			begin 
				if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if (xsync_i >= 310 && xsync_i < 360)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 390 && xsync_i < 440)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 	
				else if (xsync_i >= 470 && xsync_i < 520)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if (xsync_i >= 550 && xsync_i < 600)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if(xsync_i >= 700 && xsync_i < 710)
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
  
		else if (ysync_i >= 220 && ysync_i < 250)
			begin 
				if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if (xsync_i >= 310 && xsync_i < 320)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if (xsync_i >= 390 && xsync_i < 400)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end		
				else if (xsync_i >= 430 && xsync_i < 440)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if (xsync_i >= 470 && xsync_i < 480)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end	 
				else if (xsync_i >= 490 && xsync_i < 500)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end	
				else if (xsync_i >= 510 && xsync_i < 520)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end		
				else if (xsync_i >= 550 && xsync_i < 560)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if(xsync_i >= 700 && xsync_i < 710)
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
					
		else if (ysync_i >= 250 && ysync_i < 260)
			begin 
				if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if (xsync_i >= 310 && xsync_i < 320)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 330 && xsync_i < 360)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end	
				else if (xsync_i >= 390 && xsync_i < 440)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 470 && xsync_i < 480)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 490 && xsync_i < 500)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end	
				else if (xsync_i >= 510 && xsync_i < 520)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end	
				else if (xsync_i >= 550 && xsync_i < 600)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 	
				else if(xsync_i >= 700 && xsync_i < 710)
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
			  
		else if (ysync_i >= 260 && ysync_i < 290)
			begin 
				if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if (xsync_i >= 310 && xsync_i < 320)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if (xsync_i >= 350 && xsync_i < 360)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 	
				else if (xsync_i >= 390 && xsync_i < 400)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end	
				else if (xsync_i >= 430 && xsync_i < 440)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end		
				else if (xsync_i >= 470 && xsync_i < 480)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 490 && xsync_i < 500)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end	
				else if (xsync_i >= 510 && xsync_i < 520)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end				
				else if (xsync_i >= 550 && xsync_i < 560)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if(xsync_i >= 700 && xsync_i < 710)
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
					
		else if (ysync_i >= 290 && ysync_i < 300)
			begin
				if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if(xsync_i >= 310 && xsync_i < 360)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if(xsync_i >= 390 && xsync_i < 400)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 430 && xsync_i < 440)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 470 && xsync_i < 480)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 490 && xsync_i < 500)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 510 && xsync_i < 520)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 550 && xsync_i < 600)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 700 && xsync_i < 710)
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
		
		else if (ysync_i >= 300 && ysync_i < 330)
			begin
			      if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				   else if(xsync_i >= 700 && xsync_i < 710)
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
					
		else if (ysync_i >= 330 && ysync_i < 335)
			begin
			     if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if(xsync_i >= 360 && xsync_i < 380)
		              		begin
		                  	r_r <= 4'hf;   
					      	b_r <= 4'h0;
					      	g_r <= 4'h0;
					end
				else if(xsync_i >= 390 && xsync_i < 410)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if(xsync_i >= 420 && xsync_i < 440)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 450 && xsync_i < 470)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 700 && xsync_i < 710)
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
		
		else if (ysync_i >= 335 && ysync_i < 350)
			begin
			      if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if(xsync_i >= 360 && xsync_i < 365)
		              		begin
		                  	r_r <= 4'hf;   
					      	b_r <= 4'h0;
					      	g_r <= 4'h0;
					end
				else if(xsync_i >= 368 && xsync_i < 372)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'h0;
						g_r <= 4'h0;
					end 
				else if(xsync_i >= 375 && xsync_i < 380)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'h0;
						g_r <= 4'h0;
					end
				else if(xsync_i >= 390 && xsync_i < 395)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 405 && xsync_i < 410)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 435 && xsync_i < 440)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 450 && xsync_i < 455)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 700 && xsync_i < 710)
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
		
				else if (ysync_i >= 350 && ysync_i < 355)
			begin
			      if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if(xsync_i >= 360 && xsync_i < 365)
		              		begin
		                  	r_r <= 4'hf;   
					      	b_r <= 4'h0;
					      	g_r <= 4'h0;
					end
				else if(xsync_i >= 368 && xsync_i < 372)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'h0;
						g_r <= 4'h0;
					end 
				else if(xsync_i >= 375 && xsync_i < 380)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'h0;
						g_r <= 4'h0;
					end
				else if(xsync_i >= 390 && xsync_i < 410)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 420 && xsync_i < 440)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 450 && xsync_i < 470)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 700 && xsync_i < 710)
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
		
				else if (ysync_i >= 355 && ysync_i < 370)
			begin
			      if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if(xsync_i >= 360 && xsync_i < 365)
		              		begin
		                  	r_r <= 4'hf;   
					      	b_r <= 4'h0;
					      	g_r <= 4'h0;
					end
				else if(xsync_i >= 368 && xsync_i < 372)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'h0;
						g_r <= 4'h0;
					end 
				else if(xsync_i >= 375 && xsync_i < 380)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'h0;
						g_r <= 4'h0;
					end
				else if(xsync_i >= 390 && xsync_i < 395)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 405 && xsync_i < 410)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 420 && xsync_i < 425)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 450 && xsync_i < 455)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 700 && xsync_i < 710)
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
		
				else if (ysync_i >= 370 && ysync_i < 375)
			begin
			      if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if(xsync_i >= 360 && xsync_i < 365)
		              		begin
		                  	r_r <= 4'hf;   
					      	b_r <= 4'h0;
					      	g_r <= 4'h0;
					end
				else if(xsync_i >= 368 && xsync_i < 372)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'h0;
						g_r <= 4'h0;
					end 
				else if(xsync_i >= 375 && xsync_i < 380)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'h0;
						g_r <= 4'h0;
					end
				else if(xsync_i >= 390 && xsync_i < 395)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 405 && xsync_i < 410)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 420 && xsync_i < 440)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 450 && xsync_i < 470)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 700 && xsync_i < 710)
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
				else if (ysync_i >= 375 && ysync_i < 390)
			begin
			      if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				   else if(xsync_i >= 700 && xsync_i < 710)
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
		
				else if (ysync_i >= 390 && ysync_i < 395)
			begin
			      if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if(xsync_i >= 360 && xsync_i < 380)
		              		begin
		                  	r_r <= 4'h0;   
					      	b_r <= 4'hf;
					      	g_r <= 4'h0;
					end
				else if(xsync_i >= 390 && xsync_i < 410)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if(xsync_i >= 420 && xsync_i < 440)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 450 && xsync_i < 470)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 480 && xsync_i < 500)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 700 && xsync_i < 710)
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
				
				else if (ysync_i >= 395 && ysync_i < 410)
			begin
			      if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if(xsync_i >= 368 && xsync_i < 372)
				        begin 
						r_r <= 4'h0;   
						b_r <= 4'hf;
						g_r <= 4'h0;
					end 
				else if(xsync_i >= 390 && xsync_i < 395)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 420 && xsync_i < 425)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 435 && xsync_i < 440)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 458 && xsync_i < 462)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 480 && xsync_i < 485)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 700 && xsync_i < 710)
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
				
		else if (ysync_i >= 410 && ysync_i < 415)
			begin
			      if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if(xsync_i >= 368 && xsync_i < 372)
				        begin 
						r_r <= 4'h0;   
						b_r <= 4'hf;
						g_r <= 4'h0;
					end 
				else if(xsync_i >= 390 && xsync_i < 410)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 420 && xsync_i < 440)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 458 && xsync_i < 462)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 480 && xsync_i < 500)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 700 && xsync_i < 710)
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
		
		else if (ysync_i >= 415 && ysync_i < 430)
			begin
			      if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if(xsync_i >= 368 && xsync_i < 372)
				        begin 
						r_r <= 4'h0;   
						b_r <= 4'hf;
						g_r <= 4'h0;
					end 
				else if(xsync_i >= 390 && xsync_i < 395)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 420 && xsync_i < 425)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 430 && xsync_i < 435)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 458 && xsync_i < 462)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 495 && xsync_i < 500)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 700 && xsync_i < 710)
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
		
		else if (ysync_i >= 430 && ysync_i < 435)
			begin
			      if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if(xsync_i >= 368 && xsync_i < 372)
				        begin 
						r_r <= 4'h0;   
						b_r <= 4'hf;
						g_r <= 4'h0;
					end 
				else if(xsync_i >= 390 && xsync_i < 410)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 420 && xsync_i < 425)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 430 && xsync_i < 435)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 450 && xsync_i < 470)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 480 && xsync_i < 500)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 700 && xsync_i < 710)
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
		
		else if (ysync_i >= 435 && ysync_i < 450)
			begin
			      if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				   else if(xsync_i >= 700 && xsync_i < 710)
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
		else if (ysync_i >= 450 && ysync_i < 455)
			begin
			      if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if(xsync_i >= 360 && xsync_i < 380)
				        begin 
						r_r <= 4'h0;   
						b_r <= 4'h0;
						g_r <= 4'hf;
					end 
				else if(xsync_i >= 390 && xsync_i < 402)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 405 && xsync_i < 410)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 420 && xsync_i < 440)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 450 && xsync_i < 455)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 465 && xsync_i < 470)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 480 && xsync_i < 500)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 700 && xsync_i < 710)
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
		
		
				
		else if (ysync_i >= 455 && ysync_i < 465)
			begin
			      if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if(xsync_i >= 360 && xsync_i < 365)
				        begin 
						r_r <= 4'h0;   
						b_r <= 4'h0;
						g_r <= 4'hf;
					end 
				else if(xsync_i >= 390 && xsync_i < 395)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 398 && xsync_i < 402)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 405 && xsync_i < 410)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 420 && xsync_i < 425)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 435 && xsync_i < 440)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 450 && xsync_i < 455)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 465 && xsync_i < 470)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 480 && xsync_i < 485)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 700 && xsync_i < 710)
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
		
		else if (ysync_i >= 465 && ysync_i < 470)
			begin
			      if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if(xsync_i >= 360 && xsync_i < 365)
				        begin 
						r_r <= 4'h0;   
						b_r <= 4'h0;
						g_r <= 4'hf;
					end 
				else if(xsync_i >= 390 && xsync_i < 395)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 398 && xsync_i < 402)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 405 && xsync_i < 410)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 420 && xsync_i < 425)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 435 && xsync_i < 440)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 450 && xsync_i < 470)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 480 && xsync_i < 485)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 700 && xsync_i < 710)
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
		
		else if (ysync_i >= 470 && ysync_i < 475)
			begin
			      if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if(xsync_i >= 360 && xsync_i < 380)
				        begin 
						r_r <= 4'h0;   
						b_r <= 4'h0;
						g_r <= 4'hf;
					end 
				else if(xsync_i >= 390 && xsync_i < 395)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 398 && xsync_i < 402)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 405 && xsync_i < 410)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 420 && xsync_i < 440)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 450 && xsync_i < 455)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 480 && xsync_i < 500)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 700 && xsync_i < 710)
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
		
		else if (ysync_i >= 475 && ysync_i < 480)
			begin
			      if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if(xsync_i >= 375 && xsync_i < 380)
				        begin 
						r_r <= 4'h0;   
						b_r <= 4'h0;
						g_r <= 4'hf;
					end 
				else if(xsync_i >= 390 && xsync_i < 395)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 398 && xsync_i < 402)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 405 && xsync_i < 410)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 420 && xsync_i < 425)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 435 && xsync_i < 440)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 450 && xsync_i < 470)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 480 && xsync_i < 485)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 700 && xsync_i < 710)
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
		
		else if (ysync_i >= 480 && ysync_i < 490)
			begin
			      if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if(xsync_i >= 375 && xsync_i < 380)
				        begin 
						r_r <= 4'h0;   
						b_r <= 4'h0;
						g_r <= 4'hf;
					end 
				else if(xsync_i >= 390 && xsync_i < 395)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 398 && xsync_i < 402)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 405 && xsync_i < 410)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 420 && xsync_i < 425)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 435 && xsync_i < 440)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 450 && xsync_i < 455)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 465 && xsync_i < 470)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 480 && xsync_i < 485)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 700 && xsync_i < 710)
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
		
		else if (ysync_i >= 490 && ysync_i < 495)
			begin
			      if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if(xsync_i >= 360 && xsync_i < 380)
				        begin 
						r_r <= 4'h0;   
						b_r <= 4'h0;
						g_r <= 4'hf;
					end 
				else if(xsync_i >= 390 && xsync_i < 395)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 398 && xsync_i < 410)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 420 && xsync_i < 425)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 435 && xsync_i < 440)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 450 && xsync_i < 455)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 465 && xsync_i < 470)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 480 && xsync_i < 500)
				        begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if(xsync_i >= 700 && xsync_i < 710)
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
				
		else if (ysync_i >= 490 && ysync_i < 514)
			begin
				if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if(xsync_i >= 700 && xsync_i < 710)
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
		end   
         
    assign r_i = (xsync_i > 144 && xsync_i <= 783 && ysync_i > 35 && ysync_i <= 514) ? r_r : 4'h0;
	assign b_i = (xsync_i > 144 && xsync_i <= 783 && ysync_i > 35 && ysync_i <= 514) ? b_r : 4'h0;
	assign g_i = (xsync_i > 144 && xsync_i <= 783 && ysync_i > 35 && ysync_i <= 514) ? g_r : 4'h0;
  
endmodule

