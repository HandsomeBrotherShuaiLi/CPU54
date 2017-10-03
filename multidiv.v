`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/06/06 20:17:10
// Design Name: 
// Module Name: multidiv
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


module multidiv(

input mul,
input multu,
input div,
input divu,
input [31:0] a,//rsdata
input [31:0] b,//rtdata
output [31:0] lo,
output [31:0] hi,
output [31:0] rddata,
output zero
    );
    
       reg [63:0] z_reg;
       parameter s0=0,s1=1,s2=2;
       reg [4:0] count=0;
       reg [1:0] state=0;
       reg [63:0] p,t;
       reg [31:0] b_reg;
       reg   zero_reg;
       
       integer k;
       reg signed [32:0] store;
       reg signed [32:0] sto_a;
       reg [31:0] rddata1;
     
         reg [31:0] tempa;
         reg [31:0] tempb;
         reg [63:0] temp_a;
         reg [63:0] temp_b;
         integer i;
        reg [31:0] hi_reg1;
        reg [31:0] hi_reg2;
        reg [31:0] hi_reg3;
        reg [31:0] lo_reg1;
        reg [31:0] lo_reg2;
        reg [31:0] lo_reg3;
        
        
        assign rddata=rddata1;
        assign zero=zero_reg;
        assign lo=(multu==1)?lo_reg1:((div==1)?lo_reg2:((divu==1)?lo_reg3:32'bz));
        assign hi=(multu==1)?hi_reg1:((div==1)?hi_reg2:((divu==1)?hi_reg3:32'bz));
        
  always @(*)
  begin
  rddata1=32'b0;
  zero_reg=0;
  lo_reg3=0;
  lo_reg2=0;
  lo_reg1=0;
  hi_reg3=0;
  hi_reg2=0;

  
if(multu)    //_reg1
        begin
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
        lo_reg1=z_reg[31:0];
        hi_reg1=z_reg[63:0];
        if(z_reg==64'b0)
        zero_reg=1;
        else 
        zero_reg=0;
        end
else if(mul)
       begin
       store=0;
           z_reg=0;
           sto_a=a;
           sto_a[32]=sto_a[31];
           for(k=0;k<31;k=k+1)
             begin
             if(b[k]==0)
               begin
               z_reg[k]=store[0];
               store=store>>>1;
               end
             else
               begin
               store=store+sto_a;
               z_reg[k]=store[0];
               store=store>>>1;
               end
             end
           if(b[31]==1)
             begin
             store=store-sto_a;
             end
           for(k=0;k<33;k=k+1)
             begin
             z_reg[31+k]=store[k];
             end
             if(z_reg==64'b0)
             zero_reg=1;
             else 
             zero_reg=0;
             rddata1=z_reg[31:0];
             end 
  else if(div)          //_reg2
                  begin
                if(a[31]==0)
                tempa=a;//
                else
                tempa=~a+1'b1;//
                if(b[31]==0)
                tempb=b;
                else
                tempb=~b+1'b1;//????¡À???????
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
                lo_reg2=temp_a[31:0];
                else
                begin
                if(b[31]==a[31])
                lo_reg2={1'b0,temp_a[30:0]};
                else
                lo_reg2={1'b1,~temp_a[30:0]+1'b1};
                end
                if(a[31]==1)
                hi_reg2={1'b1,~temp_a[62:32]+1};
                else
                hi_reg2={1'b0,temp_a[62:32]};
                if(a==0)
                zero_reg=1;
                else 
                zero_reg=0;
                end
else if(divu && b!=0)
                    begin
                   
                   tempa=a;
                   tempb=b;
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
                   lo_reg3=temp_a[31:0];
                   hi_reg3=temp_a[63:32];
                   if(a==0)
                   zero_reg=1;
                   else 
                   zero_reg=0;
                   end
   end
endmodule
