`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/07/15 15:53:59
// Design Name: 
// Module Name: sw_mem_sel
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

module sw_mem_sel(
    input [31:0] switch_cs,
	 input [15:0] sw,
	 input [31:0] data,
	 output [31:0] data_sel
    );

    assign data_sel = (switch_cs) ? {16'b0, sw[15:0]} : data;
endmodule

