module FFT #(parameter n=8)(
	
	input Clock, nReset, ReadyIn,
	input logic [n-1:0] sw,
	output logic [n-1:0] LED);
timeunit 1ns; timeprecision 10ps;



logic mul_en, cal_en, display_Rez, display_Imz, display_Rey, display_Imy, nMUL1, nMUL2, nMUL3, nMUL4, op,load_Rea, load_Ima, load_Reb, load_Imb, load_Rew, load_Imw;


control c0(
.clk(Clock), .nRst(nReset), .ReadyIn(ReadyIn), 
.load_Rea(load_Rea), .load_Ima(load_Ima), .load_Reb(load_Reb), .load_Imb(load_Imb), .load_Rew(load_Rew), 
.load_Imw(load_Imw),
.mul_en(mul_en), .cal_en(cal_en), .display_Rez(display_Rez), 
.display_Imz(display_Imz), .display_Rey(display_Rey), .display_Imy(display_Imy)
);


datapath datapath(.clk(Clock), .nReset(nReset),
.sw(sw),
.load_Rea(load_Rea), .load_Ima(load_Ima), .load_Reb(load_Reb), .load_Imb(load_Imb), .load_Rew(load_Rew), .load_Imw(load_Imw), 
.display_Rez(display_Rez), .display_Imz(display_Imz), .display_Rey(display_Rey),.display_Imy(display_Imy),
.LED(LED), .cal_en(cal_en), .mul_en(mul_en));

endmodule
 
