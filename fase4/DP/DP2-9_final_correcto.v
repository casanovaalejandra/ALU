

module register (output reg signed [31:0]Q, input Ld, Clk, input [31:0] D); // We can use it for: MDR,IR,PC,nPC,High,LOW,
  always @ (posedge Clk) begin
     //$display("inside register module\n");
    if (Ld) Q <= D;
  end
endmodule

// REGISTER 0 MODULE
module registerR0 (output reg [31:0]Q, input Ld, Clk, input [31:0] D);
  always @ (posedge Clk)begin
  //$display("inside register0 module\n");
  Q <= 32'h00000000;
end
endmodule

module registerMAR(output reg[8:0]Q,input Ld,Clk,input[8:0]D);
  always@(posedge Clk)begin
//  $display("inside registerMAR module\n");
    if(Ld) Q<=D;
  end
endmodule


module FlagsRegister(output reg Z,N,V,C, input Ld,Clk,Zi,Ni,Vi,Ci);
  always@(posedge Clk) begin
 // $display("inside FlagsRegister\n");
  if(Ld) begin
    Z<=Zi;
    N<=Ni;
    V<=Vi;
    C<=Vi;
  end
end
endmodule

module shifterAndSignExtender(output reg[31:0]Q, input[31:0] D,shift);
  integer i;
   
  always@(D,shift)begin
  //SRA
   if(D[31:26] == 6'b000000 && D[5:0] == 6'b000011) begin
      assign Q = $signed(shift) >>> D[10:6];
   end
   //SLL
   else if(D[31:26] == 6'b000000 && D[5:0] == 6'b000000) begin
      assign Q = shift << D[10:6];
   end
   //SRL
   else if(D[31:26] == 6'b000000 && D[5:0] == 6'b000010) begin
      assign Q = shift >> D[10:6];
   end
   else begin
        assign Q[15:0] = D[15:0];
        if(D[15]) begin
          assign Q[31:16] = 16'b1111111111111111;
        end
        else begin
           assign Q[31:16] = 16'b0000000000000000;
        end
    end
  end
  endmodule

module adderNPC(input wire [31:0] In, output reg [31:0] Out);
    
    always @(In) begin

  //      $display("inside adderNPC\n");
        //$display("/ninside adder: state:%b, nextState (added):%b",Operand,Out);
        //$display("IN:",In);
        Out = In + 31'b0000000000000000000000000000100;
    end
endmodule
module mux2x1x5(output reg [4:0] Y, input[4:0] I0,I1,input S); 
always@(I0,I1,S) begin
//$display("inside mux2x5x1 module\n");
  case(S)
    0:Y=I0;
    1:Y=I1;
  endcase
end
endmodule

module mux2x1x6(output reg [5:0] Y, input[5:0] I0,I1,input S); 
always@(I0,I1,S) begin
//$display("inside mux2x5x1 module\n");
  case(S)
    0:Y=I0;
    1:Y=I1;
  endcase
end
endmodule

module mux3x1x5(output reg[4:0]Y, input[4:0] I0,I1,I2,input[1:0] S);
  always@(I0,I1,I2,S) begin
  //$display("inside mux3x1x5 module\n");
  case(S)
    0:Y=I0;
    1:Y=I1;
    2:Y=I2;
  endcase
end
endmodule

module mux4x1x32(output reg[31:0]Y, input [31:0] I0,I1,I2,I3,input[1:0]S);
  always@(I0,I1,I2,I3,S) begin
 // $display("inside mux4x1x32 module\n");
  case(S)
    0:Y=I0;
    1:Y=I1;
    2:Y=I2;
    3:Y=I3;
  endcase
end 
endmodule


module mux4x1x32NPC(output reg[31:0]Y, input [31:0] I0,I1,I2,I3,input S1,S0);
  reg [1:0] s;
  always@(I0,I1,I2,I3,S1,S0) begin
 //$display("S1:%b S0:%b\n",S1,S0);
  s[0] = S0;
  s[1] = S1;
  case(s)
    0:Y=I0;
    1:Y=I1;
    2:Y=I2;
    3:Y=I3;
  endcase
end 
endmodule

module mux4x1x5(output reg[4:0]Y, input [4:0] I0,I1,I2,I3,input S1,S0);
  reg [1:0] s;
  always@(I0,I1,I2,I3,S1,S0) begin
 //$display("S1:%b S0:%b\n",S1,S0);
  s[0] = S0;
  s[1] = S1;
  case(s)
    0:Y=I0;
    1:Y=I1;
    2:Y=I2;
    3:Y=I3;
  endcase
end 
endmodule

module mux2x1x32(output reg[31:0]Y,input[31:0] I0,I1,input S);
 always@(I0,I1,S) begin 
// $display("inside mux2x1x32 module\n");
  case(S)
    0:Y=I0;
    1:Y=I1;
  endcase
end
endmodule

module mux5x1x32(output reg [31:0] Y, input[31:0] I0,I1,I2,I3,I4, input[2:0] S);
 always@(I0,I1,I2,I3,I4,S) begin
// $display("inside mux5x1x32 module\n");
  case(S)
    0:Y=I0;
    1:Y=I1;
    2:Y=I2;
    3:Y=I3;
    4:Y=I4;
  endcase
end 
endmodule
module mux_32x1 (
  output reg [31:0]Y,
  input [4:0]S,
  input [31:0] R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15,
               R16,R17,R18,R19,R20,R21,R22,R23,R24,R25,R26,R27,R28,R29,R30,R31);
  always @(Y,S,R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15,
               R16,R17,R18,R19,R20,R21,R22,R23,R24,R25,R26,R27,R28,R29,R30,R31)begin

    case (S)
      0: Y=R0;
      1: Y=R1;
      2: Y=R2;
      3: Y=R3;
      4: Y=R4;
      5: Y=R5;
      6: Y=R6;
      7: Y=R7;
      8: Y=R8;
      9: Y=R9;
      10: Y=R10;
      11: Y=R11;
      12: Y=R12;
      13: Y=R13;
      14: Y=R14;
      15: Y=R15;
      16: Y=R16;
      17: Y=R17;
      18: Y=R18;
      19: Y=R19;
      20: Y=R20;
      21: Y=R21;
      22: Y=R22;
      23: Y=R23;
      24: Y=R24;
      25: Y=R25;
      26: Y=R26;
      27: Y=R27;
      28: Y=R28;
      29: Y=R29;
      30: Y=R30;
      31: Y=R31;
    endcase

  end 
  // initial begin
  //   $display("inside mux_32x1 module PA:%b"Y);
  // end

endmodule

// BINARY DECODER MODULE

module binary_decoder_32 (
  output reg [31:0]E,
  input [4:0]D,
  input LD);
  always @(E,D,LD)begin
//  $display("inside binary_decoder_32 module\n");
  if (LD) begin : IF_LOAD
    integer i;
    for (i =0; i<32; i=i+1) begin
      if (i == D) begin
        E[D] = 1;
      end else begin
        E[i] = 0;
      end
    end
  end else begin
    E = 32'h00000000;
  end
end
endmodule

