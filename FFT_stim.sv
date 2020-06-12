module FFT_stim #(parameter n=8);
timeunit 1ns; timeprecision 10ps;


logic Clock, nReset, ReadyIn;
logic [n-1:0] sw;
logic [n-1:0] LED;

FFT FFT(.*);


 initial 
	begin 
	Clock=0;
	nReset=0;
	ReadyIn =0;
	sw = 8'b00000000;	

	#5;
	nReset=1;

  end

 initial 
	begin
#10000 ReadyIn = '0; 	//s0
#10000 ReadyIn = '1; 
 sw = 8'b01100000;	//Rew 0.75

#10000 ReadyIn = '0;	//s1
#10000 ReadyIn = '1;
 sw = 8'b11100000;	//Imw -0.25

#10000 ReadyIn = '0;	//s2
#10000 ReadyIn = '1;
 sw = 8'b00000110;	//Reb 6

#10000 ReadyIn = '0;	//s3
#10000 ReadyIn = '1;
 sw = 8'b00010100;	//Imb 20

#10000 ReadyIn = '0;	//s4
#10000 ReadyIn = '1;
 sw = 8'b00000111;	//Rea

#10000 ReadyIn = '0;	//s5
#10000 ReadyIn = '1;
 sw = 8'b00000001;	//Ima 
///////

//->display Rey enable display_Rey

#10000 ReadyIn = '0;	//s6
#10000 ReadyIn = '1;
//->display Imy 


#10000 ReadyIn = '0;	//s7
#10000 ReadyIn = '1;
//->display Rez 


#10000 ReadyIn = '0;	//s8
#10000 ReadyIn = '1;

//->display Imz
#10000 ReadyIn = '0;   //s9
#10000 ReadyIn = '1;

///////////////////////////////////////////////////////////////////////

#10000 ReadyIn = '0;   
#10000 ReadyIn = '1;
 sw = 8'b00000111;	//Reb 7

#10000 ReadyIn = '0;
#10000 ReadyIn = '1;
 sw = 8'b10000100;	//Imb -124

#10000 ReadyIn = '0;
#10000 ReadyIn = '1;
 sw = 8'b00000110;	//Rea 6

#10000 ReadyIn = '0;
#10000 ReadyIn = '1;
 sw = 8'b00000010;	//Ima 2

//->display Rey enable display_Rey

#10000 ReadyIn = '0;
#10000 ReadyIn = '1;
//->display Imy 


#10000 ReadyIn = '0;
#10000 ReadyIn = '1;
//->display Rez 


#10000 ReadyIn = '0;
#10000 ReadyIn = '1;
//->display Imz
///////
#10000 ReadyIn = '0;
#10000 ReadyIn = '1;

#10000 ReadyIn = '0;
#10000 ReadyIn = '1;

#10000 ReadyIn = '0;
#10000 ReadyIn = '1;
forever
begin
#240000
$stop;
end
 
end


//clock generator
always begin#15 Clock=~Clock;

end

endmodule
