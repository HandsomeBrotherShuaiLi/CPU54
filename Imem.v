`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/19 21:41:04
// Design Name: 
// Module Name: Imem
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


module Imem(      
   input clk,   //�洢��ʱ���źţ�������ʱ�� ram �ڲ�д������      
   input ena,   //�洢����Ч�źţ��ߵ�ƽʱ�洢�������У�������� z      
   input wena,  //�洢����д��Ч�źţ��ߵ�ƽΪд��Ч���͵�ƽΪ����Ч���� ena ͬʱ��Чʱ�ſɶԴ洢�����ж�д      
   input [31:0] addr,   //�����ַ��ָ�����ݶ�д�ĵ�ַ      
   inout [31:0] data  //�洢�������ߣ��ɴ���洢��������д������ݡ� д��������� clk ������ʱ��д�� 
   );  
    parameter wordsize = 32;          
    parameter memsize = 10240;          
    reg [wordsize-1: 0] ram_space [memsize-1: 0]; 
   
    
    assign data=(ena==1&&wena==0) ? ram_space[addr] : 32'bzzzzzzzz_zzzzzzzz_zzzzzzzz_zzzzzzzz;   
    
    initial
    begin
    $readmemh("S:/Vivado/imem.txt", ram_space); 
    end
    
    always @ (posedge clk)
    begin
    if(ena==1&&wena==1)
      begin
      ram_space[addr]<=data;
      end
    end
endmodule
