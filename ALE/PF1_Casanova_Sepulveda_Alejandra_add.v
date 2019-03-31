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
always @(A,B,sign)
begin
Z=0;
N=0;
V=0;
C=0;

	if(sign)
	begin
		assign {C,respuesta}=$signed(A)+$signed(B);
		//negative flag
			N=1;
		if((A[31]===0 && B[31]===0)&& N ===1)
			begin
				V=1;
			end
		//zero flag
		if(respuesta == 0) begin
			Z=1;
		end
	end
	else
	begin
		assign{C,respuesta}=$unsigned(A)+$unsigned(B);
	end

end
endmodule // add

module testSum;

		wire[31:0] respuesta;
		reg sign;
		wire Z,V,N,C;
		reg[31:0] A,B;
		add sum1(A,B,sign,Z,V,N,C,respuesta);
		initial begin
			//with this values there is overflow and the 
			//A = 4'b1111;
			//B = 4'b1010;
			sign = 1'b1;
			//this values check verflow also and the sign
			//works
			A = 32'b1111111111111111111111111111101;
			B = 32'b0000000000000000000000000000001;
			$display("\nsum test");
			$display("respuesta 		V Z  N  C  			A		B\n");
			$monitor("%b 			%b  %b  %b  %b 	%b 		%b",respuesta,V,Z,N,C,A,B);
		end
endmodule