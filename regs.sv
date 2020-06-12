module regs #(parameter n=8)(
	
	input clk, nRst,load_Rea, load_Ima, load_Reb, load_Imb, load_Rew, load_Imw,display_Imz, 
	//input logic ReadyIn,
	input logic [n-1:0] sw,
	output logic [n-1:0] Rea, Ima, Reb, Imb, Rew, Imw
);
timeunit 1ns; timeprecision 10ps;

enum logic[3:0] {s0,s1,s2,s3,s4, s5, s6, s7, s8, s9, s10} state;



always_ff@(posedge clk, negedge nRst)
begin: SEQ
if(!nRst)
begin 
Rea <='0;
Ima <='0;
Reb <='0;
Imb <='0;
Rew <='0;
Imw <='0;
state <= s0;
end
else
begin
unique case(state)
	s0: 	begin
		if(load_Rew)
		begin
		Rew <= sw;
		state <= s1;
		end
		end

	s1:	begin
		if(load_Imw)
		begin
		Imw <= sw;
		state <= s2;
		end
		end
	
	s2:	begin
		if(load_Reb)
		begin
		Reb <= sw;
		state <= s3;
		end
		end
	
	s3:	begin
		if(load_Imb)
		begin
		Imb <= sw;
		state <= s4;
		end
		end
	
	s4:	begin
		if(load_Rea)
		begin
		Rea <= sw;
		state <= s5;
		end 
		end
	
	s5:	begin
		if(load_Ima)
		begin
		Ima <= sw;
		state <=s6;
		end
		end
		
	s6:	begin
		if(display_Imz)
		state <= s2;
		end
	default: state <= s0;
endcase
end
end
endmodule
		
