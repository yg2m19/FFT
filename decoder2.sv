module decoder2 #(parameter n=8)(

	input logic [n-1:0] Reb, Imb, Rew, Imw,//abcd
	output logic [n-1:0] REB, IMB, REW, IMW,
	output logic nMUL3, nMUL4
);
timeunit 1ns; timeprecision 10ps;
always_comb
	case ({Reb[7],Imw[7]})//ad
	2'b00 : begin REB = Reb; IMW =Imw; nMUL3='0;          end
	2'b01 : begin IMW = ~Imw+'b1; REB = Reb; nMUL3 ='1;   end
	2'b10 : begin REB = ~Reb+'b1; IMW = Imw; nMUL3 ='1;   end 
	2'b11 :	begin REB = ~Reb+'b1; IMW = ~Imw+'b1; nMUL3='0;end 
	default:;
	endcase 

always_comb
	case ({Imb[7],Rew[7]})//bc
	2'b00 : begin IMB = Imb; REW = Rew; nMUL4='0;end
	2'b01 : begin REW = ~Rew+'b1;IMB = Imb; nMUL4 ='1; end 
	2'b10 : begin IMB = ~Imb+'b1;REW = Rew; nMUL4 ='1; end 
	2'b11 :	begin IMB = ~Imb+'b1;REW = ~Rew+'b1; nMUL4='0;end 
	default:;
	endcase 


endmodule
