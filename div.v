`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/29 22:24:32
// Design Name: 
// Module Name: div
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


module div(
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
  always @(posedge clock or posedge reset )
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
   if(dividend[31]==0)
   tempa=dividend;//
   else
   tempa=~dividend+1'b1;//
   if(divisor[31]==0)
   tempb=divisor;
   else
   tempb=~divisor+1'b1;//????¡À???????
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
   if(temp_a[31:0]==0)
   q=temp_a[31:0];
   else
   begin
   if(divisor[31]==dividend[31])
   q={1'b0,temp_a[30:0]};
   else
   q={1'b1,~temp_a[30:0]+1'b1};
   end
   if(dividend[31]==1)
   r={1'b1,~temp_a[62:32]+1};
   else
   r={1'b0,temp_a[62:32]};
   end
   end
  endmodule
