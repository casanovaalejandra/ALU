module subs(
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
	if(sign)//If they are unsigned then we can perform the addition easy
	begin
		assign {C,respuesta}=$signed(A)-$signed(B);
		//negative flag
		N=respuesta[31];
		//zero flag
		if(respuesta == 0) begin
			Z=1;
		end
		//Overflow flag
		if((A[31]== B[31]) && (A[31]!=respuesta[31]))
			begin
				V=1;
			end
	end
	else
	begin
		assign{C,respuesta}=$unsigned(A)-$unsigned(B);
	end

end
endmodule // sum

module testSubs;      

		wire[31:0] respuesta;
		reg sign;
		wire Z,V,N,C;
		reg[31:0] A,B;
		subs subs(A,B,sign,Z,V,C,N,respuesta);
		initial begin
		//Resta de un numero mayor a un numero menor
		//works
		//A = 4'b0110;
		//B = 4'b1100;
		//sign = 1'b1;
		
		//sign = 1'b0;//para probar cuando la resta es sin signo
		 
		//resta normal 
		//works
		A = 4'b1111;
		B = 4'b1010;
		sign = 1'b1;
			$display("\nsum test");
			$display("respuesta 			V Z N C 		A		B\n");
			$monitor("%b  %b  %b  %b  %b 	%b 		%b",respuesta,V,Z,N,C,A,B);
		end
endmodule