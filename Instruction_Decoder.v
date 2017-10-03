`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/15 19:18:51
// Design Name: 
// Module Name: Instruction_Decoder
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


module Instruction_Decoder(
    input [5:0]op,
    input [4:0]rs,
    input [5:0]func,
    output ADD,
    output ADDU,
    output SUB,
    output SUBU,
    output AND,
    output OR,
    output XOR,
    output NOR,
    output SLT,
    output SLTU,
    output SLL,
    output SRL,
    output SRA,
    output SLLV,
    output SRLV,
    output SRAV,
    output JR,
    output ADDI,
    output ADDIU,
    output ANDI,
    output ORI,
    output XORI,
    output LW,
    output SW,
    output BEQ,
    output BNE,
    output SLTI,
    output SLTIU,
    output LUI,
    output J,
    output JAL,
    output CLZ,
    output DIVU,
    output ERET,
    output JALR,
    output LB,
    output LBU,
    output LHU,
    output SB,
    output SH,
    output LH,
    output MFC0,
    output MFHI,
    output MFLO,
    output MTC0,
    output MTHI,
    output MTLO,//×ÖÄ¸o
    output MUL,
    output MULTU,
    output SYSCALL,
    output TEQ,
    output BGEZ,
    output BREAK,
    output DIV
    );
    reg [53:0]IC;
    assign ADD=IC[0];
    assign ADDU=IC[1];
    assign SUB=IC[2];
    assign SUBU=IC[3];
    assign AND=IC[4];
    assign OR=IC[5];
    assign XOR=IC[6];
    assign NOR=IC[7];
    assign SLT=IC[8];
    assign SLTU=IC[9];
    assign SLL=IC[10];
    assign SRL=IC[11];
    assign SRA=IC[12];
    assign SLLV=IC[13];
    assign SRLV=IC[14];
    assign SRAV=IC[15];
    assign JR=IC[16];
    assign ADDI=IC[17];
    assign ADDIU=IC[18];
    assign ANDI=IC[19];
    assign ORI=IC[20];
    assign XORI=IC[21];
    assign LW=IC[22];
    assign SW=IC[23];
    assign BEQ=IC[24];
    assign BNE=IC[25];
    assign SLTI=IC[26];
    assign SLTIU=IC[27];
    assign LUI=IC[28];
    assign J=IC[29];
    assign JAL=IC[30];
    assign CLZ=IC[31];
    assign DIVU=IC[32];
    assign ERET=IC[33];
    assign JALR=IC[34];
    assign LB=IC[35];
    assign LBU=IC[36];
    assign LHU=IC[37];
    assign SB=IC[38];
    assign SH=IC[39];
    assign LH=IC[40];
    assign MFC0=IC[41];
    assign MFHI=IC[42];
    assign MFLO=IC[43];
    assign MTC0=IC[44];
    assign MTHI=IC[45];
    assign MTLO=IC[46];
    assign MUL=IC[47];
    assign MULTU=IC[48];
    assign SYSCALL=IC[49];
    assign TEQ=IC[50];
    assign BGEZ=IC[51];
    assign BREAK=IC[52];
    assign DIV=IC[53];
    always @(*)
    begin
    if(op==6'b000000)
      begin
      case(func)
      6'b100000:IC={23'b0,31'b0000000_00000000_00000000_00000001};//add
      6'b100001:IC={23'b0,31'b0000000_00000000_00000000_00000010};//addu
      6'b100010:IC={23'b0,31'b0000000_00000000_00000000_00000100};//sub
      6'b100011:IC={23'b0,31'b0000000_00000000_00000000_00001000};//subu
      6'b100100:IC={23'b0,31'b0000000_00000000_00000000_00010000};//and
      6'b100101:IC={23'b0,31'b0000000_00000000_00000000_00100000};//or
      6'b100110:IC={23'b0,31'b0000000_00000000_00000000_01000000};//xor
      6'b100111:IC={23'b0,31'b0000000_00000000_00000000_10000000};//nor
      6'b101010:IC={23'b0,31'b0000000_00000000_00000001_00000000};//slt
      6'b101011:IC={23'b0,31'b0000000_00000000_00000010_00000000};//sltu
      6'b000000:IC={23'b0,31'b0000000_00000000_00000100_00000000};//sll
      6'b000010:IC={23'b0,31'b0000000_00000000_00001000_00000000};//srl
      6'b000011:IC={23'b0,31'b0000000_00000000_00010000_00000000};//sra
      6'b000100:IC={23'b0,31'b0000000_00000000_00100000_00000000};//sllv
      6'b000110:IC={23'b0,31'b0000000_00000000_01000000_00000000};//srlv
      6'b000111:IC={23'b0,31'b0000000_00000000_10000000_00000000};//srav
      6'b001000:IC={23'b0,31'b0000000_00000001_00000000_00000000};//jr
      6'b001001:IC={18'b0,36'b010000000_000000000_000000000_000000000};//jalr
      6'b011011:IC={21'b0,1'b1,32'b0};//divu
      6'b010000:IC={11'b0,1'b1,42'b0};//mfhi
      6'b010010:IC={10'b0,1'b1,43'b0};//mflo
      6'b010001:IC={8'b0,1'b1,45'b0};//mthi
      6'b010011:IC={7'b0,1'b1,46'b0};//mtlo
      6'b011001:IC={5'b0,1'b1,48'b0};//multu
      6'b001100:IC={4'b0,1'b1,49'b0};//syscall
      6'b110100:IC={3'b0,1'b1,50'b0};//teq
      6'b001101:IC={1'b0,1'b1,52'b0};//break
      6'b011010:IC={1'b1,53'b0};//div
      default:IC={23'b0,31'b0000000_00000000_00000000_00000000};//jr
      endcase
      end
    else if(op==6'b001000)//addi
      IC={23'b0,31'b0000000_00000010_00000000_00000000};
    else if(op==6'b001001)//addiu       
      IC={23'b0,31'b0000000_00000100_00000000_00000000};
    else if(op==6'b001100)//andi
      IC={23'b0,31'b0000000_00001000_00000000_00000000};
    else if(op==6'b001101)//ori
      IC={23'b0,31'b0000000_00010000_00000000_00000000};
    else if(op==6'b001110)//xori
      IC={23'b0,31'b0000000_00100000_00000000_00000000};
    else if(op==6'b100011)//lw
      IC={23'b0,31'b0000000_01000000_00000000_00000000};
    else if(op==6'b101011)//sw
      IC={23'b0,31'b0000000_10000000_00000000_00000000};
    else if(op==6'b000100)//beq
      IC={23'b0,31'b0000001_00000000_00000000_00000000};
    else if(op==6'b000101)//bne
      IC={23'b0,31'b0000010_00000000_00000000_00000000};
    else if(op==6'b001010)//slti
      IC={23'b0,31'b0000100_00000000_00000000_00000000};
    else if(op==6'b001011)//sltiu
      IC={23'b0,31'b0001000_00000000_00000000_00000000};
    else if(op==6'b001111)//lui
      IC={25'b0,1'b1,28'b0};
    else if(op==6'b000010)//j
      IC={24'b0,1'b1,29'b0};
    else if(op==6'b000011)//jal
      IC={23'b0,31'b1000000_00000000_00000000_00000000};
     else if(op==6'b100000)//lb
     IC={18'b0,1'b1,35'b0};
     else if(op==6'b100100)//lbu
     IC={17'b0,1'b1,36'b0};
     else if(op==6'b100101)//lhu
     IC={16'b0,1'b1,37'b0};
     else if(op==6'b101000)//sb
     IC={15'b0,1'b1,38'b0};
     else if(op==6'b101001)//sh
     IC={14'b0,1'b1,39'b0};
     else if(op==6'b100001)//lh
     IC={13'b0,1'b1,40'b0};
     else if(op==6'b000001)//bgez
      IC={2'b0,1'b1,51'b0};
      
     else if(op==6'b010000)
     begin
     case(func)
     6'b011000:IC={20'b0,1'b1,33'b0};//eret
     6'b000000:begin
     if(rs==5'b00000) IC={12'b0,1'b1,41'b0};//mcfo
     else IC={9'b0,1'b1,44'b0};//mtc0
     end
     default:IC=54'b0;
     endcase
     end
     
     else if(op==6'b011100)
     begin
     case(func)
     6'b100000:IC={22'b0,32'b10000000_00000000_00000000_00000000};//clz
     6'b000010:IC={6'b0,1'b1,47'b0};//mul
     default:IC=54'b0;
     endcase
     end
     
    else
      IC=54'b0;
    end
endmodule
