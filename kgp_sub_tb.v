
module kgp_sub_tb;

reg [7:0]i1,i2;
wire [7:0]sub;
kgp_sub dut(i1,i2,sub);
initial
begin
    $dumpfile("cla.vcd");
    $dumpvars(0,kgp_sub_tb);

$monitor("TIME= %0t  number1 = %d     number2 = %d     sub=%d",$time,i1,i2,sub);


    i1=8'b10101010;
    i2=8'b01010101;
#5 
    i1=8'd61;
    i2=8'd118;
#5
    i1=8'hFF;
    i2=8'hFF;

#10 $finish;




end


endmodule