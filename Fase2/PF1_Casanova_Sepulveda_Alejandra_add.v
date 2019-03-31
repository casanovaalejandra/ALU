module add(
	input [31:0] A,B,
	input sign,
	output reg Z, 	//zero flag
	output reg N,	//negative flag
	output reg C,	//carry flag
	output reg V,	//overflow flags
	output reg [31:0] respuesta
);

//If they are unsigned then we can perform the addition easy
always @(A,B)
begin
	N=0;
	V=0;
	Z=0;
	C=0;
$display("sign at bebinngin: ", sign);
	if(sign==1) //If we have a sign bit 1 is that one of the numbers is signed
	begin
		$display("value of A: ",$signed(A));
		$display("values of B: ",$signed(B));
		assign {C,respuesta}=$signed(A)+$signed(B); //here we take care of the carry
		//negative flag
		N=1;
		if((A[31]==0 && B[31]==0) && respuesta[31]==1)begin //two positive numbers must result on positive 
			V = 1;
		end
		if((A[31]==1 && B[31]==1) && respuesta[31]==0)begin //two negatives must result in negative 
			V = 1;
		end
		//zero flag
		if(respuesta == 0) begin			//si el resultado es zero
			Z=1;
		end
	end
	if(sign == 0) 
	begin //If none of them has signed then we can perform unsiged addition
		$display("value of A: ",A);
		$display("values of B: ",B);
		assign{C,respuesta}=$unsigned(A)+$unsigned(B);
		$display("respuesta dentro del unsiged ",respuesta);
		$display("A[31]=",A[31]);
		$display("B[31]=",B[31]);
		$display("respuesta[31]=",respuesta[31]);
		if((A[31]==B[31])&& respuesta[31]!=A[31])begin
		V=1;
		end
		if(C==1) begin
			V=1;
		end
		//assign{C,respuesta}=$unsigned(A)+$unsigned(B);
		$display("carry = ",C);
		$display(" V = ",V);
		$display(" N = ",N);
	end
end
endmodule // add

module testSum;
		//normal binary sum
		wire[31:0] respuesta;
		reg sign;
		wire Z,V,N,C;
		reg[31:0] A,B;
		add sum1(A,B,sign,Z,N,C,V,respuesta);
		initial begin
			A = 32'b01111111111111111111111111111111;
			B = 32'b01000000000000000000000000000001; 
			sign = 1'b0;
		end
		initial begin
			$display("\nsum test\n");
			$display("respuesta 		\t\t\t\tV  Z  N  C			A\t\t	\tB\t\t\tsign\n");
			$monitor("%b 			%b  %b  %b  %b 	%b 		%b",respuesta,V,Z,N,C,A,B,sign);
		end
endmodule