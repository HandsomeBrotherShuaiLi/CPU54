`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/19 21:41:39
// Design Name: 
// Module Name: Dmem
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


module Dmem(      
   input clk,   //�洢��ʱ���źţ�������ʱ�� ram �ڲ�д������  
   input rst,    
   input sw,   //�洢����Ч�źţ��ߵ�ƽʱ�洢�������У�������� z      
   input lw,  //�洢����д��Ч�źţ��ߵ�ƽΪд��Ч���͵�ƽΪ����Ч���� ena ͬʱ��Чʱ�ſɶԴ洢�����ж�д 
   input [2:0]bt,//���8λ 16λ�����    
   input sb,
   input sh, 
   input [31:0] pc,
   input [31:0] addr_in,   //�����ַ��ָ�����ݶ�д�ĵ�ַ  
   input [31:0] addr_out,
   input [31:0] data_in,    
   output [31:0] data_out,  //�洢�������ߣ��ɴ���洢��������д������ݡ� д��������� clk ������ʱ��д�� 
   output [31:0]  btdata,  //��λ������
   output [31:0] data0
   );  
    parameter wordsize = 32;          
    parameter memsize = 256;          
    reg [wordsize-1: 0] ram_space [memsize-1: 0];
    integer counter;
   reg  [7:0]b;
   reg  [15:0] w;
    reg [31:0] btdata1;
    reg [31:0] btdata2;
    reg [31:0] btdata3;
    reg [31:0] btdata4;
    
    wire [31:0]e_addr_in;
    wire [31:0]e_addr_out; 
    
    assign e_addr_in=addr_in-32'h10010000;
    assign e_addr_out=addr_out-32'h10010000;
    
    wire [31:0] data_out1;
   
   assign btdata=(bt==3'b001)?{{24{ram_space[e_addr_out][7]}},ram_space[e_addr_out][7:0]}:((bt==3'b010)?{24'b0,ram_space[e_addr_out][7:0]}:((bt==3'b100)?{{16{ram_space[e_addr_out][15]}},ram_space[e_addr_out][15:0]}:((bt==3'b011)?{16'b0,ram_space[e_addr_out][15:0]}:32'bz)));
   assign data_out=(lw==1&&sw==0) ? ram_space[e_addr_out] : 32'bzzzzzzzz_zzzzzzzz_zzzzzzzz_zzzzzzzz;   
   assign data0=ram_space[0];
    
    always @ (negedge clk or posedge rst  )//or addr_in or pc
    begin
    if(rst==1)
      begin
      for(counter=0;counter<=memsize-1;counter=counter+1)
        begin
        ram_space[counter]<=32'b0;
        end
      end
    else begin
     if(bt==3'b000) 
     begin
      if(sw==1 && lw==0 && sb==0 && sh==0) 
      ram_space[e_addr_in]=data_in;
      else if(sw==0 &&lw==0 && sb==1&&sh==0)//sb
      begin
      ram_space[e_addr_in]<=data_in[7:0];
      end
      else if(sw==0 &&lw==0 && sb==0 && sh==1)// sh
      begin
      ram_space[e_addr_in]<=data_in[15:0];
      end
      end
      else if(bt==3'b001)// lb
      begin
      b=ram_space[e_addr_out][7:0];
      btdata1={{24{b[7]}},b};// {{24{ram_space[e_addr_out][7]}},ram_space[e_addr_out][7:0]}
      end
      else if(bt==3'b010)  //lbu
      begin
           b=ram_space[e_addr_out][7:0];
           btdata2={24'b0,b};//{24'b0,ram_space[e_addr_out][7:0]}
    end
      else if(bt==3'b100) //lh
      begin
       w=ram_space[e_addr_out][15:0];
       btdata3={{16{w[15]}},w};//{{16{ram_space[e_addr_out][15]}},ram_space[e_addr_out][15:0]}
       end
     else if(bt==3'b011)//lhu
     begin
         w=ram_space[e_addr_out][15:0];
         btdata4={16'b0,w};//{16'b0,ram_space[e_addr_out][15:0]}
    end
    end
    end
endmodule
