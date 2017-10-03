`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 20:39:39
// Design Name: 
// Module Name: MUX5bit2_1
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


module MUX5bit2_1(
   input [4:0]iData0,
   input [4:0]iData1,
   input iS,
   output reg [4:0]oData
    );
   always @(*)
   begin
   if(iS==2'b00)
     oData=iData0;
   else if(iS==2'b01)
     oData=iData1;
   else
     oData=5'b11111;
   end
endmodule

