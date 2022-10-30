`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/28 22:15:21
// Design Name: 
// Module Name: mux_vga
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


module mux_vga(
input clk,clr,
input [3:0] r_m,g_m,b_m,r_i,g_i,b_i,r_t,g_t,b_t,
input hsync_i,vsync_i,hsync_m,vsync_m,hsync_t,vsync_t,
input [2:0] vga_control,
input blink,
output reg hsync,vsync,
output reg [3:0] r,g,b
);

always@ (*)
    begin
        case(vga_control)
            0:
            begin
                hsync <= 0;
                vsync <= 0;
                r <= 0;
                g <= 0;
                b <= 0; end
            1:
            begin
                if (!blink) begin
                hsync <= hsync_i;
                vsync <= vsync_i;
                r <= r_i;
                g <= g_i;
                b <= b_i;
                end
                else if (blink) begin
                hsync <= 0;
                vsync <= 0;
                r <= 0;
                g <= 0;
                b <= 0; end
                 end
            2:
            begin
                hsync <= hsync_m;
                vsync <= vsync_m;
                r <= r_m;
                g <= g_m;
                b <= b_m; end
            3:
            begin
                hsync <= hsync_t;
                vsync <= vsync_t;
                r <= r_t;
                g <= g_t;
                b <= b_t;
                 end
           endcase
        end
endmodule