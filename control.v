`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/23 22:15:16
// Design Name: 
// Module Name: control
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

module control(
input clk,clr,U,D,R,L,
input move_able,judge_able,

input shift_finish,
input remove_2_finish,
input down_comp,
input move_comp,
input die,

input hit_wall,hit_body,

output reg move,store,start,judge,win,
output reg hold,gen_random,shift,move_down,remove_1,remove_2,stop,moveT,isdie,
output reg auto_down,
output reg blink,
output reg [3:0] vga_control,

output reg s_start,s_play,s_die
);

reg [4:0] state, next_state;

parameter       S_keep   = 5'd0,
                S_move   = 5'd1,
                S_store  = 5'd2,
                S_judge  = 5'd3,
                S_win    = 5'd4,
                S_start  = 5'd5,
                
                S_random = 5'd6,
                S_keepT  = 5'd7,
                S_moveT  = 5'd8,
                S_down   = 5'd9,
                S_renew1 = 5'd10,
                S_renew2 = 5'd11,
                S_remove = 5'd12,
                S_stop   = 5'd13,
                S_lose   = 5'd14,
                
                S_restart = 5'd15,
                S_start_s = 5'd16,
                S_play =5'd17,
                S_die = 5'd18,
                
                S_lose2 = 5'd21,
                S_win_i = 5'd19,
                S_lose_i = 5'd20;

parameter time_val = 26'd50000001;//50000001;
reg [27:0] time_cnt,counter;

always @ (posedge clk or posedge clr)
    begin
        if (clr)
            auto_down <= 0;
        else if (time_cnt == time_val)
            auto_down <= 1;
        else 
            auto_down <= 0;
    end

always @ (posedge clk or posedge clr)
    begin
        if (clr)
            time_cnt <= 0;
        else if (hold == 0 && time_cnt < time_val)
            time_cnt <= time_cnt + 1;
        else if (move_down == 1)
            time_cnt <= 0;
        else begin
            time_cnt <= time_cnt;
        end
    end

always @ (posedge clk or posedge clr)
    begin
        if (clr) begin
            counter <= 0;
            blink <= 0; end     
        else if (counter == time_val) begin
            counter <= 0;
            blink = ~blink; end            
        else if (vga_control)
            counter <= counter + 1;        
        else begin
            counter <= counter;
            blink = blink;
        end
    end
                           
always @(posedge clk or posedge clr)
    begin
        if (clr)
            state <= S_start;
        else
            state <= next_state;
    end

 always @ (*)
    begin
        next_state = S_start;
        store=0;
        move=0;
        start=1;
        win=0;
        judge=0;
        vga_control=3'd0;
        
        hold = 1;
        gen_random = 0;
        shift = 0;
        move_down = 0;
        remove_1 = 0;
        remove_2 = 0;
        stop = 0;
        moveT = 0;
        isdie = 0;
        
        s_start=0;
        s_play=0;
        s_die=0;
        case (state)
            S_start:
            begin
                vga_control=3'd1;
                if(R) next_state = S_keep;
                else if (L) next_state = S_random;
                else if (D) next_state = S_start_s;
                else next_state = S_start;
            end
            S_keep:
            begin
                vga_control=3'd2;
                if ((judge_able)==1)
                next_state = S_win; 
                else if((L)||(U)||(R)||(D))
                    begin
                        next_state = S_move;
                    end               
                else next_state = S_keep;
            end
            S_move:
            begin
                move=1;
                if (move_able)
                next_state = S_store;
                else   
                next_state = S_judge;
            end
            S_store:
            begin
                vga_control=3'd2;
                store=1;
                next_state = S_judge;
            end   
            S_judge:
            begin
                vga_control=3'd2;
                judge=1;
                if ((judge_able)==0)
                next_state = S_keep;
                else if ((judge_able)==1)
                next_state = S_lose2; 
             end
        S_win:
            begin
                vga_control=3'd5;
                if (counter == time_val)
                next_state = S_win_i;
                else  next_state = S_win;
            end    
            
        S_random:
        begin
            gen_random = 1;
            next_state = S_keepT;           
        end
        S_keepT:
        begin
            hold = 0;
            vga_control=3'd3;
            if (time_cnt == time_val) 
            begin
                next_state = S_down;
            end
            else if (D)
            begin
               next_state = S_down;
            end
            else if (L||R||U)
            begin
                next_state = S_moveT;
            end
            else
                next_state = S_keepT;
        end
        S_moveT:    
        begin
            moveT = 1;
            vga_control=3'd3;
            if (move_comp)
                next_state = S_renew1;
            else
                next_state = S_keepT;
        end
        S_renew1:
        begin
            shift = 1;
            next_state = S_keepT;
            vga_control=3'd3;
        end
        S_down:
        begin
            move_down = 1;
            vga_control=3'd3;
            if (down_comp)
                next_state = S_renew1;
            else
                next_state = S_renew2;
        end
        S_renew2:
        begin
            remove_1 = 1;
            next_state = S_remove;
            vga_control=3'd3;
        end
        S_remove:
        begin
            remove_2 = 1;
            vga_control=3'd3;
            if (remove_2_finish)
                next_state = S_stop;
            else
                next_state = S_remove;
        end
        S_stop:
        begin
            isdie = 1;
            vga_control=3'd3;
            if (die == 1)
                next_state = S_lose2;
            else
                next_state = S_random;
        end        
        
		S_start_s:begin
		     vga_control=3'd4;
		     s_start=1'd1;
                next_state <= S_play;
				end	  
        S_play:begin
                vga_control=3'd4;
                s_play=1'd1;
					if((hit_wall) || (hit_body))
					   next_state <= S_die;
					else
					   next_state <= S_play;
				end
		S_die:begin
		            vga_control=3'd4;  
		            s_die=1'd1;     
				    next_state  <= S_lose2;
						end	
		S_win_i:begin
		          vga_control=3'd5;   
		          if((L)||(U)||(R)||(D))
                    begin
                        next_state = S_start;
                    end               
                else next_state = S_win_i;             
		  end					
		S_lose2:begin
		          vga_control=3'd6;
		          if (counter == time_val)
		              next_state = S_lose_i;
		          else     
		              next_state = S_lose2;
		  end
		S_lose_i:begin
		          vga_control=3'd6; 
		          if((L)||(U)||(R)||(D))
                    begin
                        next_state = S_start;
                    end               
                else next_state = S_lose_i;
		  end  
        endcase          
    end

                        
endmodule                
