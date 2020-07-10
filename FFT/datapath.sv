
module datapath(output logic [7:0]led,
                //output logic [6:0]hun,ten,uni,
                //output logic [6:0]sign,
                input logic [7:0]sw,
                input logic ReadyIn,nReset,
                input logic enReb,enImb,enRea,enIma,enRew,enImw,load,enout,
                input logic mux_mul,mux_alu,
                input logic [1:0]sub1,sub2,
                input logic out_sel,
                input logic rst,hold,Clock );

wire rs,rsIma;
wire [7:0]Reb,Imb,Rew,Imw,Rea,Ima;
wire[7:0]mul1_in1,mul1_in2,mul2_in1,mul2_in2;
wire[7:0]mul1_out,mul2_out;
//wire[7:0]mul1_o,mul2_o;
wire[7:0]alu1_in,alu2_in;
wire[7:0]alu1_out,alu2_out;
wire[7:0]alu1_store,alu2_store;
wire[7:0]out;
wire clk;
wire[7:0]bufout_alu1,bufout_alu2;
wire[7:0]h,t,u;

//and_gate out_reset_and(nReset,rst_out,rso);
and_gate reset_and(nReset,rst,rs);
and_gate reset_and_Ima(nReset,hold,rsIma);

register reg_reb(Reb,sw,enReb,nReset,Clock);
register reg_imb(Imb,sw,enImb,rs,Clock);
register reg_rew(Rew,sw,enRew,nReset,Clock);
register reg_imw(Imw,sw,enImw,nReset,Clock);
register reg_rea(Rea,sw,enRea,rs,Clock);
register reg_ima(Ima,sw,enIma,rsIma,Clock);

muxp mux_mul1_L(mul1_in1,Reb,Imb,mux_mul);//0:a,1:b
muxp mux_mul1_R(mul1_in2,Rew,Imw,mux_mul);
muxp mux_mul2_L(mul2_in1,Imw,Imb,mux_mul);
muxp mux_mul2_R(mul2_in2,Reb,Rew,mux_mul);

mul mul1(mul1_out,mul1_in1,mul1_in2);
mul mul2(mul2_out,mul2_in1,mul2_in2);

//register reg_mul1(mul1_out,mul1_o,clk,nReset);
//register reg_mul2(mul2_out,mul2_o,clk,nReset);

muxp mux_alu1(alu1_in,mul1_out,Rea,mux_alu);
muxp mux_alu2(alu2_in,mul2_out,Ima,mux_alu);

alu alu1(alu1_out,alu1_in,bufout_alu1,sub1);
alu alu2(alu2_out,alu2_in,bufout_alu2,sub2);

buffer_one buffer_alu(clk,ReadyIn,load);
register reg_alu1(alu1_store,alu1_out,clk,nReset,Clock);
register reg_alu2(alu2_store,alu2_out,clk,nReset,Clock);

buffer buf_alu1(bufout_alu1,alu1_store,hold);
buffer buf_alu2(bufout_alu2,alu2_store,hold);

muxp mux_out(out,alu1_out,alu2_out,out_sel);

buffer buf_out(led,out,enout);

//nb nb1(h,t,u,sign,led);

//sevenseg sevenseg1(h,t,u,hun,ten,uni);

endmodule

/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////

module alu(output logic [7:0]out,
           input logic [7:0]a,b,
           input logic [1:0]sub);

always_comb
begin             
   if(sub==2'b0)     
      out=a+b;    
   else if(sub==2'b01)
      out=a-b;     
   else           
      out=b-a;        
end                   

endmodule

/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////

module and_gate(input logic a,b,
         	output logic y);
             
always_comb  
begin        
   y=a&b;    
end         
endmodule    

/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////

module mul(output logic [7:0]out,
           input logic [7:0]a,b);

logic [13:0]result,inter;
logic [6:0]acom,bcom;

always_comb
begin
   if(a[7])
      acom=~(a[6:0]-1'b1);
   else
      acom=a[6:0];
  
   if(b[7])
      bcom=~(b[6:0]-1'b1);
   else
      bcom=b[6:0];
      
   result=acom*bcom; 
   inter=(~result);
   
   if(a[7]==1&&b[7]==1||a[7]==0&&b[7]==0)   
      out={1'b0,result[13:7]};
   else
      out={1'b1,inter[13:7]+1'b1}; 
end                 

endmodule

/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////

module muxp(output logic[7:0]out,
           input logic [7:0]a,b,
           input logic select);

always_comb
begin          
   if(!select)  
      out=a;   
   else
      out=b;
end

endmodule

/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////

module register(output logic [7:0]p,
                input logic [7:0]i,
                input logic enable,nReset,Clock);

logic last_enable;

always_ff @(posedge Clock, negedge nReset)
begin
   if(~nReset)
      begin  
         p<='0;
         last_enable<=1;  
      end  
   else  
      begin	
         if(enable==1&&!last_enable)  
      //if(enable)   
         begin      
           p<=i;   
         end
        last_enable<=enable;
      end
end
endmodule

/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////

module buffer(output logic [7:0]y,
             input logic [7:0]x,
             input logic en);

always_comb
begin          
   if(en)     
      y=x;     
   else         
      y=0;
end
endmodule

/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////

module buffer_one(output logic y,
             input logic x,
             input logic en);

always_comb
begin           
   if(en)       
      y=x;      
   else         
      y=0;
end
endmodule

/*
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
module nb(output logic [7:0]h,t,u,
          output logic [6:0]sign,
          input logic [7:0] led);

logic [7:0]value;

always_comb
begin
  if(led[7])
    begin
      value=~(led-1'b1);
      sign=7'b1111110;
    end      
  else       
    begin
      value=led;
      sign=7'b1111111;
    end
  h=value/100;
  t=(value%100)/10;
  u=value%10;
end
endmodule
*/

/*
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
module sevenseg(input logic [7:0]h,t,u,
                output logic [6:0]hun,ten,uni);
                       
always_comb   
begin       
   case(h)  
   8'b00000000: hun=7'b0000001;
   8'b00000001: hun=7'b1001111;
   8'b00000010: hun=7'b0010010;
   8'b00000011: hun=7'b0000110;
   8'b00000100: hun=7'b1001100;
   8'b00000101: hun=7'b0100100;
   8'b00000110: hun=7'b0100000;
   8'b00000111: hun=7'b0001111;
   8'b00001000: hun=7'b0000000;
   8'b00001001: hun=7'b0000100;
	default: hun=7'b1111111;
   endcase
   
   case(t)
   8'b00000000: ten=7'b0000001;
   8'b00000001: ten=7'b1001111;
   8'b00000010: ten=7'b0010010;
   8'b00000011: ten=7'b0000110;
   8'b00000100: ten=7'b1001100;
   8'b00000101: ten=7'b0100100;
   8'b00000110: ten=7'b0100000;
   8'b00000111: ten=7'b0001111;
   8'b00001000: ten=7'b0000000;
   8'b00001001: ten=7'b0000100;
	default: ten=7'b1111111;
   endcase
   
   case(u)
   8'b00000000: uni=7'b0000001;
   8'b00000001: uni=7'b1001111;
   8'b00000010: uni=7'b0010010;
   8'b00000011: uni=7'b0000110;
   8'b00000100: uni=7'b1001100;
   8'b00000101: uni=7'b0100100;
   8'b00000110: uni=7'b0100000;
   8'b00000111: uni=7'b0001111;
   8'b00001000: uni=7'b0000000;
   8'b00001001: uni=7'b0000100;
	default: uni=7'b1111111;
   endcase
end
endmodule
*/