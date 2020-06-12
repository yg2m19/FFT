module cal #(parameter n=8)(
		input cal_en, Clock, nRst,
		input logic [n-1:0] Rea, Ima, RE, IM, out,
		output logic [n-1:0] Rey, Imy, Rez, Imz,in_a, in_b,
		output logic op
);

enum logic[2:0]{s0,s1,s2,s3,s4} state;
timeunit 1ns; timeprecision 10ps;

//logic p_r;

always_ff @(posedge Clock, negedge nRst)
begin:SEQ
	if(!nRst)
	begin
	state <=s0;
	Rey <='0;
	Imy <='0;
	Rez <='0;
	Imz <='0;
	in_a<='0;
	in_b<='0;
	op<='0;
	//p_r <='0;
	end
	else
        //begin
	//if(ReadyIn && !p_r)  //posedge ReadyIn
	begin
	unique case(state)
	s0:	begin
		if(cal_en)
		begin
		in_a <= Rea;
		in_b <= RE;
		op <='1; 	//Rey  = Rea + RE;
		state <= s1;
		end
		end
	
	s1:	begin
		Rey <= out;
		in_a <= Ima;
		in_b <= IM;
		op <='1;	//Imy  = Ima + IM;
		state <= s2;
		end
	
	s2:	begin
		Imy <= out;
		in_a <= Rea;
		in_b <= RE;
		op <='0;	//Rez = Rea - RE;
		state <= s3;
		end
	
	s3:	begin
		Rez <= out;
		in_a <= Ima;
		in_b <=	IM;
		op <='0;	//Imz = Ima - IM;
		state <= s4;
		end
	
	s4:	begin
		Imz <=out;
		state <= s0;
		end
	default: state <= s0;
	endcase
        end
	//p_r <= ReadyIn;
	//end
end
endmodule