module rf (
  output wire [31:0] PA, PB,
  input [31:0] PC,
  input [4:0] A, B, C,
  input RF, Clk
  );
  wire [31:0] E;
  wire [31:0] Q[31:0];
  binary_decoder_32 dec(E,C,RF);

  registerR0 R0(Q[0],E[0],Clk,PC);
  register R1(Q[1],E[1],Clk,PC);
  register R2(Q[2],E[2],Clk,PC);
  register R3(Q[3],E[3],Clk,PC);
  register R4(Q[4],E[4],Clk,PC);
  register R5(Q[5],E[5],Clk,PC);
  register R6(Q[6],E[6],Clk,PC);
  register R7(Q[7],E[7],Clk,PC);
  register R8(Q[8],E[8],Clk,PC);
  register R9(Q[9],E[9],Clk,PC);
  register R10(Q[10],E[10],Clk,PC);
  register R11(Q[11],E[11],Clk,PC);
  register R12(Q[12],E[12],Clk,PC);
  register R13(Q[13],E[13],Clk,PC);
  register R14(Q[14],E[14],Clk,PC);
  register R15(Q[15],E[15],Clk,PC);
  register R16(Q[16],E[16],Clk,PC);
  register R17(Q[17],E[17],Clk,PC);
  register R18(Q[18],E[18],Clk,PC);
  register R19(Q[19],E[19],Clk,PC);
  register R20(Q[20],E[20],Clk,PC);
  register R21(Q[21],E[21],Clk,PC);
  register R22(Q[22],E[22],Clk,PC);
  register R23(Q[23],E[23],Clk,PC);
  register R24(Q[24],E[24],Clk,PC);
  register R25(Q[25],E[25],Clk,PC);
  register R26(Q[26],E[26],Clk,PC);
  register R27(Q[27],E[27],Clk,PC);
  register R28(Q[28],E[28],Clk,PC);
  register R29(Q[29],E[29],Clk,PC);
  register R30(Q[30],E[30],Clk,PC);
  register R31(Q[31],E[31],Clk,PC);

  mux_32x1 muxA(PA, A, Q[0], Q[1], Q[2], Q[3], Q[4], Q[5], Q[6], Q[7], Q[8],
                Q[9], Q[10], Q[11], Q[12], Q[13], Q[14], Q[15], Q[16], Q[17], Q[18], Q[19], Q[20], Q[21], Q[22], Q[23], Q[24], Q[25], Q[26], Q[27], Q[28], Q[29], Q[30], Q[31]);
  mux_32x1 muxB(PB, B, Q[0], Q[1], Q[2], Q[3], Q[4], Q[5], Q[6], Q[7], Q[8],
                Q[9], Q[10], Q[11], Q[12], Q[13], Q[14], Q[15], Q[16], Q[17], Q[18], Q[19], Q[20], Q[21], Q[22], Q[23], Q[24], Q[25], Q[26], Q[27], Q[28], Q[29], Q[30], Q[31]);

//$display("PA:%b",PA);
endmodule


/********************************************************************************************************/
/********************************************************************************************************/
/*******************************************RAM**********************************************************/
/********************************************************************************************************/
/********************************************************************************************************/
/********************************************************************************************************/
//Modulo para memoria RAM de 512 bytes
module ram512x8 (output reg [31:0] DataOut, input Enable, ReadWrite, FHDWCI, signedExtend, input [8:0] Address, input [31:0] DataIn, 
    input [1:0] DataType,output reg MOC, output reg FHDWCO);

/*Códigos de DataTypes: 
    00: byte
    01: halfword
    10: word
    11: doubleword
*/

