module mult(
	output reg [31:0] outHigh,   //for the numbers whose result is more than 32 bits
	output reg [31:0] outLow,
	input[31:0] A, B,
	input sign,
	output reg Z, 	//zero flag
	output reg N,	//negative flag
	output reg C,	//carry flag
	output reg V,	//overflow flags
	output reg[63:0] result
	);

always @(A,B,sign)
begin
		Z=0;
		N=0;	//by default all of them will be zero before the multiplication
		C=0;
		V=0;
	if(A===1 && sign ===0) begin
		result[63:32]=32'd0;
		result[31:0] = 	B;
	end
	if(A===1 && sign ===1)begin 
		result[63:32]=32'd0;
		result[31:0] = 	B;
		N=1;

	end
	if(B===1 && sign ===0) begin
		result[64:32]=32'h0000;
		result[31:0] = 	A;
	end
	if(B===1 && sign ===1) begin
		result[63:32]=32'd0;
		result[31:0] = 	A;
		N=1;
	end
	if(sign ===1) begin
		{outHigh,outLow}<=$signed({32'h00000000,A})*$signed({32'h00000000,B});
		N=1;
	end 
	if(sign===0) begin
		{outHigh,outLow}<=$unsigned({32'h00000000,A})*$unsigned({32'h00000000,B});
		N=0;
	end

outHigh = result[64:32];
outLow = result[31:0];
	$display("\nresult:",result);
end
endmodule // mult

module testModule;
	reg mult,sign;
	wire [31:0] high;
	wire[31:0] low;
	reg [31:0] A,B;
	wire V,Z,N,C;
	wire [63:0] res;
	mult test1(high,low,A,B,sign,Z,N,C,V,res);
	
		initial fork
		#0 A = 32'b11111111111111111111111111111011; #0 B = 32'b00000000000000000000000000000001; #0 sign = 1'b0; 
		//A = 2147483643							   B = 1    
		//respuesta = 11111111111111111111111111111011
		#5 A = 32'b11111111111111111111111111111011; #5 B = 32'b00000000000000000000000000000001; #5 sign = 1'b1;
		//A = -5							            B = 1   
		//respuesta = b11111111111111111111111111111011 N = 1
		#10 A = 32'b11111111111111111111111111111111; #10 B = 32'b00000000000000000000000000000001; #10 sign = 1'b0;
		//A = 2147483647							   	 B = 1 
		//respuesta = 11111111111111111111111111111111 
		#15 A = 32'b11111111111111111111111111111111; #15 B = 32'b00000000000000000000000000000001; #15 sign = 1'b1;
		//A = 2147483647								 B = 1  
		//11111111111111111111111111111111		N = 1
		join 
		initial begin
		$display("\nMUlt test:\n");
		$display("  high\t\t\t\t\tlow\t\t\t\t\tA\t\t\t\t\tB\t\t\t\t N V Z C");
		$monitor("\n %b    \t%b %b\t %b\t %b %b %b %b",high,low,A,B,N,V,Z,C);
	end
endmodule
