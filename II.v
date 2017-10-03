`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/16 19:59:31
// Design Name: 
// Module Name: II
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


module II(
   input [3:0]PC,
   input [25:0]index,
   output [31:0]addr
    );
    wire [25:0]e_index;
    assign e_index=index-26'b00_00010000_00000000_00000000;
    assign addr={PC,2'b0,e_index};
endmodule