reg [7:0] Mem[0:511];   //512 localizaciones de 8 bits (1 byte por localización)
reg [7:0] Temp; //Byte temporero para colocar los words en posiciones divisibles por 4 (para words)
integer i;
always @ (Enable, ReadWrite) begin  //Cuando Enable o ReadWrite cambian de 0 a 1 o de 1 a 0
    //#5  //Retraso de 5 unidades de tiempo para...                 
   // $display("inside RAM\n");
    MOC = 1'b0;
    if(Enable) //Si la señal MOV es 1
        begin

            //READ
            if(ReadWrite) //Si ReadWrite es 1, iniciar proceso de leer de la memoria
                begin
                    case(DataType)
                        2'b00 : begin//byte
                        i=8;
                        if(signedExtend)begin
                         
                            DataOut = Mem[Address]; //El bus de salida tendra los 8 bits de la direccion indicada por Address
                            repeat(24)begin
                              DataOut[i]=Mem[Address][7];
                              i=i+1;
                            end
                        end
                        else
                          DataOut = Mem[Address];
                        end
                        
                        2'b01 : begin //half word
                            i=16;
                              if(signedExtend)begin
                                if(!Address[0]) //Si la direccion entrada es un numero par
                                  begin
                                    DataOut[15:8] = Mem[Address]; // byte mas significativo en memoria menor
                                    DataOut[7:0] = Mem[Address + 1];
                                    repeat(16)begin
                                       DataOut[i]=Mem[Address][7];
                                        i=i+1;
                                    end
                                end
                            else //si es inpar, byte mas significativo esta en la direccion anterior a la direccion indicada. 
                              begin
                                 DataOut[15:8] = Mem[Address-1];
                                 DataOut[7:0] = Mem[Address];
                                 repeat(16) begin
                                  DataOut[i]=Mem[Address][7];
                                  i = i+1;
                                end
                              end
                          end
                          else begin
                            if(!Address[0]) //Si la direccion entrada es un numero par
                                begin
                                    DataOut[15:8] = Mem[Address]; // byte mas significativo en memoria menor
                                    DataOut[7:0] = Mem[Address + 1];
                                    DataOut[31:16] = 0;
                                end
                                else //si es inpar, byte mas significativo esta en la direccion anterior a la direccion indicada. 
                                begin
                                    DataOut[15:8] = Mem[Address-1];
                                    DataOut[7:0] = Mem[Address];
                                    DataOut[31:16] = 0;
                                end
                            end
                        end

                        2'b10 : // word
                          begin 
                            if(!Address[0] && !Address[1]) //Si la direccion de entrada es numero divisible por 4
                              begin
                                DataOut[31:24] = Mem[Address]; 
                                DataOut[23:16] = Mem[Address + 1];
                                DataOut[15:8] = Mem[Address + 2];
                                DataOut[7:0] = Mem[Address + 3];
                              end
                            
                            else 
                              begin
                                Temp = Address; //poner el Address en otra variable para bajar una localizacion diviisible por 4
                                Temp[0] = 0;
                                Temp[1] = 0;
                                DataOut[31:24] = Mem[Temp];
                                DataOut[23:16] = Mem[Temp + 1];
                                DataOut[15:8] = Mem[Temp + 2];
                                DataOut[7:0] = Mem[Temp + 3];
                              end 
                            
                          end

                        2'b11 : 
                          begin //doubleword, se asume que lo primero que envia el cpu es la parte menos significativa
                            begin
                            if(!Address[0] && !Address[1]) //Si la direccion de entrada es numero divisible por 4
                              if(FHDWCI) //si ya se leyo la primera mitad del doubleword, ejecutar este codigo. 
                                begin
                                  DataOut[31:24] = Mem[Address + 4];
                                  DataOut[23:16] = Mem[Address + 5];
                                  DataOut[15:8] = Mem[Address + 6];
                                  DataOut[7:0] = Mem[Address + 7];
                                end
                              else
                                begin
                                  DataOut[31:24] = Mem[Address];
                                  DataOut[23:16] = Mem[Address + 1];
                                  DataOut[15:8] = Mem[Address + 2];
                                  DataOut[7:0] = Mem[Address + 3];
                                end
                              
                              
                            else //si la direccion no es un numero divisible por 4. 
                              begin
                                Temp = Address;
                                Temp[0] = 0;
                                Temp[1] = 0;
                                Mem[Temp] = DataIn[31:24];
                                Mem[Temp + 1] = DataIn[23:16];
                                Mem[Temp + 2] = DataIn[15:8];
                                Mem[Temp + 3] = DataIn[7:0];
                              end
                              
                            if(!FHDWCI)
                              begin
                                FHDWCO = 1; //Fisrst Half of Double Word Completed
                              end
                          end
                          end
                    endcase
                    #2 MOC = 1'b1;
                    //MOC = 1'b0;
                end
            
                
            //Write
            else   
                begin
                    case(DataType)
                       2'b00 : //byte
                        begin 
                          Mem[Address] = DataIn;
                        end
                        
                      2'b01 : //half word
                          begin 
                            if(!Address[0]) //Si la direccion entrada es un numero par
                              begin
                                Mem[Address] = DataIn[15:8];
                                Mem[Address + 1] = DataIn[7:0]; 
                              end
                            else //si es inpar
                              begin
                                Mem[Address - 1] = DataIn[15:8];
                                Mem[Address] = DataIn[7:0]; 
                              end
                          end

                        2'b10 :  // word
                          begin
                            if(!Address[0] && !Address[1]) //Si la direccion de entrada es numero divisible por 4
                              begin
                                Mem[Address] = DataIn[31:24];
                                Mem[Address + 1] = DataIn[23:16];
                                Mem[Address + 2] = DataIn[15:8];
                                Mem[Address + 3] = DataIn[7:0];
                              end
                            
                            else 
                              begin
                                Temp = Address;
                                Temp[0] = 0;
                                Temp[1] = 0;
                                Mem[Temp] = DataIn[31:24];
                                Mem[Temp + 1] = DataIn[23:16];
                                Mem[Temp + 2] = DataIn[15:8];
                                Mem[Temp + 3] = DataIn[7:0];
                              end 
                            
                          end

                        2'b11: 
                          begin
                            if(!Address[0] && !Address[1]) //Si la direccion de entrada es numero divisible por 4
                              if(FHDWCI)
                                begin
                                  Mem[Address] = DataIn[31:24];
                                  Mem[Address + 1] = DataIn[23:16];
                                  Mem[Address + 2] = DataIn[15:8];
                                  Mem[Address + 3] = DataIn[7:0];
                                end
                              else
                                begin
                                  Mem[Address + 4] = DataIn[31:24];
                                  Mem[Address + 5] = DataIn[23:16];
                                  Mem[Address + 6] = DataIn[15:8];
                                  Mem[Address + 7] = DataIn[7:0];
                                end
                              
                              
                            else 
                              begin
                                Temp = Address;
                                Temp[0] = 0;
                                Temp[1] = 0;
                                Mem[Temp] = DataIn[31:24];
                                Mem[Temp + 1] = DataIn[23:16];
                                Mem[Temp + 2] = DataIn[15:8];
                                Mem[Temp + 3] = DataIn[7:0];
                              end
                              
                            // if(!FHDWCI)
                            //   begin
                            //     #1
                            //     FHDWCO = 1;
                            //   end
                          end
                    endcase
                     #2 MOC = 1'b1;
                end

        end
    end
    
    initial begin
        //ADD
        Mem[0] = 8'b00100100;
        Mem[1] = 8'b00000001;
        Mem[2] = 8'b00000000;
        Mem[3] = 8'b00100010;

        Mem[4] = 8'b00100100;
        Mem[5] = 8'b00000100;
        Mem[6] = 8'b00000000;
        Mem[7] = 8'b11011100;

        Mem[8] = 8'b00000000;
        Mem[9] = 8'b00000100;
        Mem[10] = 8'b01010000;
        Mem[11] = 8'b00100101;

        Mem[12] = 8'b10001101;
        Mem[13] = 8'b01000011;
        Mem[14] = 8'b00000000;
        Mem[15] = 8'b00000000;

        Mem[16] = 8'b00100101;
        Mem[17] = 8'b01001010;
        Mem[18] = 8'b00000000;
        Mem[19] = 8'b00000100;

        Mem[20] = 8'b00000000;
        Mem[21] = 8'b00100011;
        Mem[22] = 8'b00010000;
        Mem[23] = 8'b00100001;

        Mem[24] = 8'b00000000;
        Mem[25] = 8'b00000010;
        Mem[26] = 8'b00101000;
        Mem[27] = 8'b00100101;

        Mem[28] = 8'b10101101;
        Mem[29] = 8'b01000101;
        Mem[30] = 8'b00000000;
        Mem[31] = 8'b00000000;

        //00100101 01001010 00000000 00000100
        Mem[32] = 8'b00100101;
        Mem[33] = 8'b01001010;
        Mem[34] = 8'b00000000;
        Mem[35] = 8'b00000100;

        Mem[36] = 8'b00000000;
        Mem[37] = 8'b00100010;
        Mem[38] = 8'b00101000;
        Mem[39] = 8'b00100011;

        //10101101 01000101 00000000 00000000
        Mem[40] = 8'b10101101;
        Mem[41] = 8'b01000101;
        Mem[42] = 8'b00000000;
        Mem[43] = 8'b00000000;

        Mem[44] = 8'b00100101;
        Mem[45] = 8'b01001010;
        Mem[46] = 8'b00000000;
        Mem[47] = 8'b00000100;

        Mem[48] = 8'b00000000;
        Mem[49] = 8'b00100010;
        Mem[50] = 8'b00101000;
        Mem[51] = 8'b00101011;

        Mem[52] = 8'b10101101;
        Mem[53] = 8'b01000101;
        Mem[54] = 8'b00000000;
        Mem[55] = 8'b00000000;

        Mem[56] = 8'b00100101;
        Mem[57] = 8'b01001010;
        Mem[58] = 8'b00000000;
        Mem[59] = 8'b00000100;

        Mem[60] = 8'b00000000;
        Mem[61] = 8'b00000011;
        Mem[62] = 8'b00101000;
        Mem[63] = 8'b11000011;

        Mem[64] = 8'b10101101;
        Mem[65] = 8'b01000101;
        Mem[66] = 8'b00000000;
        Mem[67] = 8'b00000000;

        Mem[68] = 8'b00100101;
        Mem[69] = 8'b01001010;
        Mem[70] = 8'b00000000;
        Mem[71] = 8'b00000100;

        Mem[72] = 8'b00000000;
        Mem[73] = 8'b00000011;
        Mem[74] = 8'b00101000;
        Mem[75] = 8'b11000000;

        Mem[76] = 8'b10101101;
        Mem[77] = 8'b01000101;
        Mem[78] = 8'b00000000;
        Mem[79] = 8'b00000000;

        Mem[80] = 8'b00100101;
        Mem[81] = 8'b01001010;
        Mem[82] = 8'b00000000;
        Mem[83] = 8'b00000100;

        Mem[84] = 8'b00000000;
        Mem[85] = 8'b00000011;
        Mem[86] = 8'b00101000;
        Mem[87] = 8'b11000010;

        Mem[88] = 8'b10101101;
        Mem[89] = 8'b01000101;
        Mem[90] = 8'b00000000;
        Mem[91] = 8'b00000000;

        //00100101 01001010 00000000 00000100
        Mem[92] = 8'b00100101;
        Mem[93] = 8'b01001010;
        Mem[94] = 8'b00000000;
        Mem[95] = 8'b00000100;

        Mem[96] = 8'b00000100;
        Mem[97] = 8'b00010001;
        Mem[98] = 8'b00000000;
        Mem[99] = 8'b00000011;

        Mem[100] = 8'b00100100;
        Mem[101] = 8'b00001000;
        Mem[102] = 8'b00000000;
        Mem[103] = 8'b00011100;

        //00000000 00000000 00000000 00000000
        Mem[104] = 8'b00000000;
        Mem[105] = 8'b00000000;
        Mem[106] = 8'b00000000;
        Mem[107] = 8'b00000000;

        Mem[108] = 8'b00000000;
        Mem[109] = 8'b00000000;
        Mem[110] = 8'b00000000;
        Mem[111] = 8'b00000000;

        Mem[112] = 8'b00000001;
        Mem[113] = 8'b00011111;
        Mem[114] = 8'b11111000;
        Mem[115] = 8'b00100001;

        Mem[116] = 8'b10101101;
        Mem[117] = 8'b01011111;
        Mem[118] = 8'b00000000;
        Mem[119] = 8'b00000000;

        Mem[120] = 8'b00000011;
        Mem[121] = 8'b11100000;
        Mem[122] = 8'b00000000;
        Mem[123] = 8'b00001000;

        //00100101 01001010 00000000 00000100
        Mem[124] = 8'b00100101;
        Mem[125] = 8'b01001010;
        Mem[126] = 8'b00000000;
        Mem[127] = 8'b00000100;

        //00000000 00000000 00000000 00000000
        Mem[128] = 8'b00000000;
        Mem[129] = 8'b00000000;
        Mem[130] = 8'b00000000;
        Mem[131] = 8'b00000000;

        Mem[132] = 8'b10001100;
        Mem[133] = 8'b10001100;
        Mem[134] = 8'b11111111;
        Mem[135] = 8'b11111100;

        Mem[136] = 8'b10001100;
        Mem[137] = 8'b10001011;
        Mem[138] = 8'b11111111;
        Mem[139] = 8'b11111000;

        Mem[140] = 8'b00000001;
        Mem[141] = 8'b10001011;
        Mem[142] = 8'b00000000;
        Mem[143] = 8'b00011001;

        Mem[144] = 8'b00000000;
        Mem[145] = 8'b00000000;
        Mem[146] = 8'b01101000;
        Mem[147] = 8'b00010000;

        Mem[148] = 8'b00000000;
        Mem[149] = 8'b00000000;
        Mem[150] = 8'b01110000;
        Mem[151] = 8'b00010010;

        Mem[152] = 8'b10101101;
        Mem[153] = 8'b01001101;
        Mem[154] = 8'b00000000;
        Mem[155] = 8'b00000000;

        Mem[156] = 8'b00100101;
        Mem[157] = 8'b01001010;
        Mem[158] = 8'b00000000;
        Mem[159] = 8'b00000100;

        Mem[160] = 8'b10101101;
        Mem[161] = 8'b01001110;
        Mem[162] = 8'b00000000;
        Mem[163] = 8'b00000000;

        Mem[164] = 8'b00100101;
        Mem[165] = 8'b01001010;
        Mem[166] = 8'b00000000;
        Mem[167] = 8'b00000100;

        Mem[168] = 8'b00000001;
        Mem[169] = 8'b01100000;
        Mem[170] = 8'b00000000;
        Mem[171] = 8'b00010001;

        Mem[172] = 8'b00000001;
        Mem[173] = 8'b10000000;
        Mem[174] = 8'b00000000;
        Mem[175] = 8'b00010011;

        Mem[176] = 8'b00000000;
        Mem[177] = 8'b00000000;
        Mem[178] = 8'b01101000;
        Mem[179] = 8'b00010000;

        Mem[180] = 8'b00000000;
        Mem[181] = 8'b00000000;
        Mem[182] = 8'b01110000;
        Mem[183] = 8'b00010010;

        Mem[184] = 8'b10101101;
        Mem[185] = 8'b01001101;
        Mem[186] = 8'b00000000;
        Mem[187] = 8'b00000000;

        Mem[188] = 8'b00100101;
        Mem[189] = 8'b01001010;
        Mem[190] = 8'b00000000;
        Mem[191] = 8'b00000100;

        Mem[192] = 8'b10101101;
        Mem[193] = 8'b01001110;
        Mem[194] = 8'b00000000;
        Mem[195] = 8'b00000000;

        Mem[196] = 8'b00100101;
        Mem[197] = 8'b01001010;
        Mem[198] = 8'b00000000;
        Mem[199] = 8'b00000100;

        //00000000 00000000 00000000 00000000
        Mem[200] = 8'b00000000;
        Mem[201] = 8'b00000000;
        Mem[202] = 8'b00000000;
        Mem[203] = 8'b00000000;

        Mem[204] = 8'b00000000;
        Mem[205] = 8'b00000000;
        Mem[206] = 8'b11111111;
        Mem[207] = 8'b11111111;

        //00000000 00000000 00000000 00000000
        Mem[208] = 8'b00000000;
        Mem[209] = 8'b00000000;
        Mem[210] = 8'b00000000;
        Mem[211] = 8'b00000000;

        Mem[212] = 8'b10100000;
        Mem[213] = 8'b00000000;
        Mem[214] = 8'b00000000;
        Mem[215] = 8'b00000000;

        Mem[216] = 8'b11000000;
        Mem[217] = 8'b00000000;
        Mem[218] = 8'b00000000;
        Mem[219] = 8'b00000000;

        Mem[220] = 8'b11111111;
        Mem[221] = 8'b11111111;
        Mem[222] = 8'b11111111;
        Mem[223] = 8'b11110101;
    end
