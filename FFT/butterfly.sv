module butterfly(input logic [7:0]sw,
                input logic ReadyIn,nReset,Clock,
                output logic [7:0]led);
                //output logic [6:0]sign,hun,ten,uni,
                //output logic [13:0]instruction);

wire enReb,enImb,enRea,enIma,enRew,enImw,load,enout;
wire mux_mul,mux_alu;
wire [1:0]sub1,sub2;
wire out_sel;
wire hold;
wire rst;
//wire nbR;



control control1(enReb,enImb,enRea,enIma,enRew,enImw,load,enout,
                 mux_mul,mux_alu,sub1,sub2,
                 out_sel,
                 //finish,
                 rst,hold,
                 //instruction,
                 ReadyIn,nReset,Clock);     

datapath datapath1(//led,hun,ten,uni,
                   //sign,
                   led,
                   sw,
                   ReadyIn,nReset,
                   enReb,enImb,enRea,enIma,enRew,enImw,load,enout,
                   mux_mul,mux_alu,sub1,sub2,
                   out_sel,
                   rst,hold,Clock); 
//counter counter1(Clock, clk);
endmodule     
