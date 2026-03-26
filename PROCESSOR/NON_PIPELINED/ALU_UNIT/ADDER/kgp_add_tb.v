
module kgp_add_tb;

reg [7:0]i1,i2;
wire [8:0]sum;
kgp_add dut(i1,i2,sum);
initial
begin
    $dumpfile("cla.vcd");
    $dumpvars(0,kgp_add_tb);

$monitor("TIME= %0t  number1 = %d     number2 = %d     sum=%d",$time,i1,i2,sum);


    i1=8'b10101010;
    i2=8'b01010101;
#5 
    i1=8'd255;
    i2=8'd00;
#5
    i1=8'hFF;
    i2=8'hFF;

#10 $finish;




end


endmodule