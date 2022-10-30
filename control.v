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

output reg move,store,start,judge,win,
output reg hold,gen_random,shift,move_down,remove_1,remove_2,stop,moveT,isdie,
output reg auto_down,
output reg blink,
output reg [3:0] vga_control
    );

reg [4:0] state, next_state;

parameter       S_keep   = 4'd0,
                S_move   = 4'd1,
                S_store  = 4'd2,
                S_judge  = 4'd3,
                S_win    = 4'd4,
                S_start  = 4'd5,
                
                S_random = 4'd6,
                S_keepT  = 4'd7,
                S_moveT  = 4'd8,
                S_down   = 4'd9,
                S_renew1 = 4'd10,
                S_renew2 = 4'd11,
                S_remove = 4'd12,
                S_stop   = 4'd13,
                S_lose   = 4'd14;

parameter time_val = 26'd5;//50000001;
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
        else if (vga_control==1)
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
        case (state)
            S_start:
            begin
                vga_control=3'd1;
                if(R) next_state = S_keep;
                else if (L) next_state = S_random;
                else next_state = S_start;
            end
            S_keep:
            begin
                vga_control=3'd2;
                if((L)||(U)||(R)||(D))
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
                if (!(judge_able))
                next_state = S_keep;
                else if (judge_able)
                next_state = S_start; 
             end
            S_win:
            begin
                win=1;
            end
            
            
        S_random:
        begin
            gen_random = 1;
            next_state = S_keepT;
            vga_control=3'd3;
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
                next_state = S_start;
            else
                next_state = S_random;
        end         
        endcase          
    end

                        
endmodule                