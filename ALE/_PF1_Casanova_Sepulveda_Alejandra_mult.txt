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

always @(A,B)
begin
		Z=0;
		N=0;	//by default all of them will be zero before the multiplication
		C=0;
		V=0;
	if(A==1) begin
		result[63:32]=32'd0;
		result[31:0] = 	B;
	end
	if(A==1 && sign ==1)begin 
		result[63:32]=32'd0;
		result[31:0] = 	B;
		N=1;
	end
	if(B==1) begin
		result[64:32]=32'h0000;
		result[31:0] = 	A;
	end
	if(B==1 && sign ==1) begin
		result[63:32]=32'd0;
		result[31:0] = 	A;
		N=1;
	end
	if(sign ==1) begin
		{outHigh,outLow}<=$signed({32'h00000000,A})*$signed({32'h00000000,B});
		N=1;
	end 
	if(sign==0) begin
		{outHigh,outLow}<=$unsigned({32'h00000000,A})*$unsigned({32'h00000000,B});
		N=0;
	end

outHigh = result[64:32];
outLow = result[31:0];
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
	initial begin
		//this values check if it is multipying correct and considering sign
		//works
		//A = 4'b1111;
		//B = 4'b1111;
		//sign = 1'b1;

		//This values check for overflow
		A = 32'b11111111111111111111111111111001;
		B = 32'b11111111111111111111111111111111;

		sign = 1'b0;
		$display("\nMUlt test\n:");
		$monitor("\n %b    \t%b \t%b",high,low,N);
	end
endmodule
