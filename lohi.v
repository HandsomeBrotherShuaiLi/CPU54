`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/06/02 16:49:32
// Design Name: 
// Module Name: lohi
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


module lohi(
input clk,
input rst,
input we,
input mtlo,
input mthi,
input mflo,
input mfhi,
input multu,
input div,
input divu,
input [31:0] a,//rsdata//lo
input [31:0] b,//rtdata//hi
output  [31:0] data_out // gai ming zi
);
    reg [31:0] LO;
    reg [31:0] HI;
    
    initial 
    begin
    LO=32'b0;
    HI=32'b0;
    end
    
    assign data_out=(mfhi==1)?HI:((mflo==1)?LO:32'bz);
    
    always @(negedge clk or posedge rst)
    begin
    if(rst)
    begin
    LO=32'h0;
    HI=32'h0;
    end
    else begin
    if(we) begin
 if(mtlo)
      LO=a;
else if(mthi)
      HI=b;
else if(multu || div || divu)
      begin
    LO=a;
    HI=b;
      end
 end
 end
 end
endmodule
