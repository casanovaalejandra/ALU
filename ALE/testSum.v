module testSum;

		wire[31:0] respuesta;
		reg sign;
		wire Z,V,N,C;
		reg[31:0] A,B;
		sum sum1(A,B,sign);
		initial begin
			$display("\nsum test");
			$display("respuesta 	V  Z  	N  	C  	A		B\n");
			$monitor("%b 			%b  %b  %b  %b 	%b 		%b",respuesta,V,Z,N,C,A,B);
endmodule