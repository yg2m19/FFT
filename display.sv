module display #(parameter n=8)(
		input display_Rez, display_Imz, display_Rey, display_Imy,Clock,nRst,
		input logic [n-1:0] Rey, Imy, Rez, Imz,
		output logic [n-1:0] LED
);
timeunit 1ns; timeprecision 10ps;
always_ff @(posedge Clock, negedge nRst)
begin:seq
	if(!nRst)
	begin
	LED <='0;
	end
	
	else
	begin

	if(display_Rey)
		LED <= Rey; 
	
	else if(display_Imy)
		LED <= Imy;
	
	else if(display_Rez)
		LED <= Rez;
	
	else if(display_Imz)
		LED <= Imz;
	
	else
		LED <= LED;
	end	
end
endmodule
