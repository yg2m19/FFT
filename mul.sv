module mul #(parameter n=8)(
	input mul_en, Clock, nRst,nMUL1, nMUL2, nMUL3, nMUL4, 
	input logic [n-1:0] out,
	input logic [n-1:0] REb, IMb, REw, IMw, REB, IMB, REW, IMW,//abcd ABCD
	output logic [n-1:0] RE, IM , in_a, in_b,
	output logic op
);

logic [2*n-1:0] mul1,mul2,mul3,mul4;
logic [n-1:0] RebRew,ImbImw,RebImw,RewImb;

timeunit 1ns; timeprecision 10ps;

enum logic[4:0]{s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17} state;

logic p_r;

always_ff@(posedge Clock, negedge nRst)
begin: SEQ
	if(!nRst)
	begin
	in_a <= '0;
	in_b <= '0;
	op <='0;
	mul1<='0;
	mul2<='0;
	mul3<='0;
	mul4<='0;
	RE<='0;
	IM<='0;
	state <= s5;
	p_r <='0;
	RebRew <=0;
	ImbImw <=0;
	RebImw <=0;
	RewImb <=0;
	end
	
	else
	begin
	p_r <= mul_en;
	begin
	unique case(state)
	
		s5:	begin
			if(mul_en && !p_r)
			begin
			mul1[13:0] <= REb[6:0]*REw[6:0];//AC 
			state <= s6;
			end
			end

		s6:	begin
			mul2[13:0] <= IMb[6:0]*IMw[6:0];//BD 
			RebRew <= mul1[13:7];
			state <= s7;
			end


		s7:	begin
			ImbImw <= mul2[13:7];
			state <= s8;
			end

		s8:	begin
			if(nMUL1)
			begin
			RebRew <= ~RebRew +'b1;
			state <=s9;
			end
			else
			begin
			RebRew <= RebRew;
			state <=s9;
			end
			end

			
		s9:	begin
			if(nMUL2)
			begin
			ImbImw <= ~ImbImw+'b1;//IMb*IMw
			state <=s10;
			end
			else
			begin
			ImbImw <= ImbImw;
			state <=s10;
			end
			end
		
		s10:	begin
			in_a <= RebRew;				
			in_b <= ImbImw; 		//RE= Reb*Rew-Imb*Imw 
			op <='0;			//alu:RE = AC-BD
			state <= s11;
			end
			
		s11:	begin
			RE <= out;
			mul3[13:0] <= REB[6:0]*IMW[6:0];//AD	//Reb*Imw		
			state <= s12;
			end


		s12:	begin
			mul4[13:0] <= IMB[6:0]*REW[6:0];
			RebImw <= mul3[13:7];
			state <= s13;
			end

		s13:	begin
			RewImb <= mul4[13:7];
			state <= s14;
			end


		s14:	begin
			if(nMUL3)
			begin
			RebImw <= ~RebImw+'b1;
			state <= s15;
			end
			else
			begin
			RebImw <=RebImw;
			state <= s15;
			end
			end
		

		s15:	begin
			if(nMUL4)
			begin
			RewImb <= ~RewImb+'b1;
			state <= s16;
			end
			else
			begin
			RewImb <= RewImb;
			state <= s16;
			end
			end
			
		
		s16:	begin			
			in_a <= RebImw;
			in_b <= RewImb;				//IM= Reb*Imw+Imb*Rew;
			op <='1;					//alu:RE = AD+BC
			state <= s17;
			end

		s17:	begin
			IM <=out;
			state <= s5;
			end
		default: state <= s5;
	endcase
	end
	end
	//p_r <= ReadyIn;
	//end
					
end
endmodule
