// Created by Alejandra Casanova Sepulveda
`include "add.v"
`include "subs.v"
`include "mult.v"
`include "div.v" 

module ALU(
  output reg [31:0] respuesta, //this is the output of the ALU 
  output reg [31:0] outHigh,   //for the numbers whose result is more than 32 bits
  output reg [31:0] outLow,quotient,residue,
  input[31:0] A, B,
  input [31:0] operation,
  input sign,
  output reg Z, //zero flag
  output reg N, //negative flag
  output reg C, //carry flag
  output reg V  //overflow flags
);
  wire[31:0] resp;
  wire[31:0] quot;
  wire[31:0] res;
  wire[31:0] oHigh;
  wire[31:0] oLow;
  wire Z1,V1,C1,N1;

   //ADDITION
   //SUBSTRACTION
  //MULT
  //DIV
  add addition(A,B,sign,Z1,N1,V1,C1,res);
  div division(quot,res,A,B,sig,Z1,N1,V1,C1);
  mult multy(oHigh,oLow,A,B,sign,Z1,N1,V1,C1,resp);
  subs substraction(A,B,sign,Z1,N1,C1,V1,resp);
always @ (A,B,operation) begin
case (operation)

  //--------------------------------------------------------------------------
  //      logic functions
  //-------------------------------------------------------------------------
   //PASS
   //works
 6'b000000: assign respuesta = A; 
 6'b000001: assign respuesta = B;

   //AND
   //works
 6'b000010: assign respuesta = A & B;

   //OR 
   //works
6'b000011: assign respuesta = A | B;

   //EXCLUSIVE OR
   //works
6'b000100: assign respuesta = A ^ B;

   // NOR
   //works
6'b000101: assign respuesta = ~(A ^ B);

   // ONE'S COMPLEMENT
   //works
6'b000110: assign respuesta = ~ A;
6'b000111: assign respuesta = ~ B;

   //SHIFTS
   //works
6'b001000: assign respuesta = A << B;//left shift: arithmetic and logical are the same
6'b001001: assign respuesta = A >> B; //right logical shift
6'b001010: assign respuesta = $signed(A) >>> B; //right arithmetic shift
  
  //LUI
  //works
6'b001011:
  begin
    respuesta[31:16] <= A;    //los mas significativos de A en respuesta
    respuesta[15:0] <= 6'h00; //el resto los iguala a cero
  end 

endcase // operation

end
// always @ (respuesta)
// begin
// $display("ALU Output value original:%d after operation %b with inputs A=%d B=%d",respuesta,operation, A,B);
// end
endmodule

module ALUtest1;
  reg ALU,sign; 
  reg [31:0] A,B,operation;
  wire[31:0] respuesta,outLow,outHigh,quotient,residue;
  wire Z, N,C,V;
  integer i;

  ALU ALU1(respuesta,outHigh,outLow,quotient,residue,sign,A,B,operation,Z,N,C,V);
    initial begin
    A = 32'b10101100110111111111111101011010;
    B = 32'b00000000000000001111111111111111;
    operation = 6'b000000;
    // for( i = 0; i < 14; i=i+1) begin
    //   begin
    //   operation = operation + 6'b000001; end
    // end
    end
  
  initial begin
  
    $monitor("%d,%b,%b,%b,%b",$time,A,B,respuesta,C);
  end
endmodule