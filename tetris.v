`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/15 21:50:26
// Design Name: 
// Module Name: tetris
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


module tetris(
    output  move_comp,shift_finish,down_comp,die,
    output     [239:0] M_OUT,
    output  [4:0] n,
    output [3:0] m,
    output  [6:0] BLOCK,
    output remove_2_finish,
    input clk,clr,moveT,move_down,isdie,shift,remove_1,remove_2,gen_random,stop,auto_down,
    input u,d,r,l
    );
    reg move_comp,shift_finish,down_comp,die,remove_2_finish;
    reg     [4:0] n;
    reg     [3:0] m;
    reg     [6:0] BLOCK;
    reg [2:0] RAN;
    reg [9:0] R [23:0];
    reg [6:0] NEW_BLOCK;
    reg [6:0] BLOCK_P;
    reg [4:0] remove_cnt;
    reg [3:0] REMOVE_2_S;
    reg [3:0] REMOVE_FINISH;
    reg [4:0] REMOVE_2_C;
    reg       SIG;
    
     parameter  A_1 = 7'b0001000,
                B_1 = 7'b0011000,
                B_2 = 7'b0010100,
                B_3 = 7'b0010010,
                B_4 = 7'b0010001,
                C_1 = 7'b0101000,
                C_2 = 7'b0100100,
                C_3 = 7'b0100010,
                C_4 = 7'b0100001,
                D_1 = 7'b0111000,
                D_2 = 7'b0110100,
                E_1 = 7'b1001000,
                E_2 = 7'b1000100,
                E_3 = 7'b1000010,
                E_4 = 7'b1000001,
                F_1 = 7'b1011000,
                F_2 = 7'b1010100,
                G_1 = 7'b1101000,
                G_2 = 7'b1100100;
    
    always @ (posedge clk or posedge clr)
    begin
        if (clr) 
            RAN<=0;
        else if (RAN==7) RAN<=1;
        else RAN<=RAN+1;
    end 
    // move_comp signal
    always @ (*)
    begin
        move_comp = 0;
        if (moveT)
        begin
            if (u)  //UP
            begin
                case (BLOCK)
                A_1: move_comp=0;
                B_1: if (m>=1)
                        begin if (!((R[n][m-1])|(R[n][m+1])|(R[n-1][m+1]))) move_comp=1; else move_comp=0;end
                B_2: if (n<=22)
                        begin if (!((R[n+1][m-1])|(R[n+1][m])|(R[n-1][m]))) move_comp=1; else move_comp=0;end
                B_3: if (m<=8)
                        begin if (!(R[n][m-1] | R[n][m+1] | R[n+1][m-1])) move_comp=1; else move_comp=0;      end   
                B_4:    begin if (!((R[n-1][m])|(R[n+1][m])|(R[n+1][m+1]))) move_comp=1; else move_comp=0;end
                C_1: if (m<=8)
                        begin if (!((R[n][m-1])|(R[n][m+1])|(R[n+1][m+1]))) move_comp=1; else move_comp=0;end
                C_2:    begin if (!((R[n-1][m])|(R[n-1][m+1])|(R[n-1][m]))) move_comp=1; else move_comp=0;end
                C_3: if (m>=1)
                        begin if (!((R[n-1][m-1])|(R[n][m-1])|(R[n][m+1]))) move_comp=1; else move_comp=0;end
                C_4: if (n<=22)
                        begin if (!((R[n-1][m])|(R[n+1][m-1])|(R[n+1][m]))) move_comp=1; else move_comp=0;end
                D_1: if ((m>=1)&(m<=7))
                        begin if (!((R[n][m-1])|(R[n][m+1])|(R[n][m+2]))) move_comp=1; else move_comp=0;end
                D_2: if (n<=21)
                        begin if (!((R[n-1][m])|(R[n+1][m])|(R[n+2][m]))) move_comp=1; else move_comp=0;end
                E_1: if (n<=22)
                        begin if (!(R[n+1][m])) move_comp=1; else move_comp=0;end
                E_2: if (m<=8)
                        begin if (!(R[n][m+1])) move_comp=1; else move_comp=0;end
                E_3:    begin if (!(R[n-1][m])) move_comp=1; else move_comp=0;end
                E_4: if (m>=1)
                        begin if (!(R[n][m-1])) move_comp=1; else move_comp=0;end
                F_1: if (m>=1)
                        begin if (!((R[n-1][m-1])|(R[n-1][m]))) move_comp=1; else move_comp=0;end
                F_2: if (n<=22)
                        begin if (!((R[n-1][m+1])|(R[n+1][m]))) move_comp=1; else move_comp=0;end
                G_1: if (m>=1)
                        begin if (!((R[n-1][m+1])|(R[n][m-1]))) move_comp=1; else move_comp=0;end
                G_2: if (n<=22)
                        begin if (!((R[n][m+1])|(R[n+1][m+1]))) move_comp=1; else move_comp=0;end
                default move_comp=0;
                endcase 
            end
            else if (l)  //LEFT
            begin
             //     move_comp<=0;
                case (BLOCK)
                A_1: if (m>=1) if (!((R[n+1][m-1])|(R[n][m-1]))) move_comp=1; else move_comp=0;
                B_1: if (m>=1) if (!((R[n-1][m-1])|(R[n][m-1])|(R[n+1][m-1]))) move_comp=1; else move_comp=0;
                B_2: if (m>=2) if (!((R[n][m-1])|(R[n-1][m]))) move_comp=1; else move_comp=0;
                B_3: if (m>=2) if (!((R[n-1][m-2])|(R[n][m-1])|(R[n+1][m-1]))) move_comp=1; else move_comp=0;
                B_4: if (m>=2) if (!((R[n][m-2])|(R[n+1][m-2]))) move_comp=1; else move_comp=0;
                C_1: if (m>=2) if (!((R[n-1][m-1])|(R[n][m-1])|(R[n+1][m-2]))) move_comp=1; else move_comp=0;
                C_2: if (m>=2) if (!((R[n][m-2])|(R[n+1][m]))) move_comp=1; else move_comp=0;
                C_3: if (m>=1) if (!((R[n-1][m-1])|(R[n][m-1])|(R[n+1][m-1]))) move_comp=1; else move_comp=0;
                C_4: if (m>=2) if (!((R[n-1][m-2])|(R[n][m-2]))) move_comp=1; else move_comp=0;
                D_1: if (m>=1) if (!((R[n-1][m-1])|(R[n][m-1])|(R[n+1][m-1])|(R[n+2][m-1]))) move_comp=1; else move_comp=0;
                D_2: if (m>=2) if (!(R[n][m-2])) move_comp=1; else move_comp=0;
                E_1: if (m>=2) if (!((R[n-1][m-1])|(R[n][m-2]))) move_comp=1; else move_comp=0;
                E_2: if (m>=2) if (!((R[n-1][m-1])|(R[n][m-2])|(R[n+1][m-1])))    move_comp=1; else move_comp=0;
                E_3: if (m>=2) if (!((R[n][m-2])|(R[n+1][m-1]))) move_comp=1; else   move_comp=0;
                E_4: if (m>=1) if (!((R[n-1][m-1])|(R[n][m-1])|(R[n+1][m-1])))    move_comp=1; else move_comp=0;
                F_1: if (m>=1) if (!((R[n-1][m])|(R[n][m-1])|(R[n+1][m-1])))  move_comp=1; else move_comp=0;
                F_2: if (m>=2) if (!((R[n-1][m-2])|(R[n][m-1]))) move_comp=1; else   move_comp=0;
                G_1: if (m>=1) if (!((R[n-1][m-1])|(R[n][m-1])|(R[n+1][m-1])))    move_comp=1; else move_comp=0;
                G_2: if (m>=2) if (!((R[n-1][m-1])|(R[n][m-2]))) move_comp=1; else   move_comp=0;
                default move_comp=0;
                endcase
            end
            else if (r)  //RIGHT
            begin
                //move_comp=1;   
                case (BLOCK)
                A_1: if (m<=7) if (!((R[n+1][m+2])|(R[n][m+2]))) move_comp=1; else   move_comp=0;
                B_1: if (m<=7) if (!((R[n+1][m+2])|(R[n][m+1])|(R[n-1][m+1])))    move_comp=1; else move_comp=0;
                B_2: if (m<=7) if (!((R[n][m+2])|(R[n+1][m+2]))) move_comp=1; else   move_comp<=0;
                B_3: if (m<=8) if (!((R[n-1][m+1])|(R[n][m+1])|(R[n+1][m+1])))    move_comp=1; else move_comp=0;
                B_4: if (m<=7) if (!((R[n][m+2])|(R[n+1][m]))) move_comp=1; else     move_comp=0;
                C_1: if (m<=8) if (!((R[n-1][m+1])|(R[n][m+1])|(R[n+1][m+1])))    move_comp=1; else move_comp=0;
                C_2: if (m<=7) if (!((R[n-1][m+2])|(R[n][m+2]))) move_comp=1; else   move_comp=0;
                C_3: if (m<=7) if (!((R[n-1][m+2])|(R[n][m+1])|(R[n+1][m+1])))    move_comp=1; else move_comp=0;
                C_4: if (m<=7) if (!((R[n-1][m])|(R[n][m+2]))) move_comp=1; else     move_comp=0;
                D_1: if (m<=8) if (!((R[n-1][m+1])|(R[n][m+1])|(R[n+1][m+1])|(R[n+2][m+1]))) move_comp=1; else move_comp=0;
                D_2: if (m<=6) if (!(R[n][m+3])) move_comp=1; else move_comp=0;
                E_1: if (m<=7) if (!((R[n-1][m+1])|(R[n][m+2]))) move_comp=1; else   move_comp=0;
                E_2: if (m<=8) if (!((R[n-1][m+1])|(R[n][m+1])|(R[n+1][m+1])))    move_comp=1; else move_comp=0;
                E_3: if (m<=7) if (!((R[n][m+2])|(R[n+1][m+1]))) move_comp=1; else   move_comp=0;
                E_4: if (m<=7) if (!((R[n-1][m+1])|(R[n][m+2])|(R[n+1][m+1])))    move_comp=1; else move_comp=0;
                F_1: if (m<=7) if (!((R[n-1][m+2])|(R[n][m+2])|(R[n+1][m+1])))    move_comp=1; else move_comp=0;
                F_2: if (m<=7) if (!((R[n-1][m+1])|(R[n][m+2]))) move_comp=1; else   move_comp=0;
                G_1: if (m<=7) if (!((R[n-1][m+1])|(R[n][m+2])|(R[n+1][m+2])))    move_comp=1; else move_comp=0;
                G_2: if (m<=7) if (!((R[n-1][m+2])|(R[n][m+1]))) move_comp=1; else   move_comp=0;
                default move_comp=0;
                endcase
            end
        end
        else
            move_comp = 0;
    end

    // M_OUT
    assign M_OUT = {R[23],R[22],R[21],R[20],R[19],R[18],R[17],R[16],R[15],R[14],R[13],R[12],R[11],R[10],R[9],R[8],R[7],R[6],R[5],R[4],R[3],R[2],R[1],R[0]};

    // R
    integer i,j;
    always @ (posedge clk or posedge clr)
    begin
        if (clr)
            begin
                for (i = 0; i < 24; i = i + 1) R[i] <= 0;
                REMOVE_FINISH<=0;
            end
        else if (remove_1)
        begin
            case (BLOCK)
            A_1: begin R[n][m]<=1;R[n][m+1]<=1;R[n+1][m]<=1;R[n+1][m+1]<=1;end
            B_1: begin R[n-1][m]<=1;R[n][m]<=1;R[n+1][m]<=1;R[n+1][m+1]<=1;end
            B_2: begin R[n-1][m+1]<=1;R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;end
            B_3: begin R[n-1][m-1]<=1;R[n-1][m]<=1;R[n][m]<=1;R[n+1][m]<=1;end 
            B_4: begin R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;R[n+1][m-1]<=1;end
            C_1: begin R[n-1][m]<=1;R[n][m]<=1;R[n+1][m]<=1;R[n+1][m-1]<=1;end
            C_2: begin R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;R[n+1][m+1]<=1;end
            C_3: begin R[n-1][m]<=1;R[n-1][m+1]<=1;R[n][m]<=1;R[n+1][m]<=1;end
            C_4: begin R[n-1][m-1]<=1;R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;end
            D_1: begin R[n-1][m]<=1;R[n][m]<=1;R[n+1][m]<=1;R[n+2][m]<=1;end
            D_2: begin R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;R[n][m+2]<=1;end
            E_1: begin R[n-1][m]<=1;R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;end
            E_2: begin R[n-1][m]<=1;R[n][m-1]<=1;R[n][m]<=1;R[n+1][m]<=1;end
            E_3: begin R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;R[n+1][m]<=1;end
            E_4: begin R[n-1][m]<=1;R[n][m]<=1;R[n][m+1]<=1;R[n+1][m]<=1;end
            F_1: begin R[n-1][m+1]<=1;R[n][m]<=1;R[n][m+1]<=1;R[n+1][m]<=1;end
            F_2: begin R[n-1][m-1]<=1;R[n-1][m]<=1;R[n][m]<=1;R[n][m+1]<=1;end
            G_1: begin R[n-1][m]<=1;R[n][m]<=1;R[n][m+1]<=1;R[n+1][m+1]<=1;end
            G_2: begin R[n-1][m]<=1;R[n-1][m+1]<=1;R[n][m-1]<=1;R[n][m]<=1;end
            default
            begin
                for (i = 0; i < 24; i = i + 1)
                    R[i] <= R[i];
            end
            endcase
            REMOVE_2_S<=4'b1111;
        end

        else if (remove_2)
        begin
            if (!REMOVE_FINISH[0])
            begin if ((&R[n-1])|(SIG))
                begin
                    if (REMOVE_2_S[0]) begin REMOVE_2_C<=n-1; REMOVE_2_S[0]<=0; SIG<=1;end
                    else begin
                        if (REMOVE_2_C>=1) begin R[REMOVE_2_C]<=R[REMOVE_2_C-1]; REMOVE_2_C<=REMOVE_2_C-1; SIG<=1;end
                        else begin REMOVE_FINISH[0]<=1;SIG<=0;end
                    end
                end
            else begin REMOVE_FINISH[0]<=1; SIG<=0; end
            end    
            else if (!REMOVE_FINISH[1])
            begin if ((&R[n])|(SIG))
                begin
                    if (REMOVE_2_S[1]) begin REMOVE_2_C<=n; REMOVE_2_S[1]<=0; SIG<=1; end
                    else begin
                        if (REMOVE_2_C>=1) begin R[REMOVE_2_C]<=R[REMOVE_2_C-1]; REMOVE_2_C<=REMOVE_2_C-1; SIG<=1; end
                        else begin REMOVE_FINISH[1]<=1; SIG<=0; end
                    end
                end
            else begin REMOVE_FINISH[1]<=1; SIG<=0; end
            end
            else if (!REMOVE_FINISH[2])
            begin
            if (n<=22)
                begin if ((&R[n+1])|(SIG))
                    begin
                        if (REMOVE_2_S[2]) begin REMOVE_2_C<=n+1; REMOVE_2_S[2]<=0;SIG<=1; end
                        else begin
                            if (REMOVE_2_C>=1) begin R[REMOVE_2_C]<=R[REMOVE_2_C-1]; REMOVE_2_C<=REMOVE_2_C-1; SIG<=1; end
                            else begin REMOVE_FINISH[2]<=1; SIG<=0; end
                        end
                    end
                    else begin REMOVE_FINISH[2]<=1; SIG<=0; end
                end
            else begin REMOVE_FINISH[2]<=1; SIG<=0; end
            end    
            else if (!REMOVE_FINISH[3])
            begin
            if (n<=21)
                begin if ((&R[n+2])|(SIG))
                    begin
                        if (REMOVE_2_S[3]) begin REMOVE_2_C<=n+2; REMOVE_2_S[3]<=0; SIG<=1; end
                        else begin
                            if (REMOVE_2_C>=1) begin R[REMOVE_2_C]<=R[REMOVE_2_C-1]; REMOVE_2_C<=REMOVE_2_C-1; SIG<=1; end
                            else begin REMOVE_FINISH[3]<=1; SIG<=1; end
                        end
                    end
                    else begin REMOVE_FINISH[3]<=1; SIG<=0; end
                end
           else begin REMOVE_FINISH[3]<=1; SIG<=0; end    
           end
          else
            begin
            for (i=0; i <24; i = i + 1) R[i] <= R[i];
            REMOVE_FINISH<=0;
            SIG<=0;
            end
     end
     else if (stop) for (i=0;i<=23;i=i+1) R[i]<=0;
end

    //BLOCK_P
    always @ (*)
    begin
        case (BLOCK)
        A_1: BLOCK_P = A_1;
        B_1: BLOCK_P = B_2;
        B_2: BLOCK_P = B_3;
        B_3: BLOCK_P = B_4;
        B_4: BLOCK_P = B_1;
        C_1: BLOCK_P = C_2;
        C_2: BLOCK_P = C_3;
        C_3: BLOCK_P = C_4;
        C_4: BLOCK_P = C_1;
        D_1: BLOCK_P = D_2;
        D_2: BLOCK_P = D_1;
        E_1: BLOCK_P = E_2;
        E_2: BLOCK_P = E_3;
        E_3: BLOCK_P = E_4;
        E_4: BLOCK_P = E_1;
        F_1: BLOCK_P = F_2;
        F_2: BLOCK_P = F_1;
        G_1: BLOCK_P = G_2;
        G_2: BLOCK_P = G_1;
        default BLOCK_P = 7'b0000000;
        endcase
    end

    // BLOCK
    always @ (posedge clk or posedge clr)
    begin
        if (clr)
            BLOCK <= 7'b0000000;
        else if (gen_random)
            BLOCK <= NEW_BLOCK;
        else if (shift && u)
            BLOCK <= BLOCK_P;
        else
            BLOCK <= BLOCK;
    end

    // down_comp
    always @ (*)
    begin
      //  if (!rst_n)
        down_comp = 0;
        if (move_down)
        begin
            //down_comp<=1;
            case (BLOCK)
            A_1: if (n<=21) begin if (!(R[n+2][m] | R[n+2][m+1])) down_comp = 1; else down_comp = 0; end else down_comp=0;
            B_1: if (n<=21) begin if (!(R[n+2][m] | R[n+2][m+1])) down_comp = 1; else down_comp = 0; end else down_comp=0;
            B_2: if (n<=22) begin if (!(R[n+1][m] | R[n+1][m-1] | R[n+1][m+1])) down_comp = 1; else down_comp = 0; end else down_comp=0;
            B_3: if (n<=21) begin if (!(R[n+2][m] | R[n][m-1])) down_comp = 1; else down_comp = 0; end else down_comp=0;
            B_4: if (n<=21) begin if (!(R[n+1][m] | R[n+1][m+1] | R[n+2][m-1])) down_comp = 1; else down_comp = 0; end else down_comp=0;
            C_1: if (n<=21) begin if (!(R[n+2][m] | R[n+2][m-1])) down_comp = 1; else down_comp = 0; end else down_comp=0;
            C_2: if (n<=21) begin if (!(R[n+1][m] | R[n+1][m-1] | R[n+2][m+1])) down_comp = 1; else down_comp = 0; end else down_comp=0;
            C_3: if (n<=21) begin if (!(R[n+2][m] | R[n][m+1])) down_comp = 1; else down_comp = 0; end else down_comp=0;
            C_4: if (n<=22) begin if (!(R[n+1][m] | R[n+1][m-1] | R[n+1][m+1])) down_comp = 1; else down_comp = 0; end else down_comp=0;
            D_1: if (n<=20) begin if (!(R[n+3][m])) down_comp = 1; else down_comp = 0; end else down_comp=0;
            D_2: if (n<=22) begin if (!(R[n+1][m] | R[n+1][m-1] | R[n+1][m+1] | R[n+1][m+1])) down_comp = 1; else down_comp = 0; end else down_comp=0;
            E_1: if (n<=22) begin if (!(R[n+1][m] | R[n+1][m-1] | R[n+1][m+1])) down_comp = 1; else down_comp = 0; end else down_comp=0;
            E_2: if (n<=21) begin if (!(R[n+2][m] | R[n+1][m-1])) down_comp = 1; else down_comp = 0; end else down_comp=0;
            E_3: if (n<=21) begin if (!(R[n+2][m] | R[n+1][m-1] | R[n+1][m+1])) down_comp = 1; else down_comp = 0; end else down_comp=0;
            E_4: if (n<=21) begin if (!(R[n+2][m] | R[n+1][m+1])) down_comp = 1; else down_comp = 0; end else down_comp=0;
            F_1: if (n<=21) begin if (!(R[n+2][m] | R[n+1][m+1])) down_comp = 1; else down_comp = 0; end else down_comp=0;
            F_2: if (n<=22) begin if (!(R[n+1][m] | R[n][m-1] | R[n+1][m+1])) down_comp = 1; else down_comp = 0; end else down_comp=0;
            G_1: if (n<=21) begin if (!(R[n+1][m] | R[n+2][m+1])) down_comp = 1; else down_comp = 0; end else down_comp=0;
            G_2: if (n<=22) begin if (!(R[n+1][m] | R[n+1][m-1] | R[n][m+1])) down_comp = 1; else down_comp = 0; end else down_comp=0;
            default down_comp = 0;
            endcase
        end
        else
            down_comp = 0;
    end

    // n
    always @ (posedge clk or posedge clr)
    begin
        if (clr)
            n <= 0;
        else if (gen_random)
            n <= 1;
        else if ((shift)&(auto_down))
            n<=n+1;
        else if ((shift)& d)
            n <= n + 1;
        else
            n <= n;
    end

    // m
    always @ (posedge clk or posedge clr)
    begin
        if (clr)
            m <= 0;
        else if (gen_random)
            m <= 5;
        else if (shift)
        begin
            if (auto_down) m<=m;
            else if (l)
                m <= m - 1;
            else if (r)
                m <= m + 1;
            else
                m <= m;
        end
        else
            m <= m;
    end

    // NEW_BLOCK
    always @(*)
    begin
        if (clr)
            NEW_BLOCK = A_1;
        else if (gen_random)
        begin
            case (RAN)
            1: NEW_BLOCK = A_1;
            2: NEW_BLOCK = B_1;
            3: NEW_BLOCK = C_1;
            4: NEW_BLOCK = D_1;
            5: NEW_BLOCK = E_1;
            6: NEW_BLOCK = F_1;
            7: NEW_BLOCK = G_1;
            default NEW_BLOCK = A_1;
            endcase
        end
        else
            NEW_BLOCK = A_1;
    end

    // shift_finish
    always @(posedge clk or posedge clr)
    begin
        if (clr)
            shift_finish <= 0;
        else if (shift)
            shift_finish <= 1;
        else
            shift_finish <= 0;
    end

    // remove_2_finish
    always @(posedge clk or posedge clr)
    begin
        if (clr)
            remove_2_finish <= 0;
        else if (&REMOVE_FINISH)
            remove_2_finish <= 1;
        else
            remove_2_finish <= 0;
    end

    // remove_cnt
    always @(posedge clk or posedge clr)
    begin
        if (clr)
            remove_cnt <= 0;
        else if ((remove_cnt < 23) && (remove_2 == 1))
            remove_cnt <= remove_cnt + 1;
        else
            remove_cnt <= 0;
    end

    // die
    always @(*)
    begin
       if (isdie) begin
            if (|R[3]) die = 1;
            else die = 0;
       end
       else die=0;
    end
    

endmodule

