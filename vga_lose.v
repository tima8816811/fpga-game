`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/10 23:19:36
// Design Name: 
// Module Name: vga_lose
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


module vga_lose(
input clk,clr,

output reg hsync_i,vsync_i,
output [3:0] r,g,b
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
		if (ysync_i < 35)
		      begin
		          r_r <= 4'h0;   
			  b_r <= 4'h0;
			  g_r <= 4'h0;
		      end
		 else if (ysync_i >= 35 && ysync_i < 170)
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
			 
			 
		   else if (ysync_i >= 170 && ysync_i < 180)
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
				else if (xsync_i >= 360 && xsync_i < 370)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 400 && xsync_i < 410)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 440 && xsync_i < 490)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 	
				else if (xsync_i >= 520 && xsync_i < 530)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 560 && xsync_i < 570)
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
				else if (xsync_i >= 360 && xsync_i < 370)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if (xsync_i >= 400 && xsync_i < 410)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 440 && xsync_i < 450)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end				
				else if (xsync_i >= 480 && xsync_i < 490)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if (xsync_i >= 520 && xsync_i < 530)
					begin 
						r_r <= 4'hf;  
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 	
				else if (xsync_i >= 560 && xsync_i < 570)
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
				else if (xsync_i >= 360 && xsync_i < 410)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 440 && xsync_i < 450)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 480 && xsync_i < 490)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end	
				else if (xsync_i >= 520 && xsync_i < 530)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end	
				else if (xsync_i >= 560 && xsync_i < 570)
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
				else if (xsync_i >= 380 && xsync_i < 390)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if (xsync_i >= 440 && xsync_i < 450)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end	
				else if (xsync_i >= 480 && xsync_i < 490)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if (xsync_i >= 520 && xsync_i < 530)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if (xsync_i >= 560 && xsync_i < 570)
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
				else if (xsync_i >= 380 && xsync_i < 390)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if (xsync_i >= 440 && xsync_i < 490)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
			    else if(xsync_i >= 520 && xsync_i < 570)
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
				else if (xsync_i >= 320 && xsync_i < 330)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 400 && xsync_i < 450)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 	
				else if (xsync_i >= 480 && xsync_i < 530)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if (xsync_i >= 560 && xsync_i < 610)
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
				else if (xsync_i >= 320 && xsync_i < 330)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if (xsync_i >= 400 && xsync_i < 410)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end		
				else if (xsync_i >= 440 && xsync_i < 450)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end 
				else if (xsync_i >= 480 && xsync_i < 490)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end	 
				else if (xsync_i >= 560 && xsync_i < 570)
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
					
		else if (ysync_i >= 330 && ysync_i < 340)
			begin 
				if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if (xsync_i >= 320 && xsync_i < 330)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 400 && xsync_i < 410)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end	
				else if (xsync_i >= 440 && xsync_i < 450)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 480 && xsync_i < 530)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end	
				else if (xsync_i >= 560 && xsync_i < 610)
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
		
		else if (ysync_i >= 340 && ysync_i < 370)
			begin 
				if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if (xsync_i >= 320 && xsync_i < 330)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 400 && xsync_i < 410)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end	
				else if (xsync_i >= 440 && xsync_i < 450)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 520 && xsync_i < 530)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end	
				else if (xsync_i >= 560 && xsync_i < 570)
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
		
		else if (ysync_i >= 370 && ysync_i < 380)
			begin 
				if(xsync_i >= 220 && xsync_i < 230)
		              		begin
		                  		r_r <= 4'hf;   
					      	b_r <= 4'hf;
					      	g_r <= 4'hf;
					end
				else if (xsync_i >= 320 && xsync_i < 370)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 400 && xsync_i < 450)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end	
				else if (xsync_i >= 480 && xsync_i < 530)
					begin 
						r_r <= 4'hf;   
						b_r <= 4'hf;
						g_r <= 4'hf;
					end
				else if (xsync_i >= 560 && xsync_i < 610)
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
		else if (ysync_i >= 380 && ysync_i < 514)
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
         
	assign r = (xsync_i > 144 && xsync_i <= 783 && ysync_i > 35 && ysync_i <= 514) ? r_r : 4'h0;
	assign b = (xsync_i > 144 && xsync_i <= 783 && ysync_i > 35 && ysync_i <= 514) ? b_r : 4'h0;
	assign g = (xsync_i > 144 && xsync_i <= 783 && ysync_i > 35 && ysync_i <= 514) ? g_r : 4'h0;
  
endmodule