endmodule
/********************************************************************************************************/
/********************************************************************************************************/
/***********************************************END RAM**************************************************/
/********************************************************************************************************/
/********************************************************************************************************/
/********************************************************************************************************/

/********************************************************************************************************/
/********************************************************************************************************/
/***********************************************ALU******************************************************/
/********************************************************************************************************/
/********************************************************************************************************/
/********************************************************************************************************/
// Created by Alejandra Casanova Sepulveda
module ALU(
  output reg [31:0] respuesta, //this is the output of the ALU 
  output reg [31:0] outHigh,   //for the numbers whose result is more than 32 bits
  output reg [31:0] outLow,
  input[31:0] A, B,
  input[5:0] operation,func,
  input sign,
  output reg Z, //zero flag
  output reg N, //negative flag
  output reg C, //carry flag
  output reg V  //overflow flags
);
integer i,c; //for leadding 1's and 0's
// reg[63:0] res, Aex, Bex;
always @ (A,B,operation,func) begin
  //$display("inside ALU module:opcode=%b",operation);
  //$display("A:%b, B:%b",A,B);
  

  case (operation) 


 //************************************************ADDU******************************************/
 //WORKSSSSSSSSS
 6'b000000: 
  case(func)
    6'b100001:
    begin
      N=0;
      V=0;
      Z=0;
      C=0;
      assign{C,respuesta}=$unsigned(A)+$unsigned(B); // grabs the carry 
           // $display("respuesta2 dentro del caso:%b",respuesta);

        if((A[31]==B[31])&& respuesta[31]!=A[31])
          begin 
            V=1;
          end
      /*  else if(C==1) 
          begin
            V=1;
          end*/
      //$display("respuesta dentro del caso:%b",respuesta);
      end
    //***********************************************END ADDU***********************************/
    //*************************************************ADD*************************************/
    //WORKSSSS
    6'b100000:
      begin
        N=0;
        V=0;
        Z=0;
        C=0;
        assign{C,respuesta}=$signed(A)+$signed(B); //here we take care of the carry with sinificant bits 
    //negative flag
         if(A<B)
          begin
            N=1;
          end
        else begin N = 0; end
    //overflow
          if((A[31]==0 && B[31]==0) && respuesta[31]==1)begin //two positive numbers must result on positive 
            V = 1;
            Z=1;
          end
          else if((A[31]==1 && B[31]==1) && respuesta[31]==0)begin //two negatives must result in negative 
            V = 1;
            Z=1;
          end
    //zero flag
          else if(respuesta == 0) begin      //si el resultado es zero
             Z=1;
          end
      end
      //**************************************END ADD*********************************************/
      //****************************************SUBS**********************************************/
      //WORKSSSSSSSSSSSSSSS
      6'b100010:
        begin
        N=0;
        V=0;
        Z=0;
        C=0;
          assign{C,respuesta}=$signed(A)-$signed(B);
          if(respuesta == 0)begin
            Z = 1;
          end
          else if($signed(A)<$signed(B))begin
            C = 1;
            N = 1;
          end
          else if(A[31] == 1 && B[31] == 0 ) //this means that the result will be negative
            begin
              N = 1;
              if (respuesta[31] == 0)
                begin
                  V = 1;
                end
            end
          else if(A[31] == 0 && B[31] == 1) //this means that the result will be positive
            begin
              N = 0;
              if(respuesta[31] == 1)
                begin
                  V = 1;
                end
            end
          end
        //***************************************************SUBU*************************************************/
        //WOKSSSSSSSS
      6'b100011:
        begin
        Z=0;
        N=0;
        V=0;
        C=0;
        assign {C,respuesta}=$unsigned(A)-$unsigned(B); //takes care of the carry bit
          if(respuesta[31]==1)
            begin
              N=1;
            end
            //zero flag
            if(respuesta == 0) 
              begin
                Z=1;
              end
            //Overflow flag
            // if((A[31]!=B[31]) && (B[31]!=respuesta[31])) 
            //   begin
            //     V=1;
            //   end
          end
        //**************************************************END SUBU*****************************************************/
      //AND
      6'b100100: respuesta = A & B;

      //OR
      6'b100101: assign{C,respuesta} = $unsigned(A) | $unsigned(B);
      //XOR
      6'b100110: respuesta = A ^ B;

      //NOR
      6'b100111: respuesta = ~(A ^ B);

      //SLL Shit word left logical (Ahora se hace en el SASE)
      6'b000000: respuesta = A << B;
      //here B = sa

      //SSLV Shift Word Left Logical Variable
      6'b000100: respuesta = A << B[4:0];

      //SRA
      6'b000011: assign respuesta =  $signed(A) >>> B;
      //B = sa

      //SRAV
      6'b000111: respuesta = $signed(A) >>> B[4:0];

      //SRL
      6'b000010: respuesta = A >> B;

      //SLRV
      6'b000110: respuesta = A >> B[4:0];

      6'b101010: 
       //***************************************************SLT**************************************************************/
       //rs = A rt = B
       //woks
        begin
          if($signed(A)<$signed(B))begin
           assign{C,respuesta}  = 32'b00000000000000000000000000000001;
          end
          else begin assign{C,respuesta}  = 32'b00000000000000000000000000000000;end
        end
      //*********************************************END SLT******************************************************************/
      //**********************************************SLTU*******************************************************************/
      6'b101011:
        begin
          if($unsigned(A)<$unsigned(B))begin
            assign{C,respuesta} = 32'b00000000000000000000000000000001;
          end
          else assign{C,respuesta} = 32'b00000000000000000000000000000000;
        end
        /********************************************END SLTU***************************************************************/
        //**************************************************MULTU**************************************************/
        //workssssssssssssssssss
      6'b011001: 
        // begin 
          // if(sign == 0) begin
          //      $display("A:%d B:%d",A,B);
          //      assign{outHigh,outLow} = $unsigned({32'h00000000,A})*$unsigned({32'h00000000,B});
          //      N=1;
          // end 
          // else begin
          //      assign{outHigh,outLow} = $signed({32'h00000000,A})*$signed({32'h00000000,B});
          //      N=0;
          // end
          begin
            if(sign == 0) begin
               assign{outHigh,outLow} = $unsigned({32'h00000000,A})*$unsigned({32'h00000000,B});
               N=1;
            //    assign Aex[63:32] = 32'b0;
            //    assign Aex[31:0] = $unsigned(A);
            //    assign Bex[63:32] = 32'b0;
            //    assign Bex[31:0] = $unsigned(B);

            //    assign res = $unsigned(Aex)*$unsigned(Bex);
            //    assign outHigh = $unsigned(res[63:32]);
            //    assign outLow = $unsigned(res[31:0]);
            //    $display("A:%d B:%d res:%d",A,B,res);
            end 
            else begin
               assign{outHigh,outLow} = $signed({32'h00000000,A})*$signed({32'h00000000,B});
               N=0;
            end   
          end
      6'b010001: assign outHigh = $unsigned(A);
      6'b010011: assign outLow = $unsigned(A);
