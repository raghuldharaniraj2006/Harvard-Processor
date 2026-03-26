module wall_mul_pip_tb;
reg clk,rst;
reg [7:0] in1,in2;
wire [15:0] mul;
wire [7:0]in1_s,in2_s;

wall_mul_pip dut(clk,rst,in1,in2,mul,in1_s,in2_s);

 always 
 #10 clk = ~clk;

initial

begin
    clk = 0;
    rst = 1;
    in1 = 8'd0;
    in2 = 8'd0;
    #30

    rst = 0;
    #20
    in1 = 8'd10;
    in2 = 8'd20;

    #20
    in1 = 8'd20;
    in2 = 8'd20;

    #20
    in1 = 8'd255;
    in2 = 8'd255;

    #20
    in1 = 8'd19;
    in2 = 8'd18;

    #20
    in1 = 8'd21;
    in2 = 8'd20;

    #20
    in1 = 8'd10;
    in2 = 8'd20;

    #20
    in1 = 8'd127;
    in2 = 8'd127;

    #100 $finish;

end

initial
begin
    $dumpfile("wall_mul_pip.vcd");
    $dumpvars(0,wall_mul_pip_tb);



    $monitor("TIME=%0t | i1=%d,i2=%d,multiplication=%d)", 
                 $time, in1_s,in2_s, mul);



end






endmodule