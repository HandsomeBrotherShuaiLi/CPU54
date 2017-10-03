`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/11/27 18:46:40
// Design Name: 
// Module Name: Regfiles
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


module Regfiles(
   input clk,    //�Ĵ�����ʱ���źţ�������д������      
   input rst,    //reset �źţ��ߵ�ƽʱȫ���Ĵ�������      
   input we,     //�Ĵ�����д��Ч�źţ�   
   input [4:0] raddr1,  //�����ȡ�ļĴ����ĵ�ַ      
   input [4:0] raddr2,  //�����ȡ�ļĴ����ĵ�ַ      
   input [4:0] waddr,   //д�Ĵ����ĵ�ַ      
   input [31:0] wdata, //д�Ĵ�������      
   output [31:0] rdata1, //raddr1 ����Ӧ�Ĵ������������
   output [31:0] rdata2 //raddr2 ����Ӧ�Ĵ������������
   
    );
   
   reg [31:0] regfile [31:0];
   integer counter;
   
   assign rdata1=regfile[raddr1];
   assign rdata2=regfile[raddr2];
   
   
   always @(negedge clk or posedge rst)
   begin
   if(rst==1)
     begin
     for(counter=0;counter<=31;counter=counter+1)
       begin
       regfile[counter]<=32'b00000000_00000000_00000000_00000000;
       end
     end
   else if(we==1 &&waddr!=5'b00000)//&&waddr!=5'b00000
     begin
     regfile[waddr]<=wdata;
     end
   end
    
endmodule
