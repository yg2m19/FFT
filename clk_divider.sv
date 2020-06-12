module clk_divider #(parameter n= 2)(

	input logic fastclk,nRst, 
	output logic clk
);
timeunit 1ns; timeprecision 10ps;
	logic [n-1:0] count;

	always_ff @(posedge fastclk, negedge nRst)
		if(!nRst)
		begin
		count <=0;
		clk <=0;
		else
		count <= count +1;
		assign clk = count[n-1]; //slow clock

	endmodule


