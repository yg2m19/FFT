module control #(parameter n=8)(
	
	input clk, nRst, ReadyIn,
	//input logic [n-1:0] sw,
	//output logic [n-1:0] Rea, Ima, Reb, Imb, Rew, Imw,
	output logic mul_en, cal_en, display_Rez, display_Imz, display_Rey, display_Imy,load_Rea, load_Ima, load_Reb, load_Imb, load_Rew, load_Imw
);
timeunit 1ns; timeprecision 10ps;
enum logic[4:0] {s0,s1,s2,s3,s4, s5, s6, s7, s8, s9} state;

logic p_r;
//------------- code starts here ---------

always_ff@(posedge clk, negedge nRst)
begin: SEQ
if(!nRst)
begin 
state <= s0;
load_Rea <='0;
load_Ima <='0;
load_Reb <='0;
load_Imb <='0;
load_Rew <='0;
load_Imw <='0;
mul_en <= '0;
cal_en <= '0;
display_Rez <='0;
display_Imz <='0;
display_Rey <='0;
display_Imy <='0;
p_r <='0;
end 
else
begin
if(ReadyIn && !p_r)
begin
unique case(state)

	s0:	begin					//set w
		load_Rew <= '1;
		state <= s1;
		end


	s1:	begin
		load_Rew <= '0;				
		load_Imw <= '1;				
		state <= s2;
		end

	s2:	begin
		//display_Imz <='0;			
		load_Imw <= '0;
		load_Reb <='1; 				  //set b                
		state <= s3;
		end

	
	s3:	begin
		load_Reb <='0;
		load_Imb <= '1;
		mul_en <= '1;
		state <=s4;
		end
	
	s4:	begin
		mul_en <= '0;
		load_Imb <= '0;
		load_Rea <= '1;
		state <= s5;
		end
	
	s5:	begin
		load_Rea <= '0;
		load_Ima <= '1;
		cal_en <='1;			////
		state <= s6;
		display_Rey <= 1;
		end
	
	s6:	begin	
	
		display_Rey <= '0;
		display_Imy <= '1;
		load_Ima <= '0;
		cal_en <= '0;
		state <= s7;
		end

	s7:	begin
		display_Rez <= '1;
		display_Imy <= '0;
		state <= s8;
		end

	s8:	begin
		display_Imz <= '1;
		display_Rez <= '0;
		//mul_en <= '0;//
		state <= s9;
		end

	s9:	begin
		display_Imz <= '0;
		state <= s2;
		end
	default: state <= s0;
	endcase
	end
	p_r <= ReadyIn;
	end

end
endmodule
	


		
		


 
		


	
	