/***************************************END MULTU*******************************************************/

  endcase
//********************************************************SLTI**************************************************************/
6'b001010:
//rs = A
//inme = B
  begin
    if($signed(A)<$signed(B))begin
      respuesta = 32'b00000000000000000000000000000001;
    end
    else respuesta = 32'b00000000000000000000000000000000;
  end
/**********************************************************END SLTI********************************************************/
//***********************************************************SLTIU*********************************************************/
6'b001011:
//rs = A
//inme = B
  begin
    if($unsigned(A)<$unsigned(B))begin
      respuesta = 32'b00000000000000000000000000000001;
    end
    else respuesta = 32'b00000000000000000000000000000000;
  end
/*********************************************************END SLTIU********************************************************/
//PASS A
6'b000001: begin
    assign{C,respuesta}=$unsigned(A);
    //$display("respuesta dentro del ALU:%b", respuesta);
end

6'b000010: begin
    assign{C,respuesta}=$unsigned(B);
end



// ONE'S COMPLEMENT
6'b000110:  respuesta = ~ A;
6'b000111:  respuesta = ~ B;

//LUI
6'b001111:
  begin
    respuesta[31:16] = A;     //los mas significativos de A en respuesta 
    respuesta[15:0] = 6'h00; //el resto los iguala a cero
  end

