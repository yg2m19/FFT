
module control(output logic enReb,enImb,enRea,enIma,enRew,enImw,load,enout,
               output logic mux_mul,mux_alu,
               output logic [1:0]sub1,sub2,
               output logic out_sel,
               output logic rst,hold,
               //output logic [13:0]instruction,
               input logic ReadyIn,
               input logic nReset,Clock);

enum logic[3:0] {idle,readRw,readIw,readRb,readIb,readRa,readIadisplayRy,displayIy,displayRz,displayIz}state;
logic last_ReadyIn;

always_ff @(posedge Clock,negedge nReset)
begin
   if(~nReset)
      begin
         state<=idle;
        last_ReadyIn<=1;
      end
   else 
     begin
        if(ReadyIn&&!last_ReadyIn)
          begin
            case(state)
            idle:
                state<=readRw;
            readRw:
		            state<=readIw;

	          readIw:
		            state<=readRb;

 	          readRb:
		  	         state<=readIb;

	          readIb:
		            state<=readRa;

	          readRa:
		            state<=readIadisplayRy;

	          readIadisplayRy:
		            state<=displayIy;

	          displayIy:
		            state<=displayRz;

	          displayRz:
		            state<=displayIz;

	          displayIz:
	              state<=readRb;
         endcase
        end
      last_ReadyIn<=ReadyIn;
     end
end

always_comb
begin
   enReb=0;
   enImb=0;
   enRea=0;
   enIma=0;
   enRew=0;
   enImw=0;
   mux_mul=0;
   mux_alu=0;
   sub1=2'b0;
   sub2=2'b0;
   out_sel=0;
   load=1;
   enout=0;
   rst=1;
   hold=1;
   //instruction=14'b11111111111111;
   case(state)
	   //idle: instruction=14'b01100000110000;
      readRw: 
         begin
            enRew=1;
         end

      readIw:
         begin
            enImw=1;
         end
	
      readRb://1
         begin	
	         enReb=1;
	         hold=0;
         end	

      readIb://2
	       begin	
	          enImb=1;
            mux_mul=1;
            sub1=2'b10;
         end	

      readRa://3
	       begin	
	          enRea=1;
            mux_alu=1;
            load=0;
         end
		
      readIadisplayRy://4
         begin	
	          enIma=1;
            out_sel=0;
	          mux_alu=1;
            enout=1;
            load=0;
            //instruction=14'b11110101000100;
         end
		
      displayIy://5
         begin	
            out_sel=1;
	          mux_alu=1;
            enout=1;
            load=0;
            //instruction=14'b11110011000100;
         end
		
      displayRz://6
          begin	
            out_sel=0;
	          mux_alu=1;
	          sub1=2'b01;
            enout=1;
            load=0;
            //instruction=14'b11110101110110;
         end
		
      displayIz://7
         begin	
            out_sel=1;
	          mux_alu=1;
	          sub2=2'b01;
	          //finish=1;
            enout=1;
            load=0;
            rst=0;
            //instruction=14'b11110011110110;
         end
       default:;  
   endcase
end

endmodule

//load=1,hold
//load=0,normal











