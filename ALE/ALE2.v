// Created by Alejandra Casanova Sepulveda


module ALU(
	output reg [31:0] respuesta, //this is the output of the ALU 
	output reg [31:0] outHigh,
	output reg [31:0] outLow,
	input[31:0] A, B,
	input [31:0] operation,
	
	output reg Z, 	//zero flag
	output reg N,	//negative flag
	output reg C,	//carry flag
	output reg V	//overflow flags
);

always @ (A,B,operation) begin
case (operation)

  //--------------------------------------------------------------------------
  //			logic functions
  //-------------------------------------------------------------------------
   //PASS
 6'b000000: assign respuesta = A;	
 6'b000001: assign respuesta = B;

   //AND
 6'b000010: assign respuesta = A & B;

   //OR 
6'b000011: assign respuesta = A | B;

   //EXCLUSIVE OR
6'b000100: assign respuesta = A ^ B;

   // NOR
6'b000101: assign respuesta = ~(A ^ B);

   // ONE'S COMPLEMENT
6'b000110: assign respuesta = ~ A;
6'b000111: assign respuesta = ~ B;

   //SHIFTS
6'b001000: assign respuesta = A << B;//left shift: arithmetic and logical are the same
6'b001001: assign respuesta = A >> B; //right logical shift
6'b001010: assign respuesta = $signed(A) >>> B; //right arithmetic shift
  
  //LUI
6'b001011:
	begin
		respuesta[31:16] <= A;		//los mas significativos de A en respuesta
		respuesta[15:0] <= 6'h00; //el resto los iguala a cero
	end 

   //ADDITION
6'b001100:  {C,respuesta} <= $signed(A) + $signed(B);
6'b001101: {C,respuesta} <= $unsigned(A) + $unsigned(B);
   //SUBSTRACTION 

   //SUBSTRACTION WITH TWOS COMPLEMENT

   //INCREMENT

   //DECREMENT
  //LUI

endcase // operation
end
always @ (respuesta)
begin
$display("ALU Output value original: %d after operation %b with inputs A=%d B=%d",respuesta,operation, A,B);
end

endmodule