//BGTZ 
6'b010000:
//PC-->A
//SALIDA SHIFT ==B
begin 
  respuesta = (A+32'b00000000000000000000000000000100);
end

//CLO & CLZ
//BOTH WORK GOOD
6'b011100:
  case(func)
    //CLO
    6'b100001:
      begin 
        i = 31;
        c = 0;
        while(i>=0)begin
          if(A[i]===1)begin
            c=c+1;
          end
          i = i-1;
        end
        respuesta = c;
      end
      //CLZ
    6'b100000:
      begin
        i = 31;
        c =0;
        while(i>=0)begin
          if(A[i]===0)begin
            c = c+1;
          end
          i = i-1;
        end
        respuesta = c;
      end
  endcase //funct


/*******************************************ADDI*******************************************************/

6'b001000:
  begin
        N=0;
        V=0;
        Z=0;
        C=0;
        assign{C,respuesta}=$signed(A)+$signed(B); //here we take care of the carry with sinificant bits 
    //negative flag
         if(A<B)
          begin
            N=1;
          end
        else begin N = 0; end
    //overflow
          if((A[31]==0 && B[31]==0) && respuesta[31]==1)begin //two positive numbers must result on positive 
            V = 1;
            Z=1;
          end
          else if((A[31]==1 && B[31]==1) && respuesta[31]==0)begin //two negatives must result in negative 
            V = 1;
            Z=1;
          end
    //zero flag
          else if(respuesta == 0) begin      //si el resultado es zero
             Z=1;
          end
    end

/******************************************************END ADDI********************************************/

/*******************************************************ADDIU**********************************************/
6'b001001:
    begin
      N=0;
      V=0;
      Z=0;
      C=0;
    // $display("A:%b B:%b",A,B);
      assign{C,respuesta}=$unsigned(A)+$unsigned(B); // grabs the carry 
        if((A[31]==B[31])&& respuesta[31]!=A[31])
          begin 
            V=1;
          end
       // $display("resultado:%b",respuesta);
      /*  else if(C==1) 
          begin
            V=1;
          end*/
      end
/*******************************************************END ADDIU*****************************************/

/*****************************************************ANDI************************************************/
6'b001100: respuesta = A & B;
//rs = A inmed = B
/******************************************************END ANDI******************************************/

/********************************************************ORI********************************************/
6'b001101: respuesta = A | B;
//rs=A inme = B
/********************************************************END ORI******************************************/

/********************************************************XORI********************************************/
6'b001110: respuesta = A^B;
/********************************************************END XORI*****************************************/

/********************************************************B********************************************/
6'b000100: begin assign{C, respuesta} = ($signed(A) -4 +(4*$signed(B))); end
/******************************************************PC = RS*******************************************/
6'b000101: begin assign{C, respuesta} = ($signed(A) -4) ; end
//inme16 = B
/******************************************************END B******************************************/

/*****************************************************BAL**********************************************/

/******************************************************END BAL******************************************/

/*****************************************************BEQ**********************************************/
//6'b00100:
//rs = A rt = B

/******************************************************END BEQ******************************************/

//LBU
6'b100100: 
    begin
      N=0;
      V=0;
      Z=0;
      C=0;
      assign{C,respuesta}=$unsigned(A)+$unsigned(B); // grabs the carry 
           // $display("respuesta2 dentro del caso:%b",respuesta);

        if((A[31]==B[31])&& respuesta[31]!=A[31])
          begin 
            V=1;
          end
      end
//BGTZ
6'b000011: begin
    if($signed(A)>0)begin
        Z=1;
    end
    else    Z=0; 
    end
6'b111001: begin
    if($signed(A)<=0)begin
        Z=1;
    end
    else    Z=0; 
    end  
6'b100110: assign{C,respuesta}=$unsigned(A)+4;
endcase // operation
end
endmodule

/********************************************************************************************************/
/********************************************************************************************************/
/*******************************************END ALU******************************************************/
/********************************************************************************************************/
/********************************************************************************************************/
/********************************************************************************************************/


/********************************************************************************************************/
/********************************************************************************************************/
/**************************************Control Unit******************************************************/
/********************************************************************************************************/
/********************************************************************************************************/
/********************************************************************************************************/

module CU(output wire [53:0] outputFromCU,input Clk,Zflag,NFlag,VFlag,CFlag,MFC,reset, input[31:0] instruction);

wire[5:0] outputFromMux,outputFromEncoder,R1Mux,R2Mux,outputFromIncReg,outputFromAdder,currState;
wire M0,M1,mux2Out;
wire[53:0] outputFromROM,outputFromCR;

 encoder_states enc1(instruction,outputFromEncoder);
 incrementer_register inc_reg(outputFromIncReg,Clk,outputFromAdder);
 adder add1(outputFromMux,outputFromAdder);
 mux6_4x1 muxNextState(outputFromMux,M0,M1,outputFromEncoder,6'b000000,outputFromCU[13:8],outputFromIncReg);
 mux1_4x1 muxInverter(mux2Out,outputFromCU[0], outputFromCU[1], MFC, Zflag, NFlag, 1'b0);
 rom64x8 rom(outputFromROM,Clk,outputFromMux);
 control_register CR(outputFromCU,Clk,outputFromROM);
 next_state_address NSA(M0,M1,outputFromCU[17:15],outPutINverter,reset);
 inverter inv1(outPutINverter,mux2Out,outputFromCU[14]);
 
 //initial begin $display("instruction dentro del CU:%b",instruction); end
endmodule

module rom64x8 (output reg [53:0] DataOut, input Clk, input wire [5:0] Address);
    reg [53:0] Mem[0:63];
    always @ (posedge Clk, Address) begin
     // $display("inside ROM64x8 module\n");
        //$display("ROM: Clk = %b", clk);
        #2 DataOut[53:0] = Mem[Address];  
        //$display("ROM data in current:%b",Mem[Address]); 
    end

    initial begin
        Mem[0] = 54'b000000000000000000000000000110001010011000000000000000; //reset
        Mem[1] = 54'b011000001000010000000000000000000000011000000000000100; //move PC to MAR
        Mem[2] = 54'b000000000010000000000001010110000000011000000000001000; //
        Mem[3] = 54'b000000000011000000000001010000000000101100001100001100;
        Mem[4] = 54'b000000000000000000000000000000000000000000000000010000;

        //Arithmetic, Logic and Bitwise Shift Instructions Signals
        Mem[5] = 54'b000000000000000000000000001001011000010000000100010100;
        Mem[6] = 54'b000000000000000000000000100000000000010000000100011000;
        Mem[7] = 54'b000000000000000001001000001001011000010000000100011100;
        Mem[8] = 54'b000000000000000100100000100000000000010000000100100000;
        Mem[9] = 54'b000000000000000000000100001001001000010000000100100100;
        Mem[10] = 54'b001000010000000100010000100000000100010000000100101000;
        Mem[11] = 54'b000000000000000000000110001001001000010000000100101100;

        //Load/Store Instructions Signals
        Mem[12] = 54'b000001001000010100100000000000000000010001001000110000;
        //Mem[13] = 53'b00000000000100000010010100000000000010001100000110100;
        Mem[13] = 54'b001000001000100000010010000000000000010001100000110100;
        Mem[14] = 54'b000000000111100000000000010000000000010001001100111000;
        Mem[15] = 54'b0000000001110000000000000010000000010001001100111100;
        Mem[16] = 54'b0000000000110000000000000010000000010001001101000000;
        Mem[17] = 54'b0000000001110000000000000000000000010001001101000100;
        Mem[18] = 54'b000000000011000000000000000000000000011000000001001000;
        Mem[19] = 54'b000000000011000000000000000000000000101101001101001100;
        Mem[20] = 54'b001000010100001000100010100000000000010000000101010000; 
        //Mem[21] = 49'b0000000000000000000000000000000000000000000000000; //SD, no estoy seguro de este estado
        Mem[22] = 54'b000000000101000000000000010000000000010000000101011000;
        Mem[23] = 54'b000000000001000000000000000010000000010001100101011000;
        //Mem[24] = 53'b00000000001000000000000000000000000010001100101100000;
        Mem[24] = 54'b000000000001000000000000000000000000010000000101100000;
        Mem[25] = 54'b000000000001000000000000000000000000101101100101100100;

        //Move Instrucionsf Signals
        //Mem[26] = 53'b00000000000000000000000001001000100010000000101101000;
        Mem[26] = 54'b000000000000000000000000000000000000010000000101101000;
        Mem[27] = 54'b000000000000000000000000001001000010010000000101101100;
        Mem[28] = 54'b000000000000000000000000001001001000010000000101110010;
        Mem[29] = 54'b000000000000000000000000001001001000010000000101110101;
        Mem[30] = 54'b000000000000000000010000000000000000010000000101111000;
        Mem[31] = 54'b000000000000000001000000000000000000010000000101111100;
        Mem[32] = 54'b000000000000000000001000001000001000010010001010000000;
        Mem[33] = 54'b000000000000000000000000001000001000010010001010000100;
        Mem[34] = 54'b000000000000000000000000001000001000010010010110001000;

        //Branch Instructions Signals
        Mem[35] = 54'b001000011000000000000000000001000000101100000110001101;
        Mem[36] = 54'b011000100000000100000000000010000001010000000110010000;
        Mem[37] = 54'b000000000000000000000000000001100110010000000110010100;
        Mem[38] = 54'b001001001000010100100000000000000000010000110110011000;
        Mem[39] = 54'b001111001000000000000000000001000000101100000110011101;
        Mem[40] = 54'b011000100000000100000000000010000001010000000110100000;
        
        //Effective Address Calculations
        Mem[41] = 54'b001001001000010100100000000000000000010000111010100100; //next: LW 
        Mem[42] = 54'b001001001000010100100000010000000000011000000010101000; //Effective Address for SW
        Mem[43] = 54'b001000001000100000010010000000000000010001011010101100; //Fill MDR, next: SW 
        Mem[44] = 54'b001000101000000000000000000010000001010000000110110000;
        Mem[45] = 54'b111100110000000000000000100010000000010010010010110100;
        Mem[46] = 54'b000000000000000011000000000000000000010000000110111000;
        Mem[47] = 54'b000000000000000000000000100000010000010000000110111100;
        Mem[48] = 54'b000000000000000000000000100000100000010000000111000000;
        Mem[49] = 54'b000000000000000001000000000000000000010000000111000100;
        Mem[50] = 54'b000000000000000010000000000000000000010000000111001000;
        
        

    end
endmodule
//*********
//*********
//*********
//*********

module encoder_states(input [31:0] instruction, output reg[5:0] nextState);
always @(instruction) 
begin 
//  $display("inside encoder_states module\n");
    //INstruccion tipo R de ADDU
     if(instruction[31:26]== 0 && (instruction[5:0]==6'b100001||instruction[5:0]==6'b100101||instruction[5:0]==6'b100011||instruction[5:0]==6'b101011))
        begin
            nextState = 6'b000110;                 //estado 6
        end
     else if(instruction[31:26]==6'b000000 && (instruction[5:0]==6'b000000||instruction[5:0]==6'b000011||instruction[5:0]==6'b000010)&& (instruction[20:16]!=5'b10001)) begin
        nextState = 6'b001010;
     end
     //BAL
     else if(instruction[31:26]==6'b000001 && instruction[20:16]==5'b10001) begin
        nextState = 6'b101101;
     end
     else if(instruction[31:26]== 6'b100100) begin
        nextState = 6'b001100; 
     end
     else if(instruction[31:26]== 6'b001001) begin
        nextState = 6'b001000;  // ir al estado 8
     end
     else if((instruction[31:26]==6'b100100)) begin
        nextState = 6'b001100;
     end

     else if(instruction[31:26]== 6'b000100) 
        begin
            nextState = 6'b100100;                 
        end
     //INSTRUCCION TIPO I DE SB
      else if (instruction[31:26] == 6'b101000) begin 
          nextState = 6'b100110; //parecido al 12 pero para SB  //State 38         
      end  
     else if (instruction[31:26] == 6'b100011) begin 
          nextState = 6'b101001; //parecido al 12 pero para SB           
      end  
     else if(instruction[31:26]==6'b000111 && instruction[20:16]==5'b00000)begin
        nextState = 6'b100011;
     end
     else if(instruction[31:26]==6'b000110 && instruction[20:16]==5'b00000)begin
        nextState = 6'b100111;
     end
     //JR
     else if(instruction[5:0] == 6'b001000)begin
        nextState = 6'b101100;
     end
     else if(instruction[5:0] == 6'b011001) begin
        nextState = 6'b101110;
     end
     //MFHI
     else if(instruction[5:0] == 6'b010000) begin
        nextState = 6'b101111;
     end
     //MFLO
     else if(instruction[5:0] == 6'b010010) begin
        nextState = 6'b110000;
     end
     else if(instruction[5:0] == 6'b010001) begin
        nextState = 6'b110001;
     end
     else if(instruction[5:0] == 6'b010011) begin
        nextState = 6'b110010;
     end
     //SW
     else if(instruction[31:26] == 6'b101011) begin 
          nextState = 6'b101010; //State 42          
     end 

end
endmodule // encoder_states
//*********
//*********
//*********
//*********
//*********

module mux6_4x1 (output reg [5:0]Y, input M0,M1,input [5:0]R0,R1,R2,R3);
  reg [1:0] s;
  always @(M0,M1,R0,R1,R2,R3)begin
   // $display("MO:%d M1:%d\n",M0,M1);
    s[0] = M0;
    s[1] = M1;
    case (s)
      0: Y=R0;
      1: Y=R1;
      2: Y=R2;
      3: Y=R3;
    endcase
end
endmodule
//*********
//*********
//*********
//*********
//*********

module mux1_4x1 (output reg Y, input MI0,MI1,input R0,R1,R2,R3);
  reg [1:0] s;
  always @(MI0,MI1,R0,R1,R2,R3) begin
    s[0] = MI0;
    s[1] = MI1;
    case (s)
      0: Y=R0;
      1: Y=R1;
      2: Y=R2;
      3: Y=R3;
    endcase
end
endmodule
//*********
//*********
//*********
//*********
//*********

module control_register(output reg [53:0]Q, input Clk, input [53:0] D);
  always @ (posedge Clk)begin
   // $display("inside ontrol_register module\n");
   Q <= D;
end
endmodule
//***************************************************************************************************
//***************************************************************************************************
//***************************************************************************************************
//***************************************************************************************************
//***************************************************************************************************

module incrementer_register(output reg[5:0]Q, input Clk, input[5:0] D);
    always@(posedge Clk) begin
      //$display("inside incrementer_register module\n");
    Q <= D;
    //$display("\ninside incrementer_register: output:%d, input:%d",Q,D);
end
endmodule

module inverter(output reg Out, input In, Inv);
  always @(Inv,In) begin
  //$display("inside inverter module\n");
    if(Inv)
      Out = ~In;
    else begin
      Out = In;
    end
  end
endmodule
//*********
//*********
//*********
//*********
//*********

module adder(input wire [5:0] Operand, output reg [5:0] Out);
    always @(Operand) begin
     // $display("inside adder module\n");
        //$display("/ninside adder: state:%b, nextState (added):%b",Operand,Out);
        Out = Operand + 6'b000001;
        //$display("outAdder:%d",Out);
    end
endmodule
//*********
//*********
//*********
//*********
//*********
module next_state_address(output reg M0, output reg M1, input [2:0] NS, input Sts,reset);
  always @ (reset, NS, Sts) begin
   // $display("inside next_state_address module\n");
    //$display("NSAS: reset = %b",reset);
    if(reset)begin
        M0 = 1;
        M1 = 0;
        //$display("NSAS: M0 = %b, M1 = %b",M0, M1);
        end
    else if(NS == 3'b000) begin
        M0 = 1'b0;
        M1 = 1'b0;
        end
   else if(NS == 3'b010) begin
        M0 = 1'b0;
        M1 = 1'b1;
        end
   else if(NS == 3'b011) begin
        M0 = 1'b1;
        M1 = 1'b1;
        end
    else if(NS == 3'b100) begin
        M1 = ~Sts;
        M0 = 1'b0;
        end
    else if(NS == 3'b101) begin
        M1 = 1'b1;
        M0 = ~Sts;
        end
    else if(NS == 3'b110) begin
        M0 = ~Sts;
        M1 = ~Sts;
       end  
    end
endmodule

/********************************************************************************************************/
/********************************************************************************************************/
/**************************************End Control Unit**************************************************/
/********************************************************************************************************/
/********************************************************************************************************/
/********************************************************************************************************/


/*Todas las varibles tendran al final de su declaracion las iniciales del dispositivo al que pertenecen
  Ejempl:
    - outputFromMuxCU --> Significa output from multiplexer control unit
*/


module datapath;
  wire [31:0] PA,PB,nPC,PC,O,Q,OutB,outHigh,outLow,outputFromMuxPC,outputFromMuxNPC;
  wire [4:0] A, B, C;
  wire [1:0] BLd,BrLd,PCRFLd;
  reg RF,Clk,CLd,ALd,HLd,LLd,nPCs,FRLd,PCLd,nPCLd,IRLd,MDRLd,MARLd,reset;
  wire[31:0] outputFromMuxB,outputFromMDR,outputFromMuxMDR,outputFromAdder,outputFromMuxDataToRF;
  reg[2:0] PCs;
  wire[8:0] outputFromMAR;
  wire[53:0] outputFromCU;
  //Memory variables
  reg EnableMem,RW,FDWCI;
  reg[8:0] Address;
  reg[31:0] DataIN,IR;
  reg[1:0] DataType;
  wire MOC,FHDWCO;
  wire[31:0] DataOut;
  //end memory variables

  //ALU Variables
  wire[31:0] outputFromALU,outputHighALU,outputLowALU,outputSignShiftExt,outputFromIR,outputFromMuxE,outputFromMuxPA;
  reg signALU,E0;
  wire[5:0] outputFromMuxOpcode;
  wire Zflag,VFlag,CFlag,NFlag,Z,V,C1,N,MFC;
 
  rf register_file(PA,PB,outputFromMuxDataToRF,A,B,C,outputFromCU[29],Clk);
  register pc_register(PC,outputFromCU[26],Clk,outputFromMuxPC); 
  register nPC_register(nPC,outputFromCU[25],Clk,outputFromAdder);
  mux2x1x5 muxA(A,outputFromIR[25:21],outputFromIR[20:16],outputFromCU[34]);
  mux4x1x5 muxC(C,outputFromIR[15:11],outputFromIR[20:16],5'b11111,0,outputFromCU[53],outputFromCU[35]);
  mux4x1x32 muxB(outputFromMuxB,PB,outputSignShiftExt,outputFromMDR,PC,outputFromCU[39:38]);
  mux3x1x5 muxBr(B,outputFromIR[20:16],outputFromIR[10:6],outputFromIR[25:21],outputFromCU[31:30]);
 // mux5x1x32 muxPC(outputFromMuxPC,0,outLow,outHigh,nPC,outputFromALU,outputFromCU[21:19]); //<<--- ARREGLARRRRRRR
  mux4x1x32 muxPC(outputFromMuxPC,outputFromMuxNPC,0,0,0,outputFromCU[21:20]);
  //mux2x1x32 muxPC(outputFromMuxPC,outputFromMuxNPC,0,outputFromCU[21:20]);
  mux2x1x32 muxPA(outputFromMuxPA,PA,PC,outputFromCU[52]);
  mux4x1x32 muxNPC(outputFromMuxNPC,nPC,outputFromALU,0,0,outputFromCU[19:18]);  
  mux2x1x32 muxE(outputFromMuxE,DataOut,outputFromALU,outputFromCU[31]);
  adderNPC nPCAdder(outputFromMuxNPC,outputFromAdder); 

  mux4x1x32 muxDataToRF(outputFromMuxDataToRF,outputFromALU,outHigh,outLow,0,outputFromCU[23:22]); //00=outFRomALU 01=High 10=low 11=0


//ALU connections
 ALU alu(outputFromALU,outputHighALU,outputLowALU,outputFromMuxPA,outputFromMuxB,outputFromMuxOpcode,outputFromIR[5:0],outputFromCU[44],Zflag,NFlag,CFlag,VFlag);
 register regHigh(outHigh,outputFromCU[36],Clk,outputHighALU);
 register regLow(outLow,outputFromCU[37],Clk,outputLowALU);
 FlagsRegister flags(Z,N,V,C1,outputFromCU[24],Clk,Zflag,NFlag,VFlag,CFlag);
 mux2x1x6 muxOpcode(outputFromMuxOpcode,outputFromIR[31:26],outputFromCU[50:45],outputFromCU[51]);

//END ALU connections


register InstructionRegister(outputFromIR,outputFromCU[30],Clk,DataOut);
register MDR(outputFromMDR,outputFromCU[41],Clk,outputFromMuxE);
shifterAndSignExtender ShiftSignEregister(outputSignShiftExt,outputFromIR,PB);
registerMAR MAR(outputFromMAR,outputFromCU[40],Clk,outputFromALU[8:0]);

//RAM
ram512x8 ram(DataOut,outputFromCU[42],outputFromCU[43],FHDWCI,outputFromCU[44],outputFromMAR,outputFromMDR,outputFromCU[28:27],MFC,FHDWCO);
//END OF RAM

//Control Unit
CU cu(outputFromCU,Clk,Zflag,NFlag,VFlag,CFlag,MFC,reset, outputFromIR);
//End of Control Unit 
integer i; 
initial begin
  reset = 1'b1;
  #3 reset = ~reset;
end
initial begin
  Clk = 1'b0;
  repeat(900) #2 Clk = ~Clk;
  i = 0;
   repeat(512) begin
     $display("\nMem[%d]: %b", i, ram.Mem[i]);
     i = i + 1;
  end
end
initial begin
    //IR = 32'b00100100000000010000000000101100; //ADDIU R1, R0, #44 WORKS
    //#30 IR = 32'b10010000001000100000000000000000; //LBU 1 works R2=0
    //#50 IR = 32'b10010000001000110000000000000010; //LBU 2 works R3=2
    //#70 IR = 32'b00000000000000000010100000100001; //AADU
    //#90 IR = 32'b00000000101000100010100000100001; //ADDU
    //#120 IR = 32'b00100100011000111111111111111111;  //ADDIU
    //#150 IR = 32'b00011100011000001111111111111101;
   // #33 IR = 32'b00100100011000111111111111111111; //ADDIU R3 = 65336
    //#33 IR = 32'b00011100011000001111111111111101;
    //instruction1 = 32'b10100001010101101011000101110101;  //SB
    //IR = 32'b00010000011001000010100000100111;
    //A = 5'b00011;
   // B = 5'b00100;
    //MFC = 1'b0;
    //Clk = 1'b0;
    //Zflag = 1'b0;
    
end

initial begin
    $monitor("currentState:%d  outputFromMAR:%d  PC:%d   nPC:%d  IR:%b rHi:%d rLo:%d",outputFromCU[7:2],outputFromMAR,PC,nPC,outputFromIR,regHigh.Q,regLow.Q);
end
endmodule