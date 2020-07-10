
module butterfly_stim;

logic [7:0]sw,led;
//logic [6:0]sign,hun,ten,uni;
logic ReadyIn,nReset;
//logic [13:0]instruction;
logic Clock;

butterfly butterfly1(sw,ReadyIn,nReset,Clock,led);

always
   begin
           ReadyIn = 0;
      #250 ReadyIn = 1;
      #500 ReadyIn = 0;
      #250 ReadyIn = 0;
   end
   
always
   begin
         Clock = 0;
      #5 Clock = 1;
      #10 Clock = 0;
      #5 Clock = 0;
   end

initial 
begin
sw=0;
nReset=1;

#1000
nReset=0;
#1000
nReset=1;

sw=8'b01100000;//Rew +0.75
#1000
sw=8'b11000000;//Imw -0.5
#1000
sw=4;//Reb
#1000
sw=6;//Imb
#1000
sw=3;//Rea
#1000
sw=7;//Ima

////////////////Rew=2 , Imw=1
////////////////Reb=3 , Imb=6
////////////////Rew=2 , Imw=1

////////////////Reb*Rew=2*3=6
////////////////Imb*Imw=1*6=6
////////////////Reb*Imw=3*1=3
////////////////Imb*Rew=6*2=12


////////////////Reb*Rew-Imb*Imw=0
////////////////Reb*Imw+Imb*Rew=15


////////////////Rey=Rea+(Reb*Rew-Imb*Imw)=4+0=4
////////////////Imy=Ima+(Reb*Imw+Imb*Rew)=2+15=17
////////////////Rez=Rea-(Reb*Rew-Imb*Imw)=4-0=4
////////////////Imz=Ima-(Reb*Imw+Imb*Rew)=2-15=-13

//forever
//begin
 //  #10000
//end
end
endmodule