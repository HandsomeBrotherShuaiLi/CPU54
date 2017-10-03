`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/16 16:38:10
// Design Name: 
// Module Name: Reg
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


module Reg(
   input clk,   //1 λ���룬�Ĵ���ʱ���źţ�������ʱΪ PC �Ĵ�����ֵ 
   input rst,   //1 λ���룬�첽�����źţ��ߵ�ƽʱ�� PC �Ĵ������� //ע���� ena �ź���Чʱ��rst Ҳ�������üĴ��� 
   input ena,   //1 λ����,��Ч�źŸߵ�ƽʱ PC �Ĵ������� data_in��ֵ�����򱣳�ԭ����� 
   input [31:0] data_in, //32 λ���룬�������ݽ�������Ĵ����ڲ� 
   output [31:0] data_out   //32 λ���������ʱʼ����� PC�Ĵ����ڲ��洢��ֵ 
   ); 
   reg [31:0]Reg_space;
   assign data_out=Reg_space;
   always @(posedge clk or posedge rst)
   begin
   if(rst==1)
     begin
     Reg_space<= 32'b00000000_00000000_00000000_00000000; 
     end  
   else if(ena==1)
     begin
     Reg_space<=data_in;
     end
   end
endmodule
