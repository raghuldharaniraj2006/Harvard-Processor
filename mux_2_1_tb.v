`include "mux_2_1.v"

module mux_2_1_tb;
reg in1,in0,sel;
wire y;
mux_2_1 dut(y,in1,in0,sel);
initial 
begin
    $monitor($time ,"in0 =%b ,in1 = %b ,sel= %b,out = %b",in0,in1,sel,y);
    
    in0=1'b0;
    in1=1'b1;
    sel=1'b0;
    #10

    in0=1'b0;
    in1=1'b1;
    sel=1'b1;

end
endmodule