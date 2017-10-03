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
   input clk,   //存储器时钟信号，上升沿时向 ram 内部写入数据  
   input rst,    
   input sw,   //存储器有效信号，高电平时存储器才运行，否则输出 z      
   input lw,  //存储器读写有效信号，高电平为写有效，低电平为读有效，与 ena 同时有效时才可对存储器进行读写 
   input [2:0]bt,//变成8位 16位的情况    
   input sb,
   input sh, 
   input [31:0] pc,
   input [31:0] addr_in,   //输入地址，指定数据读写的地址  
   input [31:0] addr_out,
   input [31:0] data_in,    
   output [31:0] data_out,  //存储器数据线，可传输存储器读出或写入的数据。 写入的数据在 clk 上升沿时被写入 
   output [31:0]  btdata,  //变位后的输出
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
