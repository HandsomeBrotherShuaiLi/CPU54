`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 19:47:39
// Design Name: 
// Module Name: CPU_31_tb
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


module CPU_31_tb();
  reg clk;
  reg rst;
  wire [15:0]regfile28;

  integer file_output;
  integer counter=0;
  
  initial 
  begin 
  
  file_output=$fopen("_____________myresult.txt");
  
  rst=1;
  clk=1;
  #10;
  rst=0;
  end
  
  always #5 clk=~clk;
  
  always @(posedge clk)
  begin
  
  if(rst==0)
  begin
  
  $fdisplay(file_output,"pc: %h",CPU_31_tb.uut.PC.data_out);
  $fdisplay(file_output,"instr: %h",CPU_31_tb.uut.IM.data);
    
    
  $fdisplay(file_output,"regfile0: %h",CPU_31_tb.uut.RF.regfile[0]);
  $fdisplay(file_output,"regfile1: %h",CPU_31_tb.uut.RF.regfile[1]);
  $fdisplay(file_output,"regfile2: %h",CPU_31_tb.uut.RF.regfile[2]);
  $fdisplay(file_output,"regfile3: %h",CPU_31_tb.uut.RF.regfile[3]);
  $fdisplay(file_output,"regfile4: %h",CPU_31_tb.uut.RF.regfile[4]);
  $fdisplay(file_output,"regfile5: %h",CPU_31_tb.uut.RF.regfile[5]);
  $fdisplay(file_output,"regfile6: %h",CPU_31_tb.uut.RF.regfile[6]);
  $fdisplay(file_output,"regfile7: %h",CPU_31_tb.uut.RF.regfile[7]);
  $fdisplay(file_output,"regfile8: %h",CPU_31_tb.uut.RF.regfile[8]);
  $fdisplay(file_output,"regfile9: %h",CPU_31_tb.uut.RF.regfile[9]);
  
  $fdisplay(file_output,"regfile10: %h",CPU_31_tb.uut.RF.regfile[10]);
  $fdisplay(file_output,"regfile11: %h",CPU_31_tb.uut.RF.regfile[11]);
  $fdisplay(file_output,"regfile12: %h",CPU_31_tb.uut.RF.regfile[12]);
  $fdisplay(file_output,"regfile13: %h",CPU_31_tb.uut.RF.regfile[13]);
  $fdisplay(file_output,"regfile14: %h",CPU_31_tb.uut.RF.regfile[14]);
  $fdisplay(file_output,"regfile15: %h",CPU_31_tb.uut.RF.regfile[15]);
  $fdisplay(file_output,"regfile16: %h",CPU_31_tb.uut.RF.regfile[16]);
  $fdisplay(file_output,"regfile17: %h",CPU_31_tb.uut.RF.regfile[17]);
  $fdisplay(file_output,"regfile18: %h",CPU_31_tb.uut.RF.regfile[18]);
  $fdisplay(file_output,"regfile19: %h",CPU_31_tb.uut.RF.regfile[19]);
  
  $fdisplay(file_output,"regfile20: %h",CPU_31_tb.uut.RF.regfile[20]);
  $fdisplay(file_output,"regfile21: %h",CPU_31_tb.uut.RF.regfile[21]);
  $fdisplay(file_output,"regfile22: %h",CPU_31_tb.uut.RF.regfile[22]);
  $fdisplay(file_output,"regfile23: %h",CPU_31_tb.uut.RF.regfile[23]);
  $fdisplay(file_output,"regfile24: %h",CPU_31_tb.uut.RF.regfile[24]);
  $fdisplay(file_output,"regfile25: %h",CPU_31_tb.uut.RF.regfile[25]);
  $fdisplay(file_output,"regfile26: %h",CPU_31_tb.uut.RF.regfile[26]);
  $fdisplay(file_output,"regfile27: %h",CPU_31_tb.uut.RF.regfile[27]);
  $fdisplay(file_output,"regfile28: %h",CPU_31_tb.uut.RF.regfile[28]);
  $fdisplay(file_output,"regfile29: %h",CPU_31_tb.uut.RF.regfile[29]);
  
  $fdisplay(file_output,"regfile30: %h",CPU_31_tb.uut.RF.regfile[30]);
  $fdisplay(file_output,"regfile31: %h",CPU_31_tb.uut.RF.regfile[31]);
  
  
  end
  counter=counter+1;
  end
  
  CPU_31 uut(clk,rst,regfile28);
endmodule
