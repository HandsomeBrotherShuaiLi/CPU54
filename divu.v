`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/06/01 00:29:29
// Design Name: 
// Module Name: divu
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


module divu(
input [31:0]dividend,        //¡À?????               
input [31:0]divisor,          //????      
input start,                //??????¡¤¡§????      
input clock,      
input reset,      
output reg [31:0] q,             //??      
output reg  [31:0] r,             //?¨¤??         
output reg busy
    );
   reg [31:0] tempa;
   reg [31:0] tempb;
   reg [63:0] temp_a;
   reg [63:0] temp_b;
   integer i;
  always @(negedge clock)
   begin
   if(reset)
   begin
   q=0;
   r=0;
   busy=0;
   end
   else if(start)
   begin
   busy=1;
   tempa=dividend;
   tempb=divisor;
   temp_a={32'h00000000,tempa};
   temp_b={tempb,32'h00000000};
   for(i=0;i<32;i=i+1)
   begin
   temp_a={temp_a[62:0],1'b0};
   if(temp_a[63:32]>=tempb)
   temp_a=temp_a-temp_b+1'b1;
   else
   temp_a=temp_a;
   end
   q=temp_a[31:0];
   r=temp_a[63:32];
   end
   end
  endmodule
