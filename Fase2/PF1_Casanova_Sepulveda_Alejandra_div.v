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

always @(A,B,sign) begin

    counter = 0;
	divisor = B;
	//$display("\nvalues of A:",A);
	//$display("\nvalues of divisor:",divisor);
	dividend = A;
	//$display("\nvalues of B:",B);
	//$display("\nvalues of dividend:",dividend);
	//numToSubstract = dividend;
	//$display("\nnumToSubstract:",numToSubstract);
	
  N=0;
  C=0;
  V=0;
  Z=0;

	//check if the divisor is zero then it cant be performed 
	if(divisor==0) begin
		//do nothing.UNdefined 
		$display("cant perform operation.\n");
	end
	 else begin
	//here we check for the signs and set the N flag base on the case
		if(divisor===1)begin
		quotient = dividend;
		residue = 0;
		end
		if(sign==1 &&(divisor[31]==1) &&(dividend[31]==1))begin  //both are negatives therefor the result is possitive 
		  divisor = -(divisor);
		  $display("\ndivisor now possitive",divisor);
		  dividend = -(dividend);
		  $display("\n dividend now positive",dividend);
		  N = 0;
		end
		if(sign==1 && (divisor[31]==0)&& (dividend[31]==1) )begin
		//One positive and one negative this means that the flag needs to be set
		  N=1;
		  dividend =-(dividend);

	  end 
	  if(sign==1 && (divisor[31]==1) && (dividend[31]==0) ) begin
	    //One is positive and the other is negative therefore the flag needs to be set
	    N=1;
	    divisor = -(divisor);
	    $display("\n dividend now positive",dividend);
	  end

   numToSubstract = divisor;
  //here we are going to substract the divisor to the dividend until the number to whom we substract is lower
  while(numToSubstract <= dividend)begin
  numToSubstract = numToSubstract - dividend;
  counter = counter +1;
  end
  if(sign==1 && (divisor[31]==0) &&  (dividend[31]==1))begin
  counter = -counter;
  end
  if ( sign==1 && (divisor[31]==1) && (dividend[31]==0) ) begin
  counter = -(counter);
  end
  quotient = counter;
  residue = numToSubstract;
  $display("\nquotient:",quotient);
  $display("\nresidue:",residue);
end
end
endmodule // div


module divTest;
wire[31:0] quotient,residue;
reg sign;
wire Z,V,N,C;
reg[31:0] A,B;
div div1(quotient,residue,A,B,sign,Z,N,C,V);
initial begin
	//A = 32'b11111111111111111111111111111011;
	//B = 32'b00000000000000000000000000000001;
	A = 4'b0010;
	B = 4'b0001;
	sign = 1'b0;
	end
	// initial fork
	// 	#0 A = 32'b11111111111111111111111111111011; #0 B = 32'b00000000000000000000000000000001; #0 sign = 1'b0; 
	// 	//A = 2147483643							   B = 1    
	// 	//quotient = 2147483643
	// 	//residue = 0
	// 	#5 A = 32'b11111111111111111111111111111011; #5 B = 32'b00000000000000000000000000000001; #5 sign = 1'b1;
	// 	//A = -5							            B = 1   
	// 	//quotient = b11111111111111111111111111111011 
	// 	//residue = 0
	// 	//N = 1
	// 	#10 A = 32'b11111111111111111111111111111111; #10 B = 32'b11000000000000000000000000000011; #10 sign = 1'b0;
	// 	//A = 2147483647							   	 B = 3 
	// 	//quotient =  01010101010101010101010101010101
	// 	//residue = 0
	// 	#15 A = 32'b11111111111111111111111111111111; #15 B = 32'b00000000000000000000000000000001; #15 sign = 1'b1;
	// 	//A = 2147483647								 B = 1  
	// 	//quotient = 
	// 	//residue = 
	// 	//N = 0
	// 	join 
initial begin
  $display("\n divission test:\n");
  $display("\t\t\tA \t\t\tB \t\t\t\t quotient \t\t\t\tresidue \t\t\t\tsign \t");
  $monitor("%b\t %b\t %b\t %b\t%b",A,B,quotient,residue,sign);
end 
endmodule