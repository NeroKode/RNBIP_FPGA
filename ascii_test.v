`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2023 14:30:51
// Design Name: 
// Module Name: ascii_test
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



module ascii_test(
    input clkvga, clk,
    input [7:0] entera, enterd,
    input clk2,
    input video_on,
    input [9:0] x, y,
    output reg [11:0] rgb
    );
    
    // signal declarations
    wire [10:0] rom_addr;           // 11-bit text ROM address
    wire [6:0] ascii_char;          // 7-bit ASCII character code
    wire [3:0] char_row;            // 4-bit row of ASCII character
    wire [2:0] bit_addr;            // column number of ROM data
    wire [7:0] rom_data;            // 8-bit row data from text ROM
    wire ascii_bit, ascii_bit_on;     // ROM bit and status signal
    
    wire [7:0] OP, R1,R2,R3,R4,R5,R6,R7,R8, PC;

    topmodule topmicro( .OP(OP),.R1(R1), .R2(R2),.R3(R3),.R4(R4),.R5(R5),.R6(R6),.R7(R7),.R8(R8),.PC(PC), .clk(clk), .entera(entera), .enterd(enterd), .clk2(clk2));
    
    // instantiate ASCII ROM
    ascii_rom rom(.clkvga(clkvga), .addr(rom_addr), .data(rom_data));
      
    // ASCII ROM interface
    assign rom_addr = {ascii_char, char_row};   // ROM address is ascii code + row
    assign ascii_bit = rom_data[~bit_addr];     // reverse bit order

    //assign ascii_char = {y[5:4], x[7:3]};   // 7-bit ascii code
    assign ascii_char = ((x >= 192 && x < 200) && (y >= 208 && y < 336)) ? 7'h52 : 
                        ((x >= 201 && x < 208) && (y >= 208 && y < 224)) ? 7'h30 :
                        ((x >= 201 && x < 208) && (y >= 224 && y < 240)) ? 7'h31 :
                        ((x >= 201 && x < 208) && (y >= 240 && y < 256)) ? 7'h32 :
                        ((x >= 201 && x < 208) && (y >= 256 && y < 272)) ? 7'h33 :
                        ((x >= 201 && x < 208) && (y >= 272 && y < 288)) ? 7'h34 :
                        ((x >= 201 && x < 208) && (y >= 288 && y < 304)) ? 7'h35 :
                        ((x >= 201 && x < 208) && (y >= 304 && y < 320)) ? 7'h36 :
                        ((x >= 201 && x < 208) && (y >= 320 && y < 336)) ? 7'h37 : 
                        ((x >= 209 && x < 216) && (y >= 208 && y < 336)) ? 7'h3D : 
                        ((x >= 217 && x < 224) && (y >= 208 && y < 224)) ? {3'h3, R1[7:4]} :
                        ((x >= 217 && x < 224) && (y >= 224 && y < 240)) ? {3'h3, R2[7:4]} :
                        ((x >= 217 && x < 224) && (y >= 240 && y < 256)) ? {3'h3, R3[7:4]} :
                        ((x >= 217 && x < 224) && (y >= 256 && y < 272)) ? {3'h3, R4[7:4]} :
                        ((x >= 217 && x < 224) && (y >= 272 && y < 288)) ? {3'h3, R5[7:4]} :
                        ((x >= 217 && x < 224) && (y >= 288 && y < 304)) ? {3'h3, R6[7:4]} :
                        ((x >= 217 && x < 224) && (y >= 304 && y < 320)) ? {3'h3, R7[7:4]} :
                        ((x >= 217 && x < 224) && (y >= 320 && y < 336)) ? {3'h3, R8[7:4]} : 
                        ((x >= 225 && x < 232) && (y >= 208 && y < 224)) ? {3'h3, R1[3:0]} :
                        ((x >= 225 && x < 232) && (y >= 224 && y < 240)) ? {3'h3, R2[3:0]} :
                        ((x >= 225 && x < 232) && (y >= 240 && y < 256)) ? {3'h3, R3[3:0]} :
                        ((x >= 225 && x < 232) && (y >= 256 && y < 272)) ? {3'h3, R4[3:0]} :
                        ((x >= 225 && x < 232) && (y >= 272 && y < 288)) ? {3'h3, R5[3:0]} :
                        ((x >= 225 && x < 232) && (y >= 288 && y < 304)) ? {3'h3, R6[3:0]} :
                        ((x >= 225 && x < 232) && (y >= 304 && y < 320)) ? {3'h3, R7[3:0]} :
                        ((x >= 225 && x < 232) && (y >= 320 && y < 336)) ? {3'h3, R8[3:0]} : 
                        ((x >= 257 && x < 264) && (y >= 240 && y < 256)) ? 7'h50 :
                        ((x >= 265 && x < 272) && (y >= 240 && y < 256)) ? 7'h43 :
                        ((x >= 273 && x < 280) && (y >= 240 && y < 256)) ? 7'h3D :
                        ((x >= 281 && x < 288) && (y >= 240 && y < 256)) ? {3'h3, PC[7:4]}:
                        ((x >= 289 && x < 296) && (y >= 240 && y < 256)) ? {3'h3, PC[3:0]}: 
                        ((x >= 256 && x < 264) && (y >= 256 && y < 272)) ? 7'h4F :
                        ((x >= 265 && x < 272) && (y >= 256 && y < 272)) ? 7'h50 :
                        ((x >= 273 && x < 280) && (y >= 256 && y < 272)) ? 7'h3D :
                        ((x >= 281 && x < 288) && (y >= 256 && y < 272)) ? {3'h3, OP[7:4]}:
                        ((x >= 289 && x < 296) && (y >= 256 && y < 272)) ? {3'h3, OP[3:0]}: 7'b0  ;  
                        
    assign char_row = y[3:0];               // row number of ascii character rom
    assign bit_addr = x[2:0];               // column number of ascii character rom
    // "on" region in center of screen
    //assign ascii_bit_on = ((x >= 192 && x < 448) && (y >= 208 && y < 272)) ? ascii_bit : 1'b0;//if the bit coming from ascii rom
    // is 1, set the pizel on screen coloured
    assign ascii_bit_on = ((x >= 192 && x < 296) && (y >= 208 && y < 336)) ? ascii_bit : 1'b0;
    
    // rgb multiplexing circuit
    always @*
        if(~video_on)
            rgb = 12'h000;      // blank
        else
            if(ascii_bit_on)
                rgb = 12'h00F;  // blue letters
            else
                rgb = 12'hFFF;  // white background           
   
endmodule