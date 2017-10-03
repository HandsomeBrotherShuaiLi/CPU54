`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/30 18:53:59
// Design Name: 
// Module Name: cp0
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
module cp0(
input clk, 
input rst, 
input we,
input mfc0,            // CPU instruction is Mfc0 
input mtc0,            // CPU instruction is Mtc0 
input [31:0]pc, 
input [4:0] addr,          // Specifies Cp0 register 
input [31:0] data,      // Data from GP register to replace CP0 register 
input exception, //1的话就是异常
input eret,   
input  [4:0] cause,
output  [31:0] rdata,      // Data from CP0 register for GP register 
output  [31:0] status, 
output   [31:0]exc_addr    // Address for PC at the beginning of an exception 
 );
 reg [31:0] CP0 [31:0];
 reg [31:0] status_tmp;
 integer i;
 
 assign rdata=(mfc0==1)?CP0[addr]:32'bz;
 assign exc_addr=(exception && (eret==1))?CP0[14]:((exception && (eret==0) )?1:32'bz);
 assign status=CP0[12];
 always @(negedge clk or posedge rst)
 begin
 if(rst==1)
 begin
 for(i=0;i<=11;i=i+1)
 CP0[i]=32'b0;
 CP0[12]={28'b0,4'b1};
 for(i=13;i<=31;i=i+1)
 CP0[i]=32'b0;
 end
 else begin
 if(we) begin
 if(!exception)
 begin
// if(mfc0)//读
// rdata=CP0[addr];
 if(mtc0)//写
 begin
 CP0[addr]=data;
 end
 end
 if(exception)
 begin
 status_tmp=CP0[12];
 if(!eret)
 begin
 CP0[14]=pc;
 CP0[12]={CP0[12],5'b0};
 
 CP0[13][6:2]=cause;
 
 end
 else begin
 CP0[12]=status_tmp;
 end
 end
 end
 end
 end
 endmodule
