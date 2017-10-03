`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/14 20:32:39
// Design Name: 
// Module Name: alu
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


module alu(
    
    input [31:0] a,    //32 位输入，操作数 1 
    input signed [31:0] b,    //32 位输入，操作数 2 
    input [4:0] aluc, //4 位输入，控制 alu 的操作 
    output reg [31:0] r,   //32 位输出，由 a、b 经过 aluc 指定的操作生成 
    output reg zero,        //0 标志位 
    output reg carry,       // 进位标志位 
    output reg negative,   // 负数标志位 
    output reg overflow   // 溢出标志位 
); 
    reg [32:0]temp_data;
    reg [4:0]count;
    reg signed [32:0]SR_data;
     reg [4:0] tmp;
      integer i;
    
    
      
    always @(*)
    begin
    zero=0;
    carry=0;
    negative=0;
    overflow=0;
    if(aluc[4]==0) 
    begin
    if(aluc[3:2]==2'b00)//加减运算
      begin
      if(aluc[1:0]==2'b00)//无符号数相加
        begin
        temp_data=a+b;
        r=temp_data[31:0];
        if(temp_data[32]==1)
          carry=1;
        else
          carry=0;
        end
      else if(aluc[1:0]==2'b10)//有符号数相加
        begin
        temp_data=a+b;
        r=temp_data[31:0];
        if(a[31]==0&&b[31]==0&&temp_data[31]==1||a[31]==1&&b[31]==1&&temp_data[31]==0)       
          overflow=1;
        else
          overflow=0;
        end
      else if(aluc[1:0]==2'b01)//无符号数相减
        begin
        r=a-b;
        if(a<b)
          carry=1;
        else
          carry=0;
        end
      else//有符号数相减
        begin
        r=a-b;
        if(a[31]==0&&b[31]==1&&a[30:0]>=b[30:0]||a[31]==1&&b[31]==0&&a[30:0]<b[30:0])
          overflow=1;
        else
          overflow=0;
        end
      if(r==0)
        zero=1;
      else
        zero=0;
      if(r[31]==1)
        negative=1;
      else
        negative=0;
      end 
      
      
     
    else if(aluc[3:2]==2'b01)//按位运算
      begin
      if(aluc[1:0]==2'b00)//按位与
        r=a&b;
      else if(aluc[1:0]==2'b01)//按位或
        r=a|b;
      else if(aluc[1:0]==2'b10)//按位异或  
        r=a^b;
      else//
        r=~(a|b);
      if(r==0)
        zero=1;
      else
        zero=0;
      if(r[31]==1)
        negative=1;
      else
        negative=0;
      end
      
      
      
      
    else if(aluc[3:2]==2'b11)//移位运算
      begin
      if(aluc[1]==0)
        begin
        if(aluc[0]==0)//算术右移
          begin
          r=b>>>a[4:0];
          end
        else//逻辑右移
          begin
          r=b>>a[4:0];
          end
        if(a[4:0]==0)
          carry=0;
        else
          carry=b[a[4:0]-1];
        end
      else//算术、逻辑左移
        begin
        r=b<<a[4:0];
        if(a[4:0]==0)
          carry=0;
        else
          carry=b[32-a[4:0]];
        end
      if(r==0)
        zero=1;
      else
        zero=0;
      if(r[31]==1)
        negative=1;
      else
        negative=0;
      end
    
    
    
    else//比较运算
      begin
      if(aluc[1]==0)//高位立即数
        begin
        r={b[15:0],16'b0};
        if(r==0)
          zero=1;
        else
          zero=0;
        if(r[31]==1)
          negative=1;
        else
          negative=0;
        end  
      else
        begin
        if(aluc[0]==0)//无符号数比较
          begin
          if(a<b)
            begin
            r=1;
            carry=1;
            zero=0;
            end
          else 
            begin
            r=0;
            carry=0;
            if(a==b)
              zero=1;
            else
              zero=0;
            end
          if(r[31]==1)
            negative=1;
          else
            negative=0;
          end
        else//有符号数比较
          begin
          if(a[31]^b[31]==1)//a与b不同号
            begin
            if(a[31]==1&&b[31]==0)
              begin
              r=1;
              negative=1;
              zero=0;
              end
            else
              begin
              r=0;
              negative=0;
              zero=0;
              end
            end
          else//a与b同号
            begin
            if(a[30:0]<b[30:0])
              begin
              r=1;
              negative=1;
              zero=0;
              end
            else
              begin
              r=0;
              negative=0;
              if(a[30:0]==b[30:0])
                zero=1;
              else
                zero=0;
              end
            end
          end
        end
      end  
      end
    
    else if(aluc==5'b10001)//clz
      begin
      if(a[31])
      tmp=0;
      else if(a[30])
      tmp=1;
      else if(a[29])
      tmp=2;
      else if(a[28])
      tmp=3;
      else if(a[27])
      tmp=4;
      else if(a[26])
      tmp=5;
      else if(a[25])
      tmp=6;
      else if(a[24])
      tmp=7;
      else if(a[23])
      tmp=8;
      else if(a[22])
      tmp=9;
      else if(a[21])
      tmp=10;
      else if(a[20])
      tmp=11;
      else if(a[19])
      tmp=12;
      else if(a[18])
      tmp=13;
      else if(a[17])
      tmp=14;
      else if(a[16])
      tmp=15;
      else if(a[15])
      tmp=16;
      else if(a[14])
      tmp=17;
      else if(a[13])
      tmp=18;
      else if(a[12])
      tmp=19;
      else if(a[11])
      tmp=20;
      else if(a[10])
      tmp=21;
      else if(a[9])
      tmp=22;
      else if(a[8])
      tmp=23;
      else if(a[7])
      tmp=24;
      else if(a[6])
      tmp=25;
      else if(a[5])
      tmp=26;
      else if(a[4])
      tmp=27;
      else if(a[3])
      tmp=28;
      else if(a[2])
      tmp=29;
      else if(a[1])
      tmp=30;
      else if(a[0])
      tmp=31;
      else
      tmp=32;
      r=tmp;
      if(tmp==0)
      zero=1;
      else
      zero=0;
      end
      end
    
endmodule
