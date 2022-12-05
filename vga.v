`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/30 22:49:59
// Design Name: 
// Module Name: vga
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


module vga(
input clk,clr,
input [799:0] data_b,data_q,
output hsync_m,vsync_m,
output [3:0] r_m,g_m,b_m
);
reg [9:0]xsync,ysync;
reg [11:0] vga_rgb;
wire vidon;
wire [19:0] x;
wire [39:0] y;
wire [19:0] R_b [39:0];
wire [19:0] R_q [39:0];
reg a,b;
  
  parameter color = 12'b0000_0000_1111;
  assign R_b[0] = data_b[19:0];
  assign R_b[1] = data_b[39:20];
  assign R_b[2] = data_b[59:40];
  assign R_b[3] = data_b[79:60];
  assign R_b[4] = data_b[99:80];
  assign R_b[5] = data_b[119:100];
  assign R_b[6] = data_b[139:120];
  assign R_b[7] = data_b[159:140];
  assign R_b[8] = data_b[179:160];
  assign R_b[9] = data_b[199:180];
  assign R_b[10] = data_b[219:200];
  assign R_b[11] = data_b[239:220];
  assign R_b[12] = data_b[259:240];
  assign R_b[13] = data_b[279:260];
  assign R_b[14] = data_b[299:280];
  assign R_b[15] = data_b[319:300];
  assign R_b[16] = data_b[339:320];
  assign R_b[17] = data_b[359:340];
  assign R_b[18] = data_b[379:360];
  assign R_b[19] = data_b[399:380];
  assign R_b[20] = data_b[419:400];
  assign R_b[21] = data_b[439:420];
  assign R_b[22] = data_b[459:440];
  assign R_b[23] = data_b[479:460];
  assign R_b[24] = data_b[499:480];
  assign R_b[25] = data_b[519:500];
  assign R_b[26] = data_b[539:520];
  assign R_b[27] = data_b[559:540];
  assign R_b[28] = data_b[579:560];
  assign R_b[29] = data_b[599:580];
  assign R_b[30] = data_b[619:600];
  assign R_b[31] = data_b[639:620];
  assign R_b[32] = data_b[659:640];
  assign R_b[33] = data_b[679:660];
  assign R_b[34] = data_b[699:680];
  assign R_b[35] = data_b[719:700];
  assign R_b[36] = data_b[739:720];
  assign R_b[37] = data_b[759:740];
  assign R_b[38] = data_b[779:760];
  assign R_b[39] = data_b[799:780];
  
  assign R_q[0] = data_q[19:0];
  assign R_q[1] = data_q[39:20];
  assign R_q[2] = data_q[59:40];
  assign R_q[3] = data_q[79:60];
  assign R_q[4] = data_q[99:80];
  assign R_q[5] = data_q[119:100];
  assign R_q[6] = data_q[139:120];
  assign R_q[7] = data_q[159:140];
  assign R_q[8] = data_q[179:160];
  assign R_q[9] = data_q[199:180];
  assign R_q[10] = data_q[219:200];
  assign R_q[11] = data_q[239:220];
  assign R_q[12] = data_q[259:240];
  assign R_q[13] = data_q[279:260];
  assign R_q[14] = data_q[299:280];
  assign R_q[15] = data_q[319:300];
  assign R_q[16] = data_q[339:320];
  assign R_q[17] = data_q[359:340];
  assign R_q[18] = data_q[379:360];
  assign R_q[19] = data_q[399:380];
  assign R_q[20] = data_q[419:400];
  assign R_q[21] = data_q[439:420];
  assign R_q[22] = data_q[459:440];
  assign R_q[23] = data_q[479:460];
  assign R_q[24] = data_q[499:480];
  assign R_q[25] = data_q[519:500];
  assign R_q[26] = data_q[539:520];
  assign R_q[27] = data_q[559:540];
  assign R_q[28] = data_q[579:560];
  assign R_q[29] = data_q[599:580];
  assign R_q[30] = data_q[619:600];
  assign R_q[31] = data_q[639:620];
  assign R_q[32] = data_q[659:640];
  assign R_q[33] = data_q[679:660];
  assign R_q[34] = data_q[699:680];
  assign R_q[35] = data_q[719:700];
  assign R_q[36] = data_q[739:720];
  assign R_q[37] = data_q[759:740];
  assign R_q[38] = data_q[779:760];
  assign R_q[39] = data_q[799:780];
  
always @(posedge clk or posedge clr) 
    begin
    if (clr) begin  
      xsync <= 10'd0;
    end
    else if (xsync == 10'd799) begin
      xsync <= 10'd0;
    end
    else begin
      xsync <= xsync + 1;
    end
  end

always @(posedge clk or posedge clr) 
  begin
    if (clr) begin
      ysync <= 10'd0;
    end
    else if (ysync == 10'd524) begin
      ysync <= 10'd0;
    end
    else if (xsync == 10'd799) begin
      ysync <= ysync + 1;
    end
  end

  always @(posedge clk or posedge clr) begin
    if (clr) begin
      a <= 1'b0;
    end
    else if (xsync == 799) begin
       a <=1'b0;
    end
    else if (xsync == 95) begin
       a <= 1'b1;
    end
  end

always @(posedge clk or posedge clr) begin
    if (clr) begin
     b <= 1'b0;
    end
    else if (ysync == 0) begin
     b <=1'b0;
    end
    else if (ysync == 1) begin
     b <= 1'b1;
    end
  end

assign vidon = (xsync > 143) && (xsync < 784) && (ysync > 34) && (ysync < 515);
assign hsync_m = a;
assign vsync_m = b;

assign x[0] = (xsync >= 344) && (xsync <= 355);
assign x[1] = (xsync >= 356) && (xsync <= 367);
assign x[2] = (xsync >= 368) && (xsync <= 379);
assign x[3] = (xsync >= 380) && (xsync <= 391);
assign x[4] = (xsync >= 392) && (xsync <= 403);
assign x[5] = (xsync >= 404) && (xsync <= 415);
assign x[6] = (xsync >= 416) && (xsync <= 427);
assign x[7] = (xsync >= 428) && (xsync <= 439);
assign x[8] = (xsync >= 440) && (xsync <= 451);
assign x[9] = (xsync >= 452) && (xsync <= 463);
assign x[10] = (xsync >= 464) && (xsync <= 475);
assign x[11] = (xsync >= 476) && (xsync <= 487);
assign x[12] = (xsync >= 488) && (xsync <= 499);
assign x[13] = (xsync >= 500) && (xsync <= 511);
assign x[14] = (xsync >= 512) && (xsync <= 523);
assign x[15] = (xsync >= 524) && (xsync <= 535);
assign x[16] = (xsync >= 536) && (xsync <= 547);
assign x[17] = (xsync >= 548) && (xsync <= 559);
assign x[18] = (xsync >= 560) && (xsync <= 571);
assign x[19] = (xsync >= 572) && (xsync <= 583);

assign y[0]  = (ysync >= 35) && (ysync <= 46); 
assign y[1]  = (ysync >= 47) && (ysync <= 58);
assign y[2]  = (ysync >= 59) && (ysync <= 70);
assign y[3]  = (ysync >= 71) &&(ysync <= 82);
assign y[4]  = (ysync >= 83) && (ysync <=94);
assign y[5]  = (ysync >= 95) && (ysync <=106); 
assign y[6]  = (ysync >= 107) && (ysync <118); 
assign y[7]  = (ysync >= 119) && (ysync <=130); 
assign y[8]  = (ysync >= 131) && (ysync <=142); 
assign y[9]  = (ysync >= 143) && (ysync <=154); 
assign y[10] = (ysync >= 155) && (ysync <=166); 
assign y[11] = (ysync >= 167) && (ysync <=178); 
assign y[12] = (ysync >= 179) && (ysync <=190); 
assign y[13] = (ysync >= 191) && (ysync <=202); 
assign y[14] = (ysync >= 203) && (ysync <=214); 
assign y[15] = (ysync >= 215) && (ysync <=226); 
assign y[16] = (ysync >= 227) && (ysync <=238); 
assign y[17] = (ysync >= 239) && (ysync <=250); 
assign y[18] = (ysync >= 251) && (ysync <=262); 
assign y[19] = (ysync >= 263) && (ysync <=274);
assign y[20]  = (ysync >= 275) && (ysync <= 286); 
assign y[21]  = (ysync >= 287) && (ysync <= 298);
assign y[22]  = (ysync >= 299) && (ysync <= 310);
assign y[23]  = (ysync >= 311) &&(ysync <= 322);
assign y[24]  = (ysync >= 323) && (ysync <=334);
assign y[25]  = (ysync >= 335) && (ysync <=346); 
assign y[26]  = (ysync >= 347) && (ysync <358); 
assign y[27]  = (ysync >= 359) && (ysync <=370); 
assign y[28]  = (ysync >= 371) && (ysync <=382); 
assign y[29]  = (ysync >= 383) && (ysync <=394); 
assign y[30] = (ysync >= 395) && (ysync <=406); 
assign y[31] = (ysync >= 407) && (ysync <=418); 
assign y[32] = (ysync >= 419) && (ysync <=430); 
assign y[33] = (ysync >= 431) && (ysync <=442); 
assign y[34] = (ysync >= 443) && (ysync <=454); 
assign y[35] = (ysync >= 455) && (ysync <=466); 
assign y[36] = (ysync >= 467) && (ysync <=478); 
assign y[37] = (ysync >= 479) && (ysync <=490); 
assign y[38] = (ysync >= 491) && (ysync <=502); 
assign y[39] = (ysync >= 503) && (ysync <=514);
 

integer i,j;
  always @(posedge clk or posedge clr) begin
    if (clr) begin
      vga_rgb <= 0;
    end
    else if (vidon)
    begin
        if (xsync>=344 && xsync<=583)
            if (x[0]&y[0]&R_b[0][0])
                vga_rgb <= color;
            else if (x[1] & y[0] &R_b[0][1])
                vga_rgb <= color;
            else if (x[2] & y[0] &R_b[0][2])
                vga_rgb <= color;            
            else if (x[3] & y[0] &R_b[0][3])
                 vga_rgb <= color;
            else if (x[4] & y[0] &R_b[0][4])
                 vga_rgb <= color;
            else if (x[5] & y[0] &R_b[0][5])
                 vga_rgb <= color;        
            else if (x[6] & y[0] &R_b[0][6])
                 vga_rgb <= color;
            else if (x[7] & y[0] &R_b[0][7])
                 vga_rgb <= color;
            else if (x[8] & y[0] & R_b[0][8])
                 vga_rgb <= color;
            else if (x[9] & y[0] & R_q[0][9])
                vga_rgb <= 12'b000011111111;     
            else if (x[9] & y[0] & R_b[0][9])
                vga_rgb <= color;
            else if (x[10] & y[0] & R_b[0][10])
                vga_rgb <= color;
            else if (x[11] & y[0] &R_b[0][11])
                vga_rgb <= color;
            else if (x[12] & y[0] &R_b[0][12])
                vga_rgb <= color;            
            else if (x[13] & y[0] &R_b[0][13])
                 vga_rgb <= color;
            else if (x[14] & y[0] &R_b[0][14])
                 vga_rgb <= color;
            else if (x[15] & y[0] &R_b[0][15])
                 vga_rgb <= color;        
            else if (x[16] & y[0] &R_b[0][16])
                 vga_rgb <= color;
            else if (x[17] & y[0] &R_b[0][17])
                 vga_rgb <= color;
            else if (x[18] & y[0] & R_b[0][18])
                 vga_rgb <= color;
            else if (x[19] & y[0] & R_q[0][19])
                vga_rgb <= 12'b000011111111;     
            else if (x[19] & y[0] & R_b[0][19])
                vga_rgb <= color;    

            else if (x[0] & y[1] & R_b[1][0])
                vga_rgb <= color;
            else if (x[1] & y[1] & R_b[1][1])
                vga_rgb <= color;
            else if (x[2] & y[1] & R_b[1][2])
                vga_rgb <= color;            
            else if (x[3] & y[1] & R_b[1][3])
                 vga_rgb <= color;
            else if (x[4] & y[1] & R_b[1][4])
                 vga_rgb <= color;
            else if (x[5] & y[1] & R_b[1][5])
                 vga_rgb <= color;        
            else if (x[6] & y[1] & R_b[1][6])
                 vga_rgb <= color;
            else if (x[7] & y[1] & R_b[1][7])
                 vga_rgb <= color;
            else if (x[8] & y[1] & R_b[1][8])
                 vga_rgb <= color;
            else if (x[9] & y[1] & R_b[1][9])
                vga_rgb <= color;
            else if (x[10] & y[1] &R_b[1][10])
                vga_rgb <= color;
            else if (x[11] & y[1] & R_b[1][11])
                vga_rgb <= color;
            else if (x[12] & y[1] & R_b[1][12])
                vga_rgb <= color;            
            else if (x[13] & y[1] & R_b[1][13])
                 vga_rgb <= color;
            else if (x[14] & y[1] & R_b[1][14])
                 vga_rgb <= color;
            else if (x[15] & y[1] & R_b[1][15])
                 vga_rgb <= color;        
            else if (x[16] & y[1] & R_b[1][16])
                 vga_rgb <= color;
            else if (x[17] & y[1] & R_b[1][17])
                 vga_rgb <= color;
            else if (x[18] & y[1] & R_b[1][18])
                 vga_rgb <= color;
            else if (x[19] & y[1] & R_q[1][19])
                vga_rgb <= 12'b000011111111;       
            else if (x[19] & y[1] & R_b[1][19])
                vga_rgb <= color;    

            else if (x[0] & y[2] & R_b[2][0])
                vga_rgb <= color;
            else if (x[1] & y[2] & R_b[2][1])
                vga_rgb <= color;
            else if (x[2] & y[2] & R_b[2][2])
                vga_rgb <= color;            
            else if (x[3] & y[2] & R_b[2][3])
                 vga_rgb <= color;
            else if (x[4] & y[2] & R_b[2][4])
                 vga_rgb <= color;
            else if (x[5] & y[2] & R_b[2][5])
                 vga_rgb <= color;        
            else if (x[6] & y[2] & R_b[2][6])
                 vga_rgb <= color;
            else if (x[7] & y[2] & R_b[2][7])
                 vga_rgb <= color;
            else if (x[8] & y[2] & R_b[2][8])
                 vga_rgb <= color;
            else if (x[9] & y[2] & R_b[2][9])
                vga_rgb <= color;
            else if (x[10] & y[2] &R_b[2][10])
                vga_rgb <= color;
            else if (x[11] & y[2] & R_b[2][11])
                vga_rgb <= color;
            else if (x[12] & y[2] & R_b[2][12])
                vga_rgb <= color;            
            else if (x[13] & y[2] & R_b[2][13])
                 vga_rgb <= color;
            else if (x[14] & y[2] & R_b[2][14])
                 vga_rgb <= color;
            else if (x[15] & y[2] & R_b[2][15])
                 vga_rgb <= color;        
            else if (x[16] & y[2] & R_b[2][16])
                 vga_rgb <= color;
            else if (x[17] & y[2] & R_b[2][17])
                 vga_rgb <= color;
            else if (x[18] & y[2] & R_b[2][18])
                 vga_rgb <= color;
            else if (x[19] & y[2] & R_b[2][19])
                vga_rgb <= color;


            else if (x[0] & y[3] & R_b[3][0])
                vga_rgb <= color;
            else if (x[1] & y[3] & R_b[3][1])
                vga_rgb <= color;
            else if (x[2] & y[3] & R_b[3][2])
                vga_rgb <= color;            
            else if (x[3] & y[3] & R_b[3][3])
                 vga_rgb <= color;
            else if (x[4] & y[3] & R_b[3][4])
                 vga_rgb <= color;
            else if (x[5] & y[3] & R_b[3][5])
                 vga_rgb <= color;        
            else if (x[6] & y[3] & R_b[3][6])
                 vga_rgb <= color;
            else if (x[7] & y[3] & R_b[3][7])
                 vga_rgb <= color;
            else if (x[8] & y[3] & R_b[3][8])
                 vga_rgb <= color;
            else if (x[9] & y[3] & R_b[3][9])
                vga_rgb <= color;
            else if (x[10] & y[3] &R_b[3][10])
                vga_rgb <= color;
            else if (x[11] & y[3] & R_b[3][11])
                vga_rgb <= color;
            else if (x[12] & y[3] & R_b[3][12])
                vga_rgb <= color;            
            else if (x[13] & y[3] & R_b[3][13])
                 vga_rgb <= color;
            else if (x[14] & y[3] & R_b[3][14])
                 vga_rgb <= color;
            else if (x[15] & y[3] & R_b[3][15])
                 vga_rgb <= color;        
            else if (x[16] & y[3] & R_b[3][16])
                 vga_rgb <= color;
            else if (x[17] & y[3] & R_b[3][17])
                 vga_rgb <= color;
            else if (x[18] & y[3] & R_b[3][18])
                 vga_rgb <= color;
            else if (x[19] & y[3] & R_b[3][19])
                vga_rgb <= color;

            else if (x[0] & y[4] & R_b[4][0])
                vga_rgb <= color;
            else if (x[1] & y[4] & R_b[4][1])
                vga_rgb <= color;
            else if (x[2] & y[4] & R_b[4][2])
                vga_rgb <= color;            
            else if (x[3] & y[4] & R_b[4][3])
                 vga_rgb <= color;
            else if (x[4] & y[4] & R_b[4][4])
                 vga_rgb <= color;
            else if (x[5] & y[4] & R_b[4][5])
                 vga_rgb <= color;        
            else if (x[6] & y[4] & R_b[4][6])
                 vga_rgb <= color;
            else if (x[7] & y[4] & R_b[4][7])
                 vga_rgb <= color;
            else if (x[8] & y[4] & R_b[4][8])
                 vga_rgb <= color;
            else if (x[9] & y[4] & R_b[4][9])
                vga_rgb <= color;
            else if (x[10] & y[4] &R_b[4][10])
                vga_rgb <= color;
            else if (x[11] & y[4] & R_b[4][11])
                vga_rgb <= color;
            else if (x[12] & y[4] & R_b[4][12])
                vga_rgb <= color;            
            else if (x[13] & y[4] & R_b[4][13])
                 vga_rgb <= color;
            else if (x[14] & y[4] & R_b[4][14])
                 vga_rgb <= color;
            else if (x[15] & y[4] & R_b[4][15])
                 vga_rgb <= color;        
            else if (x[16] & y[4] & R_b[4][16])
                 vga_rgb <= color;
            else if (x[17] & y[4] & R_b[4][17])
                 vga_rgb <= color;
            else if (x[18] & y[4] & R_b[4][18])
                 vga_rgb <= color;
            else if (x[19] & y[4] & R_b[4][19])
                vga_rgb <= color;

            else if (x[0] & y[5] & R_b[5][0])
                vga_rgb <= color;
            else if (x[1] & y[5] & R_b[5][1])
                vga_rgb <= color;
            else if (x[2] & y[5] & R_b[5][2])
                vga_rgb <= color;            
            else if (x[3] & y[5] & R_b[5][3])
                 vga_rgb <= color;
            else if (x[4] & y[5] & R_b[5][4])
                 vga_rgb <= color;
            else if (x[5] & y[5] & R_b[5][5])
                 vga_rgb <= color;        
            else if (x[6] & y[5] & R_b[5][6])
                 vga_rgb <= color;
            else if (x[7] & y[5] & R_b[5][7])
                 vga_rgb <= color;
            else if (x[8] & y[5] & R_b[5][8])
                 vga_rgb <= color;
            else if (x[9] & y[5] & R_q[5][9])
                vga_rgb <= 12'b000011111111;     
            else if (x[9] & y[5] & R_b[5][9])
                vga_rgb <= color;
            else if (x[10] & y[5] &R_b[5][10])
                vga_rgb <= color;
            else if (x[11] & y[5] & R_b[5][11])
                vga_rgb <= color;
            else if (x[12] & y[5] & R_b[5][12])
                vga_rgb <= color;            
            else if (x[13] & y[5] & R_b[5][13])
                 vga_rgb <= color;
            else if (x[14] & y[5] & R_b[5][14])
                 vga_rgb <= color;
            else if (x[15] & y[5] & R_b[5][15])
                 vga_rgb <= color;        
            else if (x[16] & y[5] & R_b[5][16])
                 vga_rgb <= color;
            else if (x[17] & y[5] & R_b[5][17])
                 vga_rgb <= color;
            else if (x[18] & y[5] & R_b[5][18])
                 vga_rgb <= color;
            else if (x[19] & y[5] & R_b[5][19])
                vga_rgb <= color;
                  
           
            else if (x[0] & y[6] & R_b[6][0])
                vga_rgb <= color;
            else if (x[1] & y[6] & R_q[6][1])
                vga_rgb <= 12'b000011111111;      
            else if (x[1] & y[6] & R_b[6][1])
                vga_rgb <= color;
            else if (x[2] & y[6] & R_b[6][2])
                vga_rgb <= color;            
            else if (x[3] & y[6] & R_b[6][3])
                 vga_rgb <= color;
            else if (x[4] & y[6] & R_b[6][4])
                 vga_rgb <= color;
            else if (x[5] & y[6] & R_b[6][5])
                 vga_rgb <= color;        
            else if (x[6] & y[6] & R_b[6][6])
                 vga_rgb <= color;
            else if (x[7] & y[6] & R_b[6][7])
                 vga_rgb <= color;
            else if (x[8] & y[6] & R_b[6][8])
                 vga_rgb <= color;
            else if (x[9] & y[6] & R_b[6][9])
                vga_rgb <= color;
            else if (x[10] & y[6] &R_b[6][10])
                vga_rgb <= color;
            else if (x[11] & y[6] & R_b[6][11])
                vga_rgb <= color;
            else if (x[12] & y[6] & R_b[6][12])
                vga_rgb <= color;            
            else if (x[13] & y[6] & R_b[6][13])
                 vga_rgb <= color;
            else if (x[14] & y[6] & R_b[6][14])
                 vga_rgb <= color;
            else if (x[15] & y[6] & R_b[6][15])
                 vga_rgb <= color;        
            else if (x[16] & y[6] & R_b[6][16])
                 vga_rgb <= color;
            else if (x[17] & y[6] & R_b[6][17])
                 vga_rgb <= color;
            else if (x[18] & y[6] & R_b[6][18])
                 vga_rgb <= color;
            else if (x[19] & y[6] & R_b[6][19])
                vga_rgb <= color;
            
            else if (x[0] & y[7] & R_b[7][0])
                vga_rgb <= color;
            else if (x[1] & y[7] & R_b[7][1])
                vga_rgb <= color;
            else if (x[2] & y[7] & R_b[7][2])
                vga_rgb <= color;            
            else if (x[3] & y[7] & R_b[7][3])
                 vga_rgb <= color;
            else if (x[4] & y[7] & R_b[7][4])
                 vga_rgb <= color;
            else if (x[5] & y[7] & R_b[7][5])
                 vga_rgb <= color;        
            else if (x[6] & y[7] & R_b[7][6])
                 vga_rgb <= color;
            else if (x[7] & y[7] & R_b[7][7])
                 vga_rgb <= color;
            else if (x[8] & y[7] & R_b[7][8])
                 vga_rgb <= color;
            else if (x[9] & y[7] & R_b[7][9])
                vga_rgb <= color;
            else if (x[10] & y[7] &R_b[7][10])
                vga_rgb <= color;
            else if (x[11] & y[7] & R_b[7][11])
                vga_rgb <= color;
            else if (x[12] & y[7] & R_b[7][12])
                vga_rgb <= color;            
            else if (x[13] & y[7] & R_b[7][13])
                 vga_rgb <= color;
            else if (x[14] & y[7] & R_b[7][14])
                 vga_rgb <= color;
            else if (x[15] & y[7] & R_b[7][15])
                 vga_rgb <= color;        
            else if (x[16] & y[7] & R_b[7][16])
                 vga_rgb <= color;
            else if (x[17] & y[7] & R_b[7][17])
                 vga_rgb <= color;
            else if (x[18] & y[7] & R_b[7][18])
                 vga_rgb <= color;
            else if (x[19] & y[7] & R_b[7][19])
                vga_rgb <= color;


            else if (x[0] & y[8] & R_b[8][0])
                vga_rgb <= color;
            else if (x[1] & y[8] & R_b[8][1])
                vga_rgb <= color;
            else if (x[2] & y[8] & R_b[8][2])
                vga_rgb <= color;            
            else if (x[3] & y[8] & R_b[8][3])
                 vga_rgb <= color;
            else if (x[4] & y[8] & R_b[8][4])
                 vga_rgb <= color;
            else if (x[5] & y[8] & R_b[8][5])
                 vga_rgb <= color;        
            else if (x[6] & y[8] & R_b[8][6])
                 vga_rgb <= color;
            else if (x[7] & y[8] & R_b[8][7])
                 vga_rgb <= color;
            else if (x[8] & y[8] & R_b[8][8])
                 vga_rgb <= color;
            else if (x[9] & y[8] & R_b[8][9])
                vga_rgb <= color;
            else if (x[10] & y[8] &R_b[8][10])
                vga_rgb <= color;
            else if (x[11] & y[8] & R_b[8][11])
                vga_rgb <= color;
            else if (x[12] & y[8] & R_b[8][12])
                vga_rgb <= color;            
            else if (x[13] & y[8] & R_b[8][13])
                 vga_rgb <= color;
            else if (x[14] & y[8] & R_b[8][14])
                 vga_rgb <= color;
            else if (x[15] & y[8] & R_q[8][15])
                vga_rgb <= 12'b000011111111;       
            else if (x[15] & y[8] & R_b[8][15])
                 vga_rgb <= color;        
            else if (x[16] & y[8] & R_b[8][16])
                 vga_rgb <= color;
            else if (x[17] & y[8] & R_b[8][17])
                 vga_rgb <= color;
            else if (x[18] & y[8] & R_b[8][18])
                 vga_rgb <= color;
            else if (x[19] & y[8] & R_b[8][19])
                vga_rgb <= color;            

            else if (x[0] & y[9] & R_b[9][0])
                vga_rgb <= color;
            else if (x[1] & y[9] & R_b[9][1])
                vga_rgb <= color;
            else if (x[2] & y[9] & R_b[9][2])
                vga_rgb <= color;            
            else if (x[3] & y[9] & R_b[9][3])
                 vga_rgb <= color;
            else if (x[4] & y[9] & R_b[9][4])
                 vga_rgb <= color;
            else if (x[5] & y[9] & R_b[9][5])
                 vga_rgb <= color;        
            else if (x[6] & y[9] & R_b[9][6])
                 vga_rgb <= color;
            else if (x[7] & y[9] & R_b[9][7])
                 vga_rgb <= color;
            else if (x[8] & y[9] & R_b[9][8])
                 vga_rgb <= color;
            else if (x[9] & y[9] & R_b[9][9])
                vga_rgb <= color;
            else if (x[10] & y[9] &R_b[9][10])
                vga_rgb <= color;
            else if (x[11] & y[9] & R_b[9][11])
                vga_rgb <= color;
            else if (x[12] & y[9] & R_b[9][12])
                vga_rgb <= color;            
            else if (x[13] & y[9] & R_b[9][13])
                 vga_rgb <= color;
            else if (x[14] & y[9] & R_b[9][14])
                 vga_rgb <= color;
            else if (x[15] & y[9] & R_b[9][15])
                 vga_rgb <= color;        
            else if (x[16] & y[9] & R_b[9][16])
                 vga_rgb <= color;
            else if (x[17] & y[9] & R_b[9][17])
                 vga_rgb <= color;
            else if (x[18] & y[9] & R_b[9][18])
                 vga_rgb <= color;
            else if (x[19] & y[9] & R_b[9][19])
                vga_rgb <= color;

            else if (x[0] & y[10] & R_b[10][0])
                vga_rgb <= color;
            else if (x[1] & y[10] & R_b[10][1])
                vga_rgb <= color;
            else if (x[2] & y[10] & R_b[10][2])
                vga_rgb <= color;            
            else if (x[3] & y[10] & R_b[10][3])
                 vga_rgb <= color;
            else if (x[4] & y[10] & R_b[10][4])
                 vga_rgb <= color;
            else if (x[5] & y[10] & R_b[10][5])
                 vga_rgb <= color;        
            else if (x[6] & y[10] & R_b[10][6])
                 vga_rgb <= color;
            else if (x[7] & y[10] & R_b[10][7])
                 vga_rgb <= color;
            else if (x[8] & y[10] & R_b[10][8])
                 vga_rgb <= color;
            else if (x[9] & y[10] & R_b[10][9])
                vga_rgb <= color;
            else if (x[10] & y[10] &R_b[10][10])
                vga_rgb <= color;
            else if (x[11] & y[10] & R_b[10][11])
                vga_rgb <= color;
            else if (x[12] & y[10] & R_b[10][12])
                vga_rgb <= color;            
            else if (x[13] & y[10] & R_b[10][13])
                 vga_rgb <= color;
            else if (x[14] & y[10] & R_b[10][14])
                 vga_rgb <= color;
            else if (x[15] & y[10] & R_b[10][15])
                 vga_rgb <= color;        
            else if (x[16] & y[10] & R_b[10][16])
                 vga_rgb <= color;
            else if (x[17] & y[10] & R_b[10][17])
                 vga_rgb <= color;
            else if (x[18] & y[10] & R_b[10][18])
                 vga_rgb <= color;
            else if (x[19] & y[10] & R_b[10][19])
                vga_rgb <= color;

            else if (x[0] & y[11] & R_b[11][0])
                vga_rgb <= color;
            else if (x[1] & y[11] & R_b[11][1])
                vga_rgb <= color;
            else if (x[2] & y[11] & R_q[11][2])
                vga_rgb <= 12'b000011111111;      
            else if (x[2] & y[11] & R_b[11][2])
                vga_rgb <= color;            
            else if (x[3] & y[11] & R_b[11][3])
                 vga_rgb <= color;
            else if (x[4] & y[11] & R_b[11][4])
                 vga_rgb <= color;
            else if (x[5] & y[11] & R_b[11][5])
                 vga_rgb <= color;        
            else if (x[6] & y[11] & R_b[11][6])
                 vga_rgb <= color;
            else if (x[7] & y[11] & R_b[11][7])
                 vga_rgb <= color;
            else if (x[8] & y[11] & R_b[11][8])
                 vga_rgb <= color;
            else if (x[9] & y[11] & R_q[11][9])
                vga_rgb <= 12'b000011111111;      
            else if (x[9] & y[11] & R_b[11][9])
                vga_rgb <= color;
            else if (x[10] & y[11] &R_b[11][10])
                vga_rgb <= color;
            else if (x[11] & y[11] & R_b[11][11])
                vga_rgb <= color;
            else if (x[12] & y[11] & R_b[11][12])
                vga_rgb <= color;            
            else if (x[13] & y[11] & R_b[11][13])
                 vga_rgb <= color;
            else if (x[14] & y[11] & R_b[11][14])
                 vga_rgb <= color;
            else if (x[15] & y[11] & R_b[11][15])
                 vga_rgb <= color;        
            else if (x[16] & y[11] & R_b[11][16])
                 vga_rgb <= color;
            else if (x[17] & y[11] & R_b[11][17])
                 vga_rgb <= color;
            else if (x[18] & y[11] & R_b[11][18])
                 vga_rgb <= color;
            else if (x[19] & y[11] & R_b[11][19])
                vga_rgb <= color;     
            
            else if (x[0] & y[12] & R_b[12][0])
                vga_rgb <= color;
            else if (x[1] & y[12] & R_b[12][1])
                vga_rgb <= color;
            else if (x[2] & y[12] & R_b[12][2])
                vga_rgb <= color;            
            else if (x[3] & y[12] & R_b[12][3])
                 vga_rgb <= color;
            else if (x[4] & y[12] & R_b[12][4])
                 vga_rgb <= color;
            else if (x[5] & y[12] & R_b[12][5])
                 vga_rgb <= color;        
            else if (x[6] & y[12] & R_b[12][6])
                 vga_rgb <= color;
            else if (x[7] & y[12] & R_b[12][7])
                 vga_rgb <= color;
            else if (x[8] & y[12] & R_b[12][8])
                 vga_rgb <= color;
            else if (x[9] & y[12] & R_b[12][9])
                vga_rgb <= color;
            else if (x[10] & y[12] &R_b[12][10])
                vga_rgb <= color;
            else if (x[11] & y[12] & R_b[12][11])
                vga_rgb <= color;
            else if (x[12] & y[12] & R_b[12][12])
                vga_rgb <= color;            
            else if (x[13] & y[12] & R_b[12][13])
                 vga_rgb <= color;
            else if (x[14] & y[12] & R_b[12][14])
                 vga_rgb <= color;
            else if (x[15] & y[12] & R_b[12][15])
                 vga_rgb <= color;        
            else if (x[16] & y[12] & R_b[12][16])
                 vga_rgb <= color;
            else if (x[17] & y[12] & R_b[12][17])
                 vga_rgb <= color;
            else if (x[18] & y[12] & R_b[12][18])
                 vga_rgb <= color;
            else if (x[19] & y[12] & R_b[12][19])
                vga_rgb <= color;

            else if (x[0] & y[13] & R_b[13][0])
                vga_rgb <= color;
            else if (x[1] & y[13] & R_b[13][1])
                vga_rgb <= color;
            else if (x[2] & y[13] & R_b[13][2])
                vga_rgb <= color;            
            else if (x[3] & y[13] & R_b[13][3])
                 vga_rgb <= color;
            else if (x[4] & y[13] & R_b[13][4])
                 vga_rgb <= color;
            else if (x[5] & y[13] & R_b[13][5])
                 vga_rgb <= color;        
            else if (x[6] & y[13] & R_b[13][6])
                 vga_rgb <= color;
            else if (x[7] & y[13] & R_b[13][7])
                 vga_rgb <= color;
            else if (x[8] & y[13] & R_b[13][8])
                 vga_rgb <= color;
            else if (x[9] & y[13] & R_b[13][9])
                vga_rgb <= color;
            else if (x[10] & y[13] &R_b[13][10])
                vga_rgb <= color;
            else if (x[11] & y[13] & R_b[13][11])
                vga_rgb <= color;
            else if (x[12] & y[13] & R_b[13][12])
                vga_rgb <= color;            
            else if (x[13] & y[13] & R_b[13][13])
                 vga_rgb <= color;
            else if (x[14] & y[13] & R_b[13][14])
                 vga_rgb <= color;
            else if (x[15] & y[13] & R_b[13][15])
                 vga_rgb <= color;        
            else if (x[16] & y[13] & R_b[13][16])
                 vga_rgb <= color;
            else if (x[17] & y[13] & R_b[13][17])
                 vga_rgb <= color;
            else if (x[18] & y[13] & R_b[13][18])
                 vga_rgb <= color;
            else if (x[19] & y[13] & R_b[13][19])
                vga_rgb <= color;

            else if (x[0] & y[14] & R_b[14][0])
                vga_rgb <= color;
            else if (x[1] & y[14] & R_b[14][1])
                vga_rgb <= color;
            else if (x[2] & y[14] & R_b[14][2])
                vga_rgb <= color;            
            else if (x[3] & y[14] & R_b[14][3])
                 vga_rgb <= color;
            else if (x[4] & y[14] & R_b[14][4])
                 vga_rgb <= color;
            else if (x[5] & y[14] & R_b[14][5])
                 vga_rgb <= color;        
            else if (x[6] & y[14] & R_b[14][6])
                 vga_rgb <= color;
            else if (x[7] & y[14] & R_b[14][7])
                 vga_rgb <= color;
            else if (x[8] & y[14] & R_b[14][8])
                 vga_rgb <= color;
            else if (x[9] & y[14] & R_b[14][9])
                vga_rgb <= color;
            else if (x[10] & y[14] &R_b[14][10])
                vga_rgb <= color;
            else if (x[11] & y[14] & R_b[14][11])
                vga_rgb <= color;
            else if (x[12] & y[14] & R_b[14][12])
                vga_rgb <= color;            
            else if (x[13] & y[14] & R_b[14][13])
                 vga_rgb <= color;
            else if (x[14] & y[14] & R_b[14][14])
                 vga_rgb <= color;
            else if (x[15] & y[14] & R_b[14][15])
                 vga_rgb <= color;        
            else if (x[16] & y[14] & R_b[14][16])
                 vga_rgb <= color;
            else if (x[17] & y[14] & R_b[14][17])
                 vga_rgb <= color;
            else if (x[18] & y[14] & R_b[14][18])
                 vga_rgb <= color;
            else if (x[19] & y[14] & R_b[14][19])
                vga_rgb <= color;

            else if (x[0] & y[15] & R_b[15][0])
                vga_rgb <= color;
            else if (x[1] & y[15] & R_b[15][1])
                vga_rgb <= color;
            else if (x[2] & y[15] & R_b[15][2])
                vga_rgb <= color;            
            else if (x[3] & y[15] & R_b[15][3])
                 vga_rgb <= color;
            else if (x[4] & y[15] & R_b[15][4])
                 vga_rgb <= color;
            else if (x[5] & y[15] & R_b[15][5])
                 vga_rgb <= color;        
            else if (x[6] & y[15] & R_b[15][6])
                 vga_rgb <= color;
            else if (x[7] & y[15] & R_b[15][7])
                 vga_rgb <= color;
            else if (x[8] & y[15] & R_q[15][8])
                vga_rgb <= 12'b000011111111;       
            else if (x[8] & y[15] & R_b[15][8])
                 vga_rgb <= color;
            else if (x[9] & y[15] & R_b[15][9])
                vga_rgb <= color;
            else if (x[10] & y[15] &R_b[15][10])
                vga_rgb <= color;
            else if (x[11] & y[15] & R_b[15][11])
                vga_rgb <= color;
            else if (x[12] & y[15] & R_b[15][12])
                vga_rgb <= color;            
            else if (x[13] & y[15] & R_b[15][13])
                 vga_rgb <= color;
            else if (x[14] & y[15] & R_b[15][14])
                 vga_rgb <= color;
            else if (x[15] & y[15] & R_b[15][15])
                 vga_rgb <= color;        
            else if (x[16] & y[15] & R_b[15][16])
                 vga_rgb <= color;
            else if (x[17] & y[15] & R_b[15][17])
                 vga_rgb <= color;
            else if (x[18] & y[15] & R_b[15][18])
                 vga_rgb <= color;
            else if (x[19] & y[15] & R_b[15][19])
                vga_rgb <= color;


            else if (x[0] & y[16] & R_b[16][0])
                vga_rgb <= color;
            else if (x[1] & y[16] & R_b[16][1])
                vga_rgb <= color;
            else if (x[2] & y[16] & R_b[16][2])
                vga_rgb <= color;            
            else if (x[3] & y[16] & R_b[16][3])
                 vga_rgb <= color;
            else if (x[4] & y[16] & R_b[16][4])
                 vga_rgb <= color;
            else if (x[5] & y[16] & R_b[16][5])
                 vga_rgb <= color;        
            else if (x[6] & y[16] & R_b[16][6])
                 vga_rgb <= color;
            else if (x[7] & y[16] & R_b[16][7])
                 vga_rgb <= color;
            else if (x[8] & y[16] & R_b[16][8])
                 vga_rgb <= color;
            else if (x[9] & y[16] & R_q[16][9])
                vga_rgb <= 12'b000011111111;      
            else if (x[9] & y[16] & R_b[16][9])
                vga_rgb <= color;
            else if (x[10] & y[16] &R_b[16][10])
                vga_rgb <= color;
            else if (x[11] & y[16] & R_b[16][11])
                vga_rgb <= color;
            else if (x[12] & y[16] & R_b[16][12])
                vga_rgb <= color;            
            else if (x[13] & y[16] & R_b[16][13])
                 vga_rgb <= color;
            else if (x[14] & y[16] & R_b[16][14])
                 vga_rgb <= color;
            else if (x[15] & y[16] & R_b[16][15])
                 vga_rgb <= color;        
            else if (x[16] & y[16] & R_b[16][16])
                 vga_rgb <= color;
            else if (x[17] & y[16] & R_b[16][17])
                 vga_rgb <= color;
            else if (x[18] & y[16] & R_b[16][18])
                 vga_rgb <= color;
            else if (x[19] & y[16] & R_b[16][19])
                vga_rgb <= color;
                                  
            else if (x[0] & y[17] & R_b[17][0])
                vga_rgb <= color;
            else if (x[1] & y[17] & R_b[17][1])
                vga_rgb <= color;
            else if (x[2] & y[17] & R_b[17][2])
                vga_rgb <= color;            
            else if (x[3] & y[17] & R_b[17][3])
                 vga_rgb <= color;
            else if (x[4] & y[17] & R_b[17][4])
                 vga_rgb <= color;
            else if (x[5] & y[17] & R_b[17][5])
                 vga_rgb <= color;        
            else if (x[6] & y[17] & R_b[17][6])
                 vga_rgb <= color;
            else if (x[7] & y[17] & R_b[17][7])
                 vga_rgb <= color;
            else if (x[8] & y[17] & R_b[17][8])
                 vga_rgb <= color;
            else if (x[9] & y[17] & R_b[17][9])
                vga_rgb <= color;
            else if (x[10] & y[17] &R_b[17][10])
                vga_rgb <= color;
            else if (x[11] & y[17] & R_b[17][11])
                vga_rgb <= color;
            else if (x[12] & y[17] & R_b[17][12])
                vga_rgb <= color;            
            else if (x[13] & y[17] & R_b[17][13])
                 vga_rgb <= color;
            else if (x[14] & y[17] & R_b[17][14])
                 vga_rgb <= color;
            else if (x[15] & y[17] & R_b[17][15])
                 vga_rgb <= color;        
            else if (x[16] & y[17] & R_b[17][16])
                 vga_rgb <= color;
            else if (x[17] & y[17] & R_b[17][17])
                 vga_rgb <= color;
            else if (x[18] & y[17] & R_b[17][18])
                 vga_rgb <= color;
            else if (x[19] & y[17] & R_b[17][19])
                vga_rgb <= color;


            else if (x[0] & y[18] & R_b[18][0])
                vga_rgb <= color;
            else if (x[1] & y[18] & R_b[18][1])
                vga_rgb <= color;
            else if (x[2] & y[18] & R_b[18][2])
                vga_rgb <= color;            
            else if (x[3] & y[18] & R_b[18][3])
                 vga_rgb <= color;
            else if (x[4] & y[18] & R_b[18][4])
                 vga_rgb <= color;
            else if (x[5] & y[18] & R_b[18][5])
                 vga_rgb <= color;        
            else if (x[6] & y[18] & R_b[18][6])
                 vga_rgb <= color;
            else if (x[7] & y[18] & R_b[18][7])
                 vga_rgb <= color;
            else if (x[8] & y[18] & R_b[18][8])
                 vga_rgb <= color;
            else if (x[9] & y[18] & R_b[18][9])
                vga_rgb <= color;
            else if (x[10] & y[18] &R_b[18][10])
                vga_rgb <= color;
            else if (x[11] & y[18] & R_b[18][11])
                vga_rgb <= color;
            else if (x[12] & y[18] & R_b[18][12])
                vga_rgb <= color;            
            else if (x[13] & y[18] & R_b[18][13])
                 vga_rgb <= color;
            else if (x[14] & y[18] & R_b[18][14])
                 vga_rgb <= color;
            else if (x[15] & y[18] & R_b[18][15])
                 vga_rgb <= color;        
            else if (x[16] & y[18] & R_b[18][16])
                 vga_rgb <= color;
            else if (x[17] & y[18] & R_b[18][17])
                 vga_rgb <= color;
            else if (x[18] & y[18] & R_b[18][18])
                 vga_rgb <= color;
            else if (x[19] & y[18] & R_b[18][19])
                vga_rgb <= color;            


            else if (x[0] & y[19] & R_b[19][0])
                vga_rgb <= color;
            else if (x[1] & y[19] & R_b[19][1])
                vga_rgb <= color;
            else if (x[2] & y[19] & R_b[19][2])
                vga_rgb <= color;            
            else if (x[3] & y[19] & R_b[19][3])
                 vga_rgb <= color;
            else if (x[4] & y[19] & R_b[19][4])
                 vga_rgb <= color;
            else if (x[5] & y[19] & R_b[19][5])
                 vga_rgb <= color;        
            else if (x[6] & y[19] & R_b[19][6])
                 vga_rgb <= color;
            else if (x[7] & y[19] & R_b[19][7])
                 vga_rgb <= color;
            else if (x[8] & y[19] & R_b[19][8])
                 vga_rgb <= color;
            else if (x[9] & y[19] & R_b[19][9])
                vga_rgb <= color;
            else if (x[10] & y[19] &R_b[19][10])
                vga_rgb <= color;
            else if (x[11] & y[19] & R_b[19][11])
                vga_rgb <= color;
            else if (x[12] & y[19] & R_b[19][12])
                vga_rgb <= color;            
            else if (x[13] & y[19] & R_b[19][13])
                 vga_rgb <= color;
            else if (x[14] & y[19] & R_b[19][14])
                 vga_rgb <= color;
            else if (x[15] & y[19] & R_b[19][15])
                 vga_rgb <= color;        
            else if (x[16] & y[19] & R_b[19][16])
                 vga_rgb <= color;
            else if (x[17] & y[19] & R_b[19][17])
                 vga_rgb <= color;
            else if (x[18] & y[19] & R_b[19][18])
                 vga_rgb <= color;
            else if (x[19] & y[19] & R_b[19][19])
                vga_rgb <= color;
                
            else if (x[0] & y[20] & R_b[20][0])
                vga_rgb <= color;
            else if (x[1] & y[20] & R_b[20][1])
                vga_rgb <= color;
            else if (x[2] & y[20] & R_b[20][2])
                vga_rgb <= color;            
            else if (x[3] & y[20] & R_b[20][3])
                 vga_rgb <= color;
            else if (x[4] & y[20] & R_b[20][4])
                 vga_rgb <= color;
            else if (x[5] & y[20] & R_b[20][5])
                 vga_rgb <= color;        
            else if (x[6] & y[20] & R_b[20][6])
                 vga_rgb <= color;
            else if (x[7] & y[20] & R_b[20][7])
                 vga_rgb <= color;
            else if (x[8] & y[20] & R_b[20][8])
                 vga_rgb <= color;
            else if (x[9] & y[20] & R_b[20][9])
                vga_rgb <= color;
            else if (x[10] & y[20] &R_b[20][10])
                vga_rgb <= color;
            else if (x[11] & y[20] & R_b[20][11])
                vga_rgb <= color;
            else if (x[12] & y[20] & R_b[20][12])
                vga_rgb <= color;            
            else if (x[13] & y[20] & R_b[20][13])
                 vga_rgb <= color;
            else if (x[14] & y[20] & R_b[20][14])
                 vga_rgb <= color;
            else if (x[15] & y[20] & R_b[20][15])
                 vga_rgb <= color;        
            else if (x[16] & y[20] & R_b[20][16])
                 vga_rgb <= color;
            else if (x[17] & y[20] & R_b[20][17])
                 vga_rgb <= color;
            else if (x[18] & y[20] & R_b[20][18])
                 vga_rgb <= color;
            else if (x[19] & y[20] & R_b[20][19])
                vga_rgb <= color;

            else if (x[0] & y[21] & R_b[21][0])
                vga_rgb <= color;
            else if (x[1] & y[21] & R_b[21][1])
                vga_rgb <= color;
            else if (x[2] & y[21] & R_b[21][2])
                vga_rgb <= color;            
            else if (x[3] & y[21] & R_b[21][3])
                 vga_rgb <= color;
            else if (x[4] & y[21] & R_b[21][4])
                 vga_rgb <= color;
            else if (x[5] & y[21] & R_b[21][5])
                 vga_rgb <= color;        
            else if (x[6] & y[21] & R_b[21][6])
                 vga_rgb <= color;
            else if (x[7] & y[21] & R_b[21][7])
                 vga_rgb <= color;
            else if (x[8] & y[21] & R_b[21][8])
                 vga_rgb <= color;     
            else if (x[9] & y[21] & R_b[21][9])
                vga_rgb <= color;
            else if (x[10] & y[21] &R_b[21][10])
                vga_rgb <= color;
            else if (x[11] & y[21] & R_b[21][11])
                vga_rgb <= color;
            else if (x[12] & y[21] & R_b[21][12])
                vga_rgb <= color;            
            else if (x[13] & y[21] & R_b[21][13])
                 vga_rgb <= color;
            else if (x[14] & y[21] & R_b[21][14])
                 vga_rgb <= color;
            else if (x[15] & y[21] & R_b[21][15])
                 vga_rgb <= color;        
            else if (x[16] & y[21] & R_b[21][16])
                 vga_rgb <= color;
            else if (x[17] & y[21] & R_b[21][17])
                 vga_rgb <= color;
            else if (x[18] & y[21] & R_b[21][18])
                 vga_rgb <= color;
            else if (x[19] & y[21] & R_b[21][19])
                vga_rgb <= color;     
            
            else if (x[0] & y[22] & R_b[22][0])
                vga_rgb <= color;
            else if (x[1] & y[22] & R_b[22][1])
                vga_rgb <= color;
            else if (x[2] & y[22] & R_b[22][2])
                vga_rgb <= color;            
            else if (x[3] & y[22] & R_b[22][3])
                 vga_rgb <= color;
            else if (x[4] & y[22] & R_b[22][4])
                 vga_rgb <= color;
            else if (x[5] & y[22] & R_b[22][5])
                 vga_rgb <= color;        
            else if (x[6] & y[22] & R_b[22][6])
                 vga_rgb <= color;
            else if (x[7] & y[22] & R_b[22][7])
                 vga_rgb <= color;
            else if (x[8] & y[22] & R_b[22][8])
                 vga_rgb <= color;
            else if (x[9] & y[22] & R_b[22][9])
                vga_rgb <= color;
            else if (x[10] & y[22] &R_b[22][10])
                vga_rgb <= color;
            else if (x[11] & y[22] & R_b[22][11])
                vga_rgb <= color;
            else if (x[12] & y[22] & R_b[22][12])
                vga_rgb <= color;            
            else if (x[13] & y[22] & R_b[22][13])
                 vga_rgb <= color;
            else if (x[14] & y[22] & R_b[22][14])
                 vga_rgb <= color;
            else if (x[15] & y[22] & R_b[22][15])
                 vga_rgb <= color;        
            else if (x[16] & y[22] & R_b[22][16])
                 vga_rgb <= color;
            else if (x[17] & y[22] & R_b[22][17])
                 vga_rgb <= color;
            else if (x[18] & y[22] & R_b[22][18])
                 vga_rgb <= color;
            else if (x[19] & y[22] & R_b[22][19])
                vga_rgb <= color;

            else if (x[0] & y[23] & R_b[23][0])
                vga_rgb <= color;
            else if (x[1] & y[23] & R_b[23][1])
                vga_rgb <= color;
            else if (x[2] & y[23] & R_b[23][2])
                vga_rgb <= color;            
            else if (x[3] & y[23] & R_b[23][3])
                 vga_rgb <= color;
            else if (x[4] & y[23] & R_b[23][4])
                 vga_rgb <= color;
            else if (x[5] & y[23] & R_b[23][5])
                 vga_rgb <= color;        
            else if (x[6] & y[23] & R_b[23][6])
                 vga_rgb <= color;
            else if (x[7] & y[23] & R_b[23][7])
                 vga_rgb <= color;
            else if (x[8] & y[23] & R_b[23][8])
                 vga_rgb <= color;
            else if (x[9] & y[23] & R_b[23][9])
                vga_rgb <= color;
            else if (x[10] & y[23] &R_b[23][10])
                vga_rgb <= color;
            else if (x[11] & y[23] & R_b[23][11])
                vga_rgb <= color;
            else if (x[12] & y[23] & R_b[23][12])
                vga_rgb <= color;            
            else if (x[13] & y[23] & R_b[23][13])
                 vga_rgb <= color;
            else if (x[14] & y[23] & R_b[23][14])
                 vga_rgb <= color;
            else if (x[15] & y[23] & R_b[23][15])
                 vga_rgb <= color;        
            else if (x[16] & y[23] & R_b[23][16])
                 vga_rgb <= color;
            else if (x[17] & y[23] & R_b[23][17])
                 vga_rgb <= color;
            else if (x[18] & y[23] & R_b[23][18])
                 vga_rgb <= color;
            else if (x[19] & y[23] & R_b[23][19])
                vga_rgb <= color;

            else if (x[0] & y[24] & R_b[24][0])
                vga_rgb <= color;
            else if (x[1] & y[24] & R_b[24][1])
                vga_rgb <= color;
            else if (x[2] & y[24] & R_b[24][2])
                vga_rgb <= color;            
            else if (x[3] & y[24] & R_b[24][3])
                 vga_rgb <= color;
            else if (x[4] & y[24] & R_b[24][4])
                 vga_rgb <= color;
            else if (x[5] & y[24] & R_b[24][5])
                 vga_rgb <= color;        
            else if (x[6] & y[24] & R_b[24][6])
                 vga_rgb <= color;
            else if (x[7] & y[24] & R_b[24][7])
                 vga_rgb <= color;
            else if (x[8] & y[24] & R_b[24][8])
                 vga_rgb <= color;
            else if (x[9] & y[24] & R_b[24][9])
                vga_rgb <= color;
            else if (x[10] & y[24] &R_b[24][10])
                vga_rgb <= color;
            else if (x[11] & y[24] & R_b[24][11])
                vga_rgb <= color;
            else if (x[12] & y[24] & R_b[24][12])
                vga_rgb <= color;
            else if (x[13] & y[24] & R_q[24][13])
                vga_rgb <= 12'b000011111111;                  
            else if (x[13] & y[24] & R_b[24][13])
                 vga_rgb <= color;
            else if (x[14] & y[24] & R_b[24][14])
                 vga_rgb <= color;
            else if (x[15] & y[24] & R_b[24][15])
                 vga_rgb <= color;        
            else if (x[16] & y[24] & R_b[24][16])
                 vga_rgb <= color;
            else if (x[17] & y[24] & R_b[24][17])
                 vga_rgb <= color;
            else if (x[18] & y[24] & R_b[24][18])
                 vga_rgb <= color;
            else if (x[19] & y[24] & R_b[24][19])
                vga_rgb <= color;

            else if (x[0] & y[25] & R_b[25][0])
                vga_rgb <= color;
            else if (x[1] & y[25] & R_b[25][1])
                vga_rgb <= color;
            else if (x[2] & y[25] & R_b[25][2])
                vga_rgb <= color;            
            else if (x[3] & y[25] & R_b[25][3])
                 vga_rgb <= color;
            else if (x[4] & y[25] & R_b[25][4])
                 vga_rgb <= color;
            else if (x[5] & y[25] & R_b[25][5])
                 vga_rgb <= color;        
            else if (x[6] & y[25] & R_b[25][6])
                 vga_rgb <= color;
            else if (x[7] & y[25] & R_b[25][7])
                 vga_rgb <= color;
            else if (x[8] & y[25] & R_b[25][8])
                 vga_rgb <= color;
            else if (x[9] & y[25] & R_b[25][9])
                vga_rgb <= color;
            else if (x[10] & y[25] &R_b[25][10])
                vga_rgb <= color;
            else if (x[11] & y[25] & R_b[25][11])
                vga_rgb <= color;
            else if (x[12] & y[25] & R_b[25][12])
                vga_rgb <= color;            
            else if (x[13] & y[25] & R_b[25][13])
                 vga_rgb <= color;
            else if (x[14] & y[25] & R_b[25][14])
                 vga_rgb <= color;
            else if (x[15] & y[25] & R_b[25][15])
                 vga_rgb <= color;        
            else if (x[16] & y[25] & R_b[25][16])
                 vga_rgb <= color;
            else if (x[17] & y[25] & R_b[25][17])
                 vga_rgb <= color;
            else if (x[18] & y[25] & R_b[25][18])
                 vga_rgb <= color;
            else if (x[19] & y[25] & R_b[25][19])
                vga_rgb <= color;

            else if (x[0] & y[26] & R_q[26][0])
                vga_rgb <= 12'b000011111111;  
            else if (x[0] & y[26] & R_b[26][0])
                vga_rgb <= color;
            else if (x[1] & y[26] & R_b[26][1])
                vga_rgb <= color;
            else if (x[2] & y[26] & R_b[26][2])
                vga_rgb <= color;            
            else if (x[3] & y[26] & R_b[26][3])
                 vga_rgb <= color;
            else if (x[4] & y[26] & R_b[26][4])
                 vga_rgb <= color;
            else if (x[5] & y[26] & R_b[26][5])
                 vga_rgb <= color;        
            else if (x[6] & y[26] & R_b[26][6])
                 vga_rgb <= color;
            else if (x[7] & y[26] & R_b[26][7])
                 vga_rgb <= color;
            else if (x[8] & y[26] & R_b[26][8])
                 vga_rgb <= color;      
            else if (x[9] & y[26] & R_b[26][9])
                vga_rgb <= color;
            else if (x[10] & y[26] &R_b[26][10])
                vga_rgb <= color;
            else if (x[11] & y[26] & R_b[26][11])
                vga_rgb <= color;
            else if (x[12] & y[26] & R_b[26][12])
                vga_rgb <= color;            
            else if (x[13] & y[26] & R_b[26][13])
                 vga_rgb <= color;
            else if (x[14] & y[26] & R_b[26][14])
                 vga_rgb <= color;
            else if (x[15] & y[26] & R_b[26][15])
                 vga_rgb <= color;        
            else if (x[16] & y[26] & R_b[26][16])
                 vga_rgb <= color;
            else if (x[17] & y[26] & R_b[26][17])
                 vga_rgb <= color;
            else if (x[18] & y[26] & R_b[26][18])
                 vga_rgb <= color;
            else if (x[19] & y[26] & R_b[26][19])
                vga_rgb <= color;
                                  
            else if (x[0] & y[27] & R_b[27][0])
                vga_rgb <= color;
            else if (x[1] & y[27] & R_b[27][1])
                vga_rgb <= color;
            else if (x[2] & y[27] & R_b[27][2])
                vga_rgb <= color;            
            else if (x[3] & y[27] & R_b[27][3])
                 vga_rgb <= color;
            else if (x[4] & y[27] & R_b[27][4])
                 vga_rgb <= color;
            else if (x[5] & y[27] & R_b[27][5])
                 vga_rgb <= color;        
            else if (x[6] & y[27] & R_b[27][6])
                 vga_rgb <= color;
            else if (x[7] & y[27] & R_b[27][7])
                 vga_rgb <= color;
            else if (x[8] & y[27] & R_b[27][8])
                 vga_rgb <= color;
            else if (x[9] & y[27] & R_b[27][9])
                vga_rgb <= color;
            else if (x[10] & y[27] &R_b[27][10])
                vga_rgb <= color;
            else if (x[11] & y[27] & R_b[27][11])
                vga_rgb <= color;
            else if (x[12] & y[27] & R_b[27][12])
                vga_rgb <= color;            
            else if (x[13] & y[27] & R_b[27][13])
                 vga_rgb <= color;
            else if (x[14] & y[27] & R_b[27][14])
                 vga_rgb <= color;
            else if (x[15] & y[27] & R_b[27][15])
                 vga_rgb <= color;        
            else if (x[16] & y[27] & R_b[27][16])
                 vga_rgb <= color;
            else if (x[17] & y[27] & R_b[27][17])
                 vga_rgb <= color;
            else if (x[18] & y[27] & R_b[27][18])
                 vga_rgb <= color;
            else if (x[19] & y[27] & R_b[27][19])
                vga_rgb <= color;


            else if (x[0] & y[28] & R_b[28][0])
                vga_rgb <= color;
            else if (x[1] & y[28] & R_b[28][1])
                vga_rgb <= color;
            else if (x[2] & y[28] & R_b[28][2])
                vga_rgb <= color;            
            else if (x[3] & y[28] & R_b[28][3])
                 vga_rgb <= color;
            else if (x[4] & y[28] & R_b[28][4])
                 vga_rgb <= color;
            else if (x[5] & y[28] & R_b[28][5])
                 vga_rgb <= color;        
            else if (x[6] & y[28] & R_b[28][6])
                 vga_rgb <= color;
            else if (x[7] & y[28] & R_b[28][7])
                 vga_rgb <= color;
            else if (x[8] & y[28] & R_b[28][8])
                 vga_rgb <= color;
            else if (x[9] & y[28] & R_b[28][9])
                vga_rgb <= color;
            else if (x[10] & y[28] &R_b[28][10])
                vga_rgb <= color;
            else if (x[11] & y[28] & R_b[28][11])
                vga_rgb <= color;
            else if (x[12] & y[28] & R_b[28][12])
                vga_rgb <= color;            
            else if (x[13] & y[28] & R_b[28][13])
                 vga_rgb <= color;
            else if (x[14] & y[28] & R_b[28][14])
                 vga_rgb <= color;
            else if (x[15] & y[28] & R_b[28][15])
                 vga_rgb <= color;        
            else if (x[16] & y[28] & R_b[28][16])
                 vga_rgb <= color;
            else if (x[17] & y[28] & R_b[28][17])
                 vga_rgb <= color;
            else if (x[18] & y[28] & R_b[28][18])
                 vga_rgb <= color;
            else if (x[19] & y[28] & R_b[28][19])
                vga_rgb <= color;            


            else if (x[0] & y[29] & R_b[29][0])
                vga_rgb <= color;
            else if (x[1] & y[29] & R_b[29][1])
                vga_rgb <= color;
            else if (x[2] & y[29] & R_b[29][2])
                vga_rgb <= color;            
            else if (x[3] & y[29] & R_b[29][3])
                 vga_rgb <= color;
            else if (x[4] & y[29] & R_b[29][4])
                 vga_rgb <= color;
            else if (x[5] & y[29] & R_b[29][5])
                 vga_rgb <= color;        
            else if (x[6] & y[29] & R_b[29][6])
                 vga_rgb <= color;
            else if (x[7] & y[29] & R_b[29][7])
                 vga_rgb <= color;
            else if (x[8] & y[29] & R_q[29][8])
                vga_rgb <= 12'b000011111111;       
            else if (x[8] & y[29] & R_b[29][8])
                 vga_rgb <= color;
            else if (x[9] & y[29] & R_b[29][9])
                vga_rgb <= color;
            else if (x[10] & y[29] &R_b[29][10])
                vga_rgb <= color;
            else if (x[11] & y[29] & R_b[29][11])
                vga_rgb <= color;
            else if (x[12] & y[29] & R_b[29][12])
                vga_rgb <= color;            
            else if (x[13] & y[29] & R_b[29][13])
                 vga_rgb <= color;
            else if (x[14] & y[29] & R_b[29][14])
                 vga_rgb <= color;
            else if (x[15] & y[29] & R_b[29][15])
                 vga_rgb <= color;        
            else if (x[16] & y[29] & R_b[29][16])
                 vga_rgb <= color;
            else if (x[17] & y[29] & R_b[29][17])
                 vga_rgb <= color;
            else if (x[18] & y[29] & R_b[29][18])
                 vga_rgb <= color;
            else if (x[19] & y[29] & R_b[29][19])
                vga_rgb <= color;  
                  
            else if (x[0] & y[30] & R_b[30][0])
                vga_rgb <= color;
            else if (x[1] & y[30] & R_b[30][1])
                vga_rgb <= color;
            else if (x[2] & y[30] & R_b[30][2])
                vga_rgb <= color;            
            else if (x[3] & y[30] & R_b[30][3])
                 vga_rgb <= color;
            else if (x[4] & y[30] & R_b[30][4])
                 vga_rgb <= color;
            else if (x[5] & y[30] & R_b[30][5])
                 vga_rgb <= color;        
            else if (x[6] & y[30] & R_b[30][6])
                 vga_rgb <= color;
            else if (x[7] & y[30] & R_b[30][7])
                 vga_rgb <= color;
            else if (x[8] & y[30] & R_b[30][8])
                 vga_rgb <= color;
            else if (x[9] & y[30] & R_b[30][9])
                vga_rgb <= color;
            else if (x[10] & y[30] &R_b[30][10])
                vga_rgb <= color;
            else if (x[11] & y[30] & R_b[30][11])
                vga_rgb <= color;
            else if (x[12] & y[30] & R_b[30][12])
                vga_rgb <= color;            
            else if (x[13] & y[30] & R_b[30][13])
                 vga_rgb <= color;
            else if (x[14] & y[30] & R_b[30][14])
                 vga_rgb <= color;
            else if (x[15] & y[30] & R_b[30][15])
                 vga_rgb <= color;        
            else if (x[16] & y[30] & R_b[30][16])
                 vga_rgb <= color;
            else if (x[17] & y[30] & R_b[30][17])
                 vga_rgb <= color;
            else if (x[18] & y[30] & R_b[30][18])
                 vga_rgb <= color;
            else if (x[19] & y[30] & R_b[30][19])
                vga_rgb <= color;

            else if (x[0] & y[31] & R_b[31][0])
                vga_rgb <= color;
            else if (x[1] & y[31] & R_b[31][1])
                vga_rgb <= color;
            else if (x[2] & y[31] & R_b[31][2])
                vga_rgb <= color;            
            else if (x[3] & y[31] & R_b[31][3])
                 vga_rgb <= color;
            else if (x[4] & y[31] & R_b[31][4])
                 vga_rgb <= color;
            else if (x[5] & y[31] & R_b[31][5])
                 vga_rgb <= color;        
            else if (x[6] & y[31] & R_b[31][6])
                 vga_rgb <= color;
            else if (x[7] & y[31] & R_b[31][7])
                 vga_rgb <= color;
            else if (x[8] & y[31] & R_b[31][8])
                 vga_rgb <= color;     
            else if (x[9] & y[31] & R_b[31][9])
                vga_rgb <= color;
            else if (x[10] & y[31] &R_b[31][10])
                vga_rgb <= color;
            else if (x[11] & y[31] & R_b[31][11])
                vga_rgb <= color;
            else if (x[12] & y[31] & R_b[31][12])
                vga_rgb <= color;            
            else if (x[13] & y[31] & R_b[31][13])
                 vga_rgb <= color;
            else if (x[14] & y[31] & R_b[31][14])
                 vga_rgb <= color;
            else if (x[15] & y[31] & R_b[31][15])
                 vga_rgb <= color;        
            else if (x[16] & y[31] & R_b[31][16])
                 vga_rgb <= color;
            else if (x[17] & y[31] & R_b[31][17])
                 vga_rgb <= color;
            else if (x[18] & y[31] & R_b[31][18])
                 vga_rgb <= color;
            else if (x[19] & y[31] & R_b[31][19])
                vga_rgb <= color;     
            
            else if (x[0] & y[32] & R_b[32][0])
                vga_rgb <= color;
            else if (x[1] & y[32] & R_b[32][1])
                vga_rgb <= color;
            else if (x[2] & y[32] & R_b[32][2])
                vga_rgb <= color;            
            else if (x[3] & y[32] & R_b[32][3])
                 vga_rgb <= color;
            else if (x[4] & y[32] & R_b[32][4])
                 vga_rgb <= color;
            else if (x[5] & y[32] & R_b[32][5])
                 vga_rgb <= color;        
            else if (x[6] & y[32] & R_b[32][6])
                 vga_rgb <= color;
            else if (x[7] & y[32] & R_b[32][7])
                 vga_rgb <= color;
            else if (x[8] & y[32] & R_b[32][8])
                 vga_rgb <= color;
            else if (x[9] & y[32] & R_b[32][9])
                vga_rgb <= color;
            else if (x[10] & y[32] &R_b[32][10])
                vga_rgb <= color;
            else if (x[11] & y[32] & R_b[32][11])
                vga_rgb <= color;
            else if (x[12] & y[32] & R_b[32][12])
                vga_rgb <= color;            
            else if (x[13] & y[32] & R_b[32][13])
                 vga_rgb <= color;
            else if (x[14] & y[32] & R_q[32][14])
                vga_rgb <= 12'b000011111111;       
            else if (x[14] & y[32] & R_b[32][14])
                 vga_rgb <= color;
            else if (x[15] & y[32] & R_b[32][15])
                 vga_rgb <= color;        
            else if (x[16] & y[32] & R_b[32][16])
                 vga_rgb <= color;
            else if (x[17] & y[32] & R_b[32][17])
                 vga_rgb <= color;
            else if (x[18] & y[32] & R_b[32][18])
                 vga_rgb <= color;
            else if (x[19] & y[32] & R_b[32][19])
                vga_rgb <= color;

            else if (x[0] & y[33] & R_b[33][0])
                vga_rgb <= color;
            else if (x[1] & y[33] & R_b[33][1])
                vga_rgb <= color;
            else if (x[2] & y[33] & R_b[33][2])
                vga_rgb <= color;            
            else if (x[3] & y[33] & R_b[33][3])
                 vga_rgb <= color;
            else if (x[4] & y[33] & R_b[33][4])
                 vga_rgb <= color;
            else if (x[5] & y[33] & R_b[33][5])
                 vga_rgb <= color;        
            else if (x[6] & y[33] & R_b[33][6])
                 vga_rgb <= color;
            else if (x[7] & y[33] & R_b[33][7])
                 vga_rgb <= color;
            else if (x[8] & y[33] & R_b[33][8])
                 vga_rgb <= color;
            else if (x[9] & y[33] & R_b[33][9])
                vga_rgb <= color;
            else if (x[10] & y[33] &R_b[33][10])
                vga_rgb <= color;
            else if (x[11] & y[33] & R_b[33][11])
                vga_rgb <= color;
            else if (x[12] & y[33] & R_b[33][12])
                vga_rgb <= color;            
            else if (x[13] & y[33] & R_b[33][13])
                 vga_rgb <= color;
            else if (x[14] & y[33] & R_b[33][14])
                 vga_rgb <= color;
            else if (x[15] & y[33] & R_b[33][15])
                 vga_rgb <= color;        
            else if (x[16] & y[33] & R_b[33][16])
                 vga_rgb <= color;
            else if (x[17] & y[33] & R_b[33][17])
                 vga_rgb <= color;
            else if (x[18] & y[33] & R_b[33][18])
                 vga_rgb <= color;
            else if (x[19] & y[33] & R_b[33][19])
                vga_rgb <= color;

            else if (x[0] & y[34] & R_b[34][0])
                vga_rgb <= color;
            else if (x[1] & y[34] & R_b[34][1])
                vga_rgb <= color;
            else if (x[2] & y[34] & R_b[34][2])
                vga_rgb <= color;            
            else if (x[3] & y[34] & R_b[34][3])
                 vga_rgb <= color;
            else if (x[4] & y[34] & R_b[34][4])
                 vga_rgb <= color;
            else if (x[5] & y[34] & R_b[34][5])
                 vga_rgb <= color;        
            else if (x[6] & y[34] & R_b[34][6])
                 vga_rgb <= color;
            else if (x[7] & y[34] & R_b[34][7])
                 vga_rgb <= color;
            else if (x[8] & y[34] & R_b[34][8])
                 vga_rgb <= color;
            else if (x[9] & y[34] & R_b[34][9])
                vga_rgb <= color;
            else if (x[10] & y[34] &R_b[34][10])
                vga_rgb <= color;
            else if (x[11] & y[34] & R_b[34][11])
                vga_rgb <= color;
            else if (x[12] & y[34] & R_b[34][12])
                vga_rgb <= color;            
            else if (x[13] & y[34] & R_b[34][13])
                 vga_rgb <= color;
            else if (x[14] & y[34] & R_b[34][14])
                 vga_rgb <= color;
            else if (x[15] & y[34] & R_b[34][15])
                 vga_rgb <= color;        
            else if (x[16] & y[34] & R_b[34][16])
                 vga_rgb <= color;
            else if (x[17] & y[34] & R_b[34][17])
                 vga_rgb <= color;
            else if (x[18] & y[34] & R_b[34][18])
                 vga_rgb <= color;
            else if (x[19] & y[34] & R_b[34][19])
                vga_rgb <= color;

            else if (x[0] & y[35] & R_b[35][0])
                vga_rgb <= color;
            else if (x[1] & y[35] & R_b[35][1])
                vga_rgb <= color;
            else if (x[2] & y[35] & R_b[35][2])
                vga_rgb <= color;            
            else if (x[3] & y[35] & R_b[35][3])
                 vga_rgb <= color;
            else if (x[4] & y[35] & R_b[35][4])
                 vga_rgb <= color;
            else if (x[5] & y[35] & R_b[35][5])
                 vga_rgb <= color; 
            else if (x[6] & y[35] & R_q[35][6])
                vga_rgb <= 12'b000011111111;              
            else if (x[6] & y[35] & R_b[35][6])
                 vga_rgb <= color;
            else if (x[7] & y[35] & R_b[35][7])
                 vga_rgb <= color;
            else if (x[8] & y[35] & R_b[35][8])
                 vga_rgb <= color;
            else if (x[9] & y[35] & R_b[35][9])
                vga_rgb <= color;
            else if (x[10] & y[35] &R_b[35][10])
                vga_rgb <= color;
            else if (x[11] & y[35] & R_b[35][11])
                vga_rgb <= color;
            else if (x[12] & y[35] & R_b[35][12])
                vga_rgb <= color;            
            else if (x[13] & y[35] & R_b[35][13])
                 vga_rgb <= color;
            else if (x[14] & y[35] & R_b[35][14])
                 vga_rgb <= color;
            else if (x[15] & y[35] & R_b[35][15])
                 vga_rgb <= color;        
            else if (x[16] & y[35] & R_b[35][16])
                 vga_rgb <= color;
            else if (x[17] & y[35] & R_b[35][17])
                 vga_rgb <= color;
            else if (x[18] & y[35] & R_b[35][18])
                 vga_rgb <= color;
            else if (x[19] & y[35] & R_b[35][19])
                vga_rgb <= color;


            else if (x[0] & y[36] & R_b[36][0])
                vga_rgb <= color;
            else if (x[1] & y[36] & R_b[36][1])
                vga_rgb <= color;
            else if (x[2] & y[36] & R_b[36][2])
                vga_rgb <= color;            
            else if (x[3] & y[36] & R_b[36][3])
                 vga_rgb <= color;
            else if (x[4] & y[36] & R_b[36][4])
                 vga_rgb <= color;
            else if (x[5] & y[36] & R_b[36][5])
                 vga_rgb <= color;        
            else if (x[6] & y[36] & R_b[36][6])
                 vga_rgb <= color;
            else if (x[7] & y[36] & R_b[36][7])
                 vga_rgb <= color;
            else if (x[8] & y[36] & R_b[36][8])
                 vga_rgb <= color;      
            else if (x[9] & y[36] & R_b[36][9])
                vga_rgb <= color;
            else if (x[10] & y[36] &R_b[36][10])
                vga_rgb <= color;
            else if (x[11] & y[36] & R_b[36][11])
                vga_rgb <= color;
            else if (x[12] & y[36] & R_b[36][12])
                vga_rgb <= color;            
            else if (x[13] & y[36] & R_b[36][13])
                 vga_rgb <= color;
            else if (x[14] & y[36] & R_b[36][14])
                 vga_rgb <= color;
            else if (x[15] & y[36] & R_b[36][15])
                 vga_rgb <= color;        
            else if (x[16] & y[36] & R_b[36][16])
                 vga_rgb <= color;
            else if (x[17] & y[36] & R_b[36][17])
                 vga_rgb <= color;
            else if (x[18] & y[36] & R_b[36][18])
                 vga_rgb <= color;
            else if (x[19] & y[36] & R_b[36][19])
                vga_rgb <= color;
                                  
            else if (x[0] & y[37] & R_b[37][0])
                vga_rgb <= color;
            else if (x[1] & y[37] & R_b[37][1])
                vga_rgb <= color;
            else if (x[2] & y[37] & R_b[37][2])
                vga_rgb <= color;            
            else if (x[3] & y[37] & R_b[37][3])
                 vga_rgb <= color;
            else if (x[4] & y[37] & R_b[37][4])
                 vga_rgb <= color;
            else if (x[5] & y[37] & R_b[37][5])
                 vga_rgb <= color;        
            else if (x[6] & y[37] & R_b[37][6])
                 vga_rgb <= color;
            else if (x[7] & y[37] & R_b[37][7])
                 vga_rgb <= color;
            else if (x[8] & y[37] & R_b[37][8])
                 vga_rgb <= color;
            else if (x[9] & y[37] & R_b[37][9])
                vga_rgb <= color;
            else if (x[10] & y[37] &R_b[37][10])
                vga_rgb <= color;
            else if (x[11] & y[37] & R_b[37][11])
                vga_rgb <= color;
            else if (x[12] & y[37] & R_b[37][12])
                vga_rgb <= color;            
            else if (x[13] & y[37] & R_b[37][13])
                 vga_rgb <= color;
            else if (x[14] & y[37] & R_b[37][14])
                 vga_rgb <= color;
            else if (x[15] & y[37] & R_b[37][15])
                 vga_rgb <= color;        
            else if (x[16] & y[37] & R_b[37][16])
                 vga_rgb <= color;
            else if (x[17] & y[37] & R_b[37][17])
                 vga_rgb <= color;
            else if (x[18] & y[37] & R_b[37][18])
                 vga_rgb <= color;
            else if (x[19] & y[37] & R_b[37][19])
                vga_rgb <= color;


            else if (x[0] & y[38] & R_b[38][0])
                vga_rgb <= color;
            else if (x[1] & y[38] & R_b[38][1])
                vga_rgb <= color;
            else if (x[2] & y[38] & R_b[38][2])
                vga_rgb <= color;            
            else if (x[3] & y[38] & R_b[38][3])
                 vga_rgb <= color;
            else if (x[4] & y[38] & R_b[38][4])
                 vga_rgb <= color;
            else if (x[5] & y[38] & R_b[38][5])
                 vga_rgb <= color;        
            else if (x[6] & y[38] & R_b[38][6])
                 vga_rgb <= color;
            else if (x[7] & y[38] & R_b[38][7])
                 vga_rgb <= color;
            else if (x[8] & y[38] & R_b[38][8])
                 vga_rgb <= color;
            else if (x[9] & y[38] & R_b[38][9])
                vga_rgb <= color;
            else if (x[10] & y[38] &R_b[38][10])
                vga_rgb <= color;
            else if (x[11] & y[38] & R_b[38][11])
                vga_rgb <= color;
            else if (x[12] & y[38] & R_b[38][12])
                vga_rgb <= color;            
            else if (x[13] & y[38] & R_b[38][13])
                 vga_rgb <= color;
            else if (x[14] & y[38] & R_b[38][14])
                 vga_rgb <= color;
            else if (x[15] & y[38] & R_b[38][15])
                 vga_rgb <= color;        
            else if (x[16] & y[38] & R_b[38][16])
                 vga_rgb <= color;
            else if (x[17] & y[38] & R_b[38][17])
                 vga_rgb <= color;
            else if (x[18] & y[38] & R_b[38][18])
                 vga_rgb <= color;
            else if (x[19] & y[38] & R_b[38][19])
                vga_rgb <= color;            

            else if (x[0] & y[39] & R_b[39][0])
                vga_rgb <= color;
            else if (x[1] & y[39] & R_b[39][1])
                vga_rgb <= color;
            else if (x[2] & y[39] & R_b[39][2])
                vga_rgb <= color;            
            else if (x[3] & y[39] & R_b[39][3])
                 vga_rgb <= color;
            else if (x[4] & y[39] & R_b[39][4])
                 vga_rgb <= color;
            else if (x[5] & y[39] & R_b[39][5])
                 vga_rgb <= color;        
            else if (x[6] & y[39] & R_b[39][6])
                 vga_rgb <= color;
            else if (x[7] & y[39] & R_b[39][7])
                 vga_rgb <= color;
            else if (x[8] & y[39] & R_b[39][8])
                 vga_rgb <= color;
            else if (x[9] & y[39] & R_b[39][9])
                vga_rgb <= color;
            else if (x[10] & y[39] &R_b[39][10])
                vga_rgb <= color;
            else if (x[11] & y[39] & R_b[39][11])
                vga_rgb <= color;
            else if (x[12] & y[39] & R_b[39][12])
                vga_rgb <= color;            
            else if (x[13] & y[39] & R_b[39][13])
                 vga_rgb <= color;
            else if (x[14] & y[39] & R_b[39][14])
                 vga_rgb <= color;
            else if (x[15] & y[39] & R_b[39][15])
                 vga_rgb <= color;        
            else if (x[16] & y[39] & R_b[39][16])
                 vga_rgb <= color;
            else if (x[17] & y[39] & R_q[39][17])
                vga_rgb <= 12'b000011111111;       
            else if (x[17] & y[39] & R_b[39][17])
                 vga_rgb <= color;
            else if (x[18] & y[39] & R_b[39][18])
                 vga_rgb <= color;
            else if (x[19] & y[39] & R_b[39][19])
                vga_rgb <= color;
            else
                vga_rgb <= 12'b000000000000;
                
         else if (ysync >= 35 && ysync < 514) begin
                if (xsync >= 342 && xsync < 344)
                    begin
                        vga_rgb <= 12'b100000000000;
                    end
                else if (xsync > 583 && xsync < 586)
                    begin
                        vga_rgb <= 12'b100000000000;
                    end
                      else
                        vga_rgb <= 12'b0000_0000_0000;  
                end      
         else
            vga_rgb <= 12'b0000_0000_0000;
    end
    else
    begin
      vga_rgb <= 0;
    end
end
  assign r_m = vga_rgb[11:8];
  assign g_m = vga_rgb[7:4];
  assign b_m = vga_rgb[3:0];
  
endmodule
