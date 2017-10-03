`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/29 22:20:21
// Design Name: 
// Module Name: multu
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


module multu(
input       clk,                               
  input       reset,   
  input  we,                         
  input [31:0]      a,               
 input [31:0]     b,                     
 output [63:0]   z,
 output zero                       
) ; 
reg [63:0] z_reg;
parameter s0=0,s1=1,s2=2;
reg [4:0] count=0;
reg [1:0] state=0;
reg [63:0] p,t;
reg [31:0] b_reg;
assign zero=(z==64'b0)?1:0;
always @ (posedge clk or posedge reset)
begin
if(reset)
begin
z_reg<=0;
count=0;
state=0;
p=0;
t=0;
b_reg=0;
end
else
begin
if(we) begin
case(state)
s0:begin
count<=0;
p<=0;
b_reg<=b;
t<={{32{1'b0}},a};
state<=s1;
end
s1:begin
if(count==5'b11111)
state<=s2;
else begin
if(b_reg[0]==1'b1)
p<=p+t;
else
p<=p;
b_reg<=b_reg>>1;
t<=t<<1;
count<=count+1;
state<=s1;
end
end
s2:begin
z_reg<=p;
state<=s0;
end
default:;
endcase
end
end
end
assign z=z_reg;
endmodule


