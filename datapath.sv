module datapath #(parameter n=8)(
	
	input clk, nReset, load_Rea,load_Ima,load_Reb,load_Imb,load_Rew,load_Imw,mul_en, cal_en,display_Rez,display_Imz,display_Rey,display_Imy,
	input logic [n-1:0] sw,
	output logic [n-1:0] LED

);
timeunit 1ns; timeprecision 10ps;

logic[n-1:0] Rea, Ima, Reb, Imb, Rew, Imw, Rey, Rez, Imy, Imz, REb, IMb, REw, IMw, REB, IMB, REW, IMW, OUT, IN_a, IN_b, in_a, in_b, out, RE, IM;

logic //mul_en, cal_en, //display_Rez, display_Imz, display_Rey, display_Imy, 
nMUL1, nMUL2, nMUL3, nMUL4, OP,op;
//load_Rea, load_Ima, load_Reb, load_Imb, load_Rew, load_Imw;






regs regs( .clk(clk), .nRst(nReset), .sw(sw), .Rea(Rea), .Ima(Ima), .Reb(Reb), .Imb(Imb), .Rew(Rew), .Imw(Imw), .display_Imz(display_Imz),
.load_Rea(load_Rea), .load_Ima(load_Ima), .load_Reb(load_Reb), .load_Imb(load_Imb), .load_Rew(load_Rew), 
.load_Imw(load_Imw));

decoder1 m1(.Reb(Reb), .Imb(Imb), .Rew(Rew), .Imw(Imw), .REb(REb), .IMb(IMb), .REw(REw), .IMw(IMw), .nMUL1(nMUL1), .nMUL2(nMUL2));

decoder2 m2(.Reb(Reb), .Imb(Imb), .Rew(Rew), .Imw(Imw), .REB(REB), .IMB(IMB), .REW(REW), .IMW(IMW), .nMUL3(nMUL3), .nMUL4(nMUL4));


mul m0(.mul_en(mul_en), .REb(REb), .IMb(IMb), .REw(REw), .IMw(IMw), .nMUL1(nMUL1), .nMUL2(nMUL2), 
.REB(REB), .IMB(IMB), .REW(REW), .IMW(IMW), .nMUL3(nMUL3), .nMUL4(nMUL4),
.RE(RE), .IM(IM), .Clock(clk), .nRst(nReset),.in_a(in_a), .in_b(in_b), .op(op), .out(out));

cal ca0(.cal_en(cal_en), .Clock(clk), .Rea(Rea), .Ima(Ima), .RE(RE), .IM(IM), .Rey(Rey), .Imy(Imy), .Rez(Rez),
.Imz(Imz), .out(OUT), .op(OP), .in_a(IN_a), .in_b(IN_b), .nRst(nReset));

display d0(.display_Rez(display_Rez), .display_Imz(display_Imz), .display_Rey(display_Rey),
.display_Imy(display_Imy), .Rey(Rey), .Imy(Imy), .Rez(Rez), .Imz(Imz), .LED(LED), .Clock(clk), .nRst(nReset));

alu1 alu1(.in_a(in_a), .in_b(in_b), .op(op), .out(out));

alu2 a1u2(.in_a(IN_a), .in_b(IN_b), .op(OP), .out(OUT));

endmodule
