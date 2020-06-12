module alu1(
    input logic [7:0] in_a ,in_b,
    input logic op,
    output logic [7:0] out
);


timeunit 1ns; timeprecision 10ps;
always_comb
begin

	if(!op)
		out = in_a - in_b;
	else
		out = in_a + in_b;
end


endmodule
