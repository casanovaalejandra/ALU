// Created by Alejandra Casanova Sepulveda


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

  //add addition(A,B,sign,Z1,N1,V1,C1,res);
  // div division(quot,res,A,B,sig,Z1,N1,V1,C1);
  // mult multy(oHigh,oLow,A,B,sign,Z1,N1,V1,C1,resp);
  // subs substraction(A,B,sign,Z1,N1,C1,V1,resp);
always @ (A,B,operation) begin
case (operation)

  //--------------------------------------------------------------------------
  //      logic functions
  //-------------------------------------------------------------------------
   //PASS
   //works
 6'b000000:  respuesta = A; 
 6'b000001:  respuesta = B;

   //AND
   //works
 6'b000010: respuesta = A & B;

   //OR 
   //works
6'b000011:  respuesta = A | B;

   //EXCLUSIVE OR
   //works
6'b000100:  respuesta = A ^ B;

   // NOR
   //works
6'b000101: respuesta = ~(A ^ B);

   // ONE'S COMPLEMENT
   //works
6'b000110:  respuesta = ~ A;
6'b000111:  respuesta = ~ B;

   //SHIFTS
   //works
6'b001000:  respuesta = A << B;//left shift: arithmetic and logical are the same
6'b001001:  respuesta = A >> B; //right logical shift
6'b001010:  respuesta = $signed(A) >>> B; //right arithmetic shift
  
  //LUI
  //works
6'b001011:
  begin
    respuesta[31:16] = A;    //los mas significativos de A en respuesta 
    respuesta[15:0] = 6'h00; //el resto los iguala a cero
  end

//ADD unsigned
6'b001100:
begin
  N=0;
  V=0;
  Z=0;
  C=0;
  begin 
    assign{C,respuesta}=$unsigned(A)+$unsigned(B); // grabs the carry 
    if((A[31]==B[31])&& respuesta[31]!=A[31])begin 
    V=1;
    end
    if(C==1) begin
      V=1;
    end
  end
end


//SUBSTRACTION UNSIGNED
6'b001101:
begin
  Z=0;
  N=0;
  V=0;
  if(sign)

  begin
    $display("sign: ",sign);

    assign {C,respuesta}=$signed(A)-$signed(B); //takes care of the carry bit
    //negative flag
    $display("A=: ",$signed(A));
    $display("B= ",$signed(B));
    $display("respuesta:",$signed(respuesta));

    if(respuesta[31]==1)
      begin
        N=1;
      end
    //zero flag
    if(respuesta == 0) begin
      Z=1;
    end
    //Overflow flag
    if((A[31]!=B[31]) && (B[31]!=respuesta[31])) 
      begin
        V=1;
      end
  end

  else 
  begin
    $display("A=: ",A);
    $display("B= ",B);
    $display("inside the else sign: ",sign);
    assign{C,respuesta}=$unsigned(A)-$unsigned(B);
    $display("respuesta:",respuesta);
  end 
  end

//ADD SIGNED
6'b001110:

/*
	CARRY FLAGS RULES:
	1. If sum exceeds the significant bits
	2. If the addition of 2 numbers ( smaller + -bigger) requires a borrow
*/

/*
	OVERFLOW FLAG RULES:
	1. If adding two positive numbers result on a negative number (the MSB = 1) means we have overflow 
	2. If adding two negative numbers result on a posiive number (the MSB = 0) means we have overflow 

*/
  begin
    assign {C,respuesta}=$signed(A)+$signed(B); //here we take care of the carry with sinificant bits 
    //negative flag
    N=1;
    //overflow
    if((A[31]==0 && B[31]==0) && respuesta[31]==1)begin //two positive numbers must result on positive 
      V = 1;
    end
    if((A[31]==1 && B[31]==1) && respuesta[31]==0)begin //two negatives must result in negative 
      V = 1;
    end
    //zero flag
    if(respuesta == 0) begin      //si el resultado es zero
      Z=1;
    end
  end
endcase // operation
end
endmodule


//*********************************************************************************************************
//*********************************************************************************************************
//********************************************TEST*********************************************************
//*********************************************************************************************************
//*********************************************************************************************************

module ALUtest1;
  reg ALU,sign; 
  reg [31:0] A,B,operation;
  wire[31:0] respuesta,outLow,outHigh,quotient,residue;
  wire Z,N,C,V;
  integer i;

  ALU ALU1(respuesta,outHigh,outLow,quotient,residue,A,B,operation,sign,Z,N,C,V);
    initial begin
    A = 32'b00000000000000000000000000000000;
    B = 32'b11111111111111111010101111111111;
    //A = 3'b010; //2
    //B = 3'b111; //7
    operation = 6'b001110; //add unsigned
    sign = 1'b1;
   end
       initial begin
         $display("ALU test:\n");
         //$display("Orden: Pass A,Pass B, A&B, A|B, A^B, ~(A^B), ~A,~B, A<<B, A>>B,signed(A)>>>B,LUI");
    $display("\t\tA\t\t\t\tB\t\t\t\trespuesta\t\t\toperacion\t    V N Z C ",);
    $monitor("%b,%b,%b,%b,%b,%b,%b,%b",A,B,respuesta,operation,V,N,Z,C);
  end
endmodule