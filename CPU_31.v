
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/16 20:13:41
// Design Name: 
// Module Name: CPU_31
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


module CPU_31(
   input clk,
   input rst,
   input [15:0] sw,
   output [7:0] o_seg,
   output [7:0] o_sel
    );
    wire SW;
    wire LW;
    wire switch_cs;
    wire [31:0]dmem_addr;
    wire [31:0]Instruction;
    wire [31:0]Iaddr;
    wire [31:0]next_Iaddr;
    wire [31:0]jump_Iaddr;
    wire [31:0]F;
    wire [31:0]M1out;
    wire [31:0]M2out;
    wire [31:0]M3out;
    wire [31:0]M4out;
    wire [31:0]M5out;
    wire [4:0]M6out;
    wire [31:0]Imm5;
    wire [31:0]Imm16;
    wire [31:0]Imm18;
    wire [31:0]rsdata;
    wire [31:0]rtdata;
    wire [31:0] rddata;
    wire [31:0]DM_data;
    wire [31:0]IIout;
    wire [31:0]btdata;
     wire [31:0] status;
     wire [31:0] exc_addr;
     wire[31:0] mfc0data;
     wire [31:0] hidata;
     wire [31:0] lodata;
    wire [31:0] muldata;
    wire seg_cs;
    wire [31:0] data0;
    wire locked;
    wire [4:0]RSC;
    wire [4:0]RTC;
    wire [4:0]RDC;
    wire [4:0]ALUC;
    wire [1:0]M1;
    wire [1:0]M2;
    wire [1:0]M6;
    wire M7;
    wire [2:0] bt;
    wire exception;
    wire [4:0]cause;
    wire SB;
    wire SH;
    wire clk_out;
    wire clk_out1;
     wire  zzzz;
     wire [31:0] o;
    assign dmem_addr=(F-32'h10010000)>>2;
    assign RSC=Instruction[25:21];
    assign RTC=Instruction[20:16];
    assign RDC=Instruction[15:11];
    //assign clk_out=clk;
    clk_ip clk_div(clk,clk_out1,locked);
    
    Instruction_Decoder ID(Instruction[31:26],Instruction[25:21],Instruction[5:0], //input
      ADD,ADDU,SUB,SUBU,AND,OR,XOR,NOR,
      SLT,SLTU,SLL,SRL,SRA,SLLV,SRLV,SRAV,
      JR,ADDI,ADDIU,ANDI,ORI,XORI,LW,SW,
      BEQ,BNE,SLTI,SLTIU,LUI,J,JAL,
      CLZ,DIVU, ERET, JALR,  LB,   LBU,  LHU,  
      SB,   SH,    LH,    MFC0,MFHI,  MFLO, MTC0, MTHI, 
      MTLO,MUL,MULTU,SYSCALL,TEQ,   BGEZ, BREAK, DIV   );

      
    Control_Signal CS(
      ADD,ADDU,SUB,SUBU,AND,OR,XOR,NOR,
      SLT,SLTU,SLL,SRL,SRA,SLLV,SRLV,SRAV,
      JR,ADDI,ADDIU,ANDI,ORI,XORI,LW,SW,
      BEQ,BNE,SLTI,SLTIU,LUI,J,JAL,
      CLZ,DIVU, ERET, JALR,  LB,   LBU,  LHU,  
       SB,   SH,    LH,    MFC0,MFHI,  MFLO, MTC0, MTHI, 
      MTLO,MUL,MULTU,SYSCALL,TEQ,   BGEZ, BREAK, DIV,
      zero,Instruction, rsdata,rtdata,         //input
      IM_R,RF_W,ALUC,DM_CS,DM_R,DM_W,M1,M2,M3,M4,M5,M6,M7,bt,cause,zzzz,exception);
     
    Reg PC(clk_out,rst||(!locked),1'b1,(exception==1)?exc_addr:M1out,Iaddr);//rst||(!locked)
    
    Adder NPC(Iaddr,32'b00000000_00000000_00000000_00000001,next_Iaddr);
    
    Adder AD(Imm18,next_Iaddr,jump_Iaddr);
    
    alu ALU(M3out,M4out,ALUC,F,zero,carry,negative,overflow);
    
    Regfiles RF(clk_out,rst||(!locked),RF_W,RSC,RTC,M6out,(MFC0==1)?mfc0data:M2out,rsdata,rtdata);//rst||(!locked)
  
    // multu chengfa(clk_out,rst,MULTU,rsdata,rtdata,{HI,LO},zero);
     lohi LOHI(clk_out,rst||(!locked),MTLO||MTHI||MULTU||DIV||DIVU,MTLO,MTHI,MFLO,MFHI,MULTU,DIV,DIVU,(MTLO==1)?rsdata:lodata,(MTHI==1)?rsdata:hidata,rddata);
     
     multidiv md(MUL,MULTU,DIV,DIVU,rsdata,rtdata,lodata,hidata,muldata,zero);
     
    // Imem IM(clk_out,1'b1,1'b0,Iaddr,Instruction);
     imem_ip IM(Iaddr[10:0],Instruction);
   
     Dmem DM(clk_out,rst||(!locked),SW,LW,bt,SB,SH,Instruction,F,F,rtdata,DM_data,btdata,data0);
     //dmem_ip DM(dmem_addr[7:0],rtdata,clk_out,DM_W,DM_data);
    
    EXT5 ext5(Instruction[10:6],Imm5);
    
    EXT16 ext16(Instruction[15:0],ADDI||ADDIU||LW||SW||BEQ||BNE||SLTI||LB||LBU||LH||LHU||SB||SH,Imm16);
    
    EXT18 ext18(Instruction[15:0],Imm18);
    
    II inst(Iaddr[31:28],Instruction[25:0],IIout);
   // jalr_addr ady(Iaddr,rsdata,o);

    MUX3_1 MUX1(IIout,M5out,(JALR==1)?rsdata:rsdata,M1,M1out);//pcreg前的选择
    
    MUX3_1 MUX2((switch_cs==1?rdata:((bt==3'b000)?DM_data:btdata)),(M7==1)?rddata:((MFC0==1)?mfc0data:((MUL==1)?muldata:F)),next_Iaddr,M2,M2out);//写如寄存器堆的数据的选择
    
    MUX2_1 MUX3(Imm5,rsdata,M3,M3out);//alu操作数a的选择
    
    MUX2_1 MUX4(rtdata,Imm16,M4,M4out);//alu操作数b的选择
    
    MUX2_1 MUX5(next_Iaddr,jump_Iaddr,M5,M5out);//是跳还是npc
    
    MUX5bit3_1 MUX6(RDC,RTC,M6,M6out);//写入寄存器堆的地址选择
    
     
   
   
    
    cp0 CP0_reg(clk_out,rst||(!locked),MFC0||MTC0||BREAK||ERET||(TEQ && (rsdata==rtdata))||SYSCALL,MFC0,MTC0,Iaddr,RDC,rtdata,exception,ERET,cause,mfc0data,status,exc_addr);
  //  MUX2_1 MUX7(F,rddata,M7,M7out);//MFLO。。。。。
  
  
  
//  seg7x16 seg(clk_out,rst||(!locked),seg_cs,data0,o_seg,o_sel);
//  io_sel io(F,LW||SW||LB||LBU||LH||LHU||SB||SH,seg_cs);
    
//   fp hz(clk_out1,rst||(!locked),clk_out);
   io_sel io_mem(F,DM_CS,DM_W,DM_R,seg7_cs,switch_cs);
   
   sw_mem_sel sw_mem(switch_cs,sw,DM_data,rdata);
   
   seg7x16 seg7(clk_out,rst||(!locked),seg7_cs,rtdata,o_seg,o_sel);
endmodule


