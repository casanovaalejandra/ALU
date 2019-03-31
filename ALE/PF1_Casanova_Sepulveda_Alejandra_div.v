module div(
	output reg [31:0] quotient, 
	output reg [31:0] residue,
	input[31:0] A, B,
	input sign,
	output reg Z, //zero flag
	output reg N,	//negative flag
	output reg C,	//carry flag
	output reg V	//overflow flags
	);

reg [31:0] divisor;
reg [31:0] dividend;
reg [31:0] numToSubstract;
reg [31:0] counter;

always @(A,B) begin

  counter = 32'd0;
	divisor = A;
	dividend = B;
	//quotient = 32'b0;
	//residue = 32'b0;
	numToSubstract = dividend;
  N=0;
  C=0;
  V=0;
  Z=0;

	//check if the divisor is zero then it cant be performed 
	if(divisor==0) begin
		//do nothing
	end


	else begin
	//here we check for the signs and set the N flag base on the case
	
		if((divisor[31]==1) &&(dividend[31]==1) && sign )begin  //both are negatives therefor the result is possitive 
		  divisor = -(divisor);
		  dividend = -(dividend);
		end
		if((divisor[31]==0)&& (dividend[31]==1) && sign )
		//One positive and one negative this means that the flag needs to be set
		  N=1;
		  dividend =-(dividend);
	  end 
	  if((divisor[31]==1) && (dividend[31]==0) && sign) begin
	    //One is positive and the other is negative therefore the flag needs to be set
	    N=1;
	    divisor = -(divisor);
	  end
  //here we are going to substract the divisor to the dividend until the number to whom we substract is lower
  while(numToSubstract >= divisor)begin
  numToSubstract = numToSubstract - divisor;
  counter = counter +1;
  end
  if((divisor[31]==0)&& (dividend[31]==1) && sign )begin
  counter = -counter;
  end
  if ((divisor[31]==1) && (dividend[31]==0) && sign) begin
  counter = -counter;
  end
  quotient = counter;
  residue = numToSubstract;
end
endmodule // div

module main();
wire[31:0] quotient,residue;
reg sign;
wire Z,V,N,C;
reg[31:0] A,B;
div div1(quotient,residue,A,B,sign,Z,V,N,C);
initial begin
  A = 4'b1111;
  B = 4'b0101;
  sign = 1'b1;
  $display("\n divission test:\n");
  $display("\t\t\tA \tB \t quotient \t residue \t sign \t");
  $monitor("                ",A,B,quotient,residue,sign);
end 
endmodule