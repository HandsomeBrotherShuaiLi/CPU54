`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/15 20:01:22
// Design Name: 
// Module Name: Microoperation_List
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


module Control_Signal(
    input ADD,
    input ADDU,
    input SUB,
    input SUBU,
    input AND,
    input OR,
    input XOR,
    input NOR,
    input SLT,
    input SLTU,
    input SLL,
    input SRL,
    input SRA,
    input SLLV,
    input SRLV,
    input SRAV,
    input JR,
    input ADDI,
    input ADDIU,
    input ANDI,
    input ORI,
    input XORI,
    input LW,
    input SW,
    input BEQ,
    input BNE,
    input SLTI,
    input SLTIU,
    input LUI,
    input J,
    input JAL,
    input  CLZ,  
    input DIVU, 
    input  ERET, 
    input JALR, 
    input   LB,   
    input LBU,  
    input LHU,  
    input SB,   
    input SH,   
    input LH,   
    input MFC0, 
    input MFHI, 
    input MFLO, 
    input MTC0, 
    input MTHI, 
    input MTLO,
    input MUL,  
    input MULTU,
    input  SYSCALL,
    input TEQ,  
    input BGEZ, 
    input BREAK,
    input DIV,  
    input zero,     //alu的0标志位
    input [31:0]IM,  //32位的指令
    input [31:0] rsdata,
    input [31:0] rtdata,
   
    output reg IM_R,
    output reg RF_W,
    output reg [4:0]ALUC,
    output reg DM_CS,
    output reg DM_R,
    output reg DM_W,
    output reg [1:0]M1,
    output reg [1:0]M2,
    output reg M3,
    output reg M4,
    output reg M5,
    output reg [1:0]M6,
    output reg M7,
    output reg [2:0] bt,
    output reg [4:0]cause,
    output reg zzzz,
    output reg exception
    );
    
    always @(*)
    begin
    
               zzzz=(rsdata==rtdata)?1:0;
               exception=ERET||SYSCALL||(TEQ && rtdata==rsdata)||BREAK;
    
    IM_R<=ADD||ADDU||ADDI||ADDIU||SUB||SUBU||AND||ANDI||OR||ORI||XOR||XORI||NOR||
          SLT||SLTI||SLTU||SLTIU||SLL||SRL||SRA||SLLV||SRLV||SRAV||LW||SW||BEQ||BNE||LUI||J||JAL||JR||CLZ||
          MULTU||MTLO||MTHI||MFLO||MFHI||MUL||DIV||DIVU||LB||LBU||LH||LHU||SH||SB||MFC0||MTC0;
           
    RF_W<=ADD||ADDU||ADDI||ADDIU||SUB||SUBU||AND||ANDI||OR||ORI||XOR||XORI||NOR||
          SLT||SLTI||SLTU||SLTIU||SLL||SRL||SRA||SLLV||SRLV||SRAV||LW||LUI||JAL||CLZ||MFLO||MFHI||MUL||LB||LBU||LH||LHU||MFC0||JALR;
    ALUC[4]=CLZ;
    ALUC[3]<=LUI||SLT||SLTI||SLTU||SLTIU||SLL||SLLV||SRL||SRLV||SRA||SRAV;
    ALUC[2]<=AND||ANDI||OR||ORI||XOR||XORI||NOR||SLL||SLLV||SRL||SRLV||SRA||SRAV;
    ALUC[1]<=ADD||ADDI||SUB||XOR||XORI||NOR||SLT||SLTI||SLTU||SLTIU||SLL||SLLV||LW||SW||BEQ||BNE||LB||LBU||LH||LHU||SB||SH;  
    ALUC[0]<=SUBU||SUB||OR||ORI||NOR||SLT||SLTI||SRL||SRLV||BEQ||BNE||CLZ;
    DM_CS<=LW||SW||LB||LBU||LH||LHU||SB||SH;
    DM_R<=LW||LB||LBU||LH||LHU;
    DM_W<=SW||SB||SH;
    M1[0]<=ADD||ADDU||ADDI||ADDIU||SUB||SUBU||AND||ANDI||OR||ORI||XOR||XORI||NOR||
           SLT||SLTI||SLTU||SLTIU||SLL||SRL||SRA||SLLV||SRLV||SRAV||LW||SW||BEQ||BNE||LUI||CLZ||MULTU||
           MTLO||MTHI||MFLO||MFHI||MUL||DIV||DIVU||LB||LBU||LHU||LH||SB||SH||MTC0|MFC0||(TEQ && (rsdata!=rtdata))||SYSCALL||BREAK||ERET||BGEZ;
    M1[1]<=JR||JALR;
   
    M2[0]<=ADD||ADDU||ADDI||ADDIU||SUB||SUBU||AND||ANDI||OR||ORI||XOR||XORI||NOR||
           SLT||SLTI||SLTU||SLTIU||SLL||SRL||SRA||SLLV||SRLV||SRAV||SW||BEQ||BNE||LUI||J||JR||CLZ||MFLO||MFHI||MUL||MFC0;
    M2[1]<=JAL||JALR;
    M3<=ADD||ADDU||ADDI||ADDIU||SUB||SUBU||AND||ANDI||OR||ORI||XOR||XORI||NOR||
        SLT||SLTI||SLTU||SLTIU||SLLV||SRLV||SRAV||LW||SW||BEQ||BNE||LUI||J||JAL||JR||CLZ||LB||LBU||LH||LHU||SB||SH;
    M4<=ADDI||ADDIU||ANDI||ORI||XORI||SLTI||SLTIU||LW||SW||LUI||LB||LBU||LH||LHU||SH||SB;
    M5<=BEQ && (rtdata==rsdata)||BNE&&(rtdata!=rsdata)||SYSCALL||BREAK||ERET||(BGEZ && !rsdata[31]);
    M6[0]<=ADDI||ADDIU||ANDI||ORI||XORI||LW||SLTI||SLTIU||LUI||LB||LBU||LH||LHU||MFC0;
    M6[1]<=JAL;
    M7=MFLO||MFHI;
    bt[2]=LH;
    bt[1]=LHU||LBU;
    bt[0]=LHU||LB;
    
    cause[4]=1'b0;
    cause[3]=BREAK||SYSCALL||(TEQ && rtdata==rsdata);
    cause[2]=TEQ;
    cause[1]=1'b0;
    cause[0]=(TEQ && rtdata==rsdata)||BREAK;
    
           
    end
endmodule
