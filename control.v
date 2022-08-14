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
input move_able,
output reg  [3:0] code,
output reg move,store,start
    );

reg [3:0] state, next_state;

parameter       S_keep   = 4'd0,
                S_move   = 4'd1,
                S_store  = 4'd2;
                
always @(posedge clk or posedge clr)
    begin
        if (clr)
            state <= S_keep;
        else
            state <= next_state;
    end

 always @ (*)
    begin
        next_state = S_keep;
        store=0;
        move=0;
        start=1;
        case (state)
            S_keep:
            begin
                if((L)||(U)||(R)||(D))
                    begin
                        next_state = S_move;
                    end
            end
            S_move:
            begin
                move = 1;
            if (move_able)
                next_state = S_store ;
            else
                next_state = S_keep;
            end
            S_store:
            begin
                store=1;
                next_state = S_keep;
            end                
     endcase          
    end

always @ (posedge clk or posedge clr)
    begin
        if (clr) code<=0;
        else code<={R, L, D, U};
    end 
                        
endmodule                