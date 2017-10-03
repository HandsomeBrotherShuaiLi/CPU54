`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/29 22:22:18
// Design Name: 
// Module Name: mult
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


module mult(
  input clk,
    input reset,
    input [31:0] a,
    input [31:0] b,
    output reg [63:0] z,
    output zero
    );
    integer k;
    reg signed [32:0] store;
   assign zero=(z==64'b0)?1:0;
    reg signed [32:0] sto_a;
    always @(posedge clk or posedge reset)
    begin
    if(reset) 
      begin
      store=0;
      end
    else
      begin
      store=0;
      z=0;
      sto_a=a;
      sto_a[32]=sto_a[31];
      for(k=0;k<31;k=k+1)
        begin
        if(b[k]==0)
          begin
          z[k]=store[0];
          store=store>>>1;
          end
        else
          begin
          store=store+sto_a;
          z[k]=store[0];
          store=store>>>1;
          end
        end
      if(b[31]==1)
        begin
        store=store-sto_a;
        end
      for(k=0;k<33;k=k+1)
        begin
        z[31+k]=store[k];
        end
      end
    end
endmodule
