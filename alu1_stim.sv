module alu1_stim;
//timeunit 1ns; timeprecision 10ps;

logic [7:0] in_a ,in_b;
logic op;
logic [7:0] out;


alu1 a1 (.*);

initial 
begin

in_a=2;
in_b=4;
op='0;

#1000
in_a=3;
in_b=9;
op='0;

#1000
in_a=9;
in_b=3;
op='0;

$finish;
end
endmodule

