module decoder1 #(parameter n=8)(

	input logic [n-1:0] Reb, Imb, Rew, Imw,//abcd
	output logic [n-1:0] REb, IMb, REw, IMw,
	output logic nMUL1, nMUL2
);
timeunit 1ns; timeprecision 10ps;

always_comb
	case ({Reb[7],Rew[7]})//ac
	2'b00 : begin REw = Rew; REb = Reb; nMUL1 ='0;end
	2'b01 : begin REw = ~Rew+'b1; REb = Reb; nMUL1 ='1; end
	2'b10 : begin REb = ~Reb+'b1; REw = Rew; nMUL1 ='1; end
	2'b11 : begin REb = ~Reb+'b1; REw = ~Rew+'b1; nMUL1 ='0;end 
	default:;
	endcase
	
always_comb
	case ({Imb[7],Imw[7]})//bd
	2'b00 : begin IMb = Imb; IMw = Imw; nMUL2='0; end
	2'b01 : begin IMw = ~Imw+'b1; IMb = Imb; nMUL2 ='1; end 
	2'b10 : begin IMb = ~Imb+'b1; IMw = Imw; nMUL2 ='1; end
	2'b11 : begin IMb = ~Imb+'b1; IMw = ~Imw+'b1; nMUL2 ='0;end 
	default:;
	endcase


endmodule
