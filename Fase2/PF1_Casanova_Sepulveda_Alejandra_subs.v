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

	//$display("respuesta: ",respuesta);
	end

endmodule // sum

module testSubs;      

		wire[31:0] respuesta;
		reg sign;
		wire Z,V,N,C;
		reg[31:0] A,B;
		subs subs(A,B,sign,Z,V,C,N,respuesta);
		// initial fork
		// #0 A = 32'b11111111111111111111111111111011; #0 B = 32'b0000000000000000000000000000001; #0 sign = 1'b0; 
		// //A = 4294967291							   B = 1   result = 4294967290 #normal substraction 
		// //respuesta 	  
		// #5 A = 32'b11111111111111111111111111111011; #5 B = 32'b00000000000000000000000000000001; #5 sign = 1'b1;
		// //A = -5							           B = 1   result = -6 #signed substraction without overflow 
		// //respuesta = 11111111111111111111111111111010
		// #10 A = 32'b00000000000000000000000000000001; #10 B = 32'b11111111111111111111111111111111; #10 sign = 1'b0;
		// //A = 1							   				  B = 4294967295 Overflow 
		// //respuesta = 0
		// #15 A = 32'b00000000000000000000000000000001; #15 B = 32'b11111111111111111111111111111111; #15 sign = 1'b1;
		// //A = 1								 			  B = -1  #signed substraction without overflow 
		// //respuesta = 00000000000000000000000000000010
		// join 
			initial begin
			A = 32'b11111111111111111111111111111111;
			B = 32'b11000000000000000000000000000001; 
			sign = 1'b0;
		end
		initial begin
			$display("\nsum test");
			$display("respuesta 			  V  Z  N  C 		A		\t\t\tB\n");
			$monitor("%b  %b  %b  %b  %b 	%b 		%b",respuesta,V,Z,N,C,A,B);
		end
endmodule