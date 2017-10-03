`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/06/04 22:55:56
// Design Name: 
// Module Name: jalr_addr
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


module jalr_addr(
input [31:0] iddre,
input  [31:0] rsdata,
output reg  [31:0] data
    );
   always @(*)
   begin
   data=rsdata;
   end
endmodule
