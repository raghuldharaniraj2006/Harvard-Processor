`include "kgp_add_pipl.v"
module kgp_add_pipl_tb;
reg clk,rst;
reg [7:0]i1,i2;
wire [8:0]sum;
wire [7:0]in2_s5,in1_s5;


kgp_add_pipl dut(clk,rst,i1,i2,sum, in2_s5,in1_s5);

always 
#10 clk = ~clk;

initial
        begin
        clk = 0;
        rst = 1;
           i1= 8'd170;
    i2= 8'd85;
#30

    rst=0;


#20;
    
    i1= 8'd1;
    i2= 8'd127;

#20;
    
    i1= 8'd255;
    i2= 8'd255;




#20;

    i1 = 8'b11111111;
    i2 = 8'b00000000;

    
#20;

    i1 = 8'b00000011;
    i2 = 8'b00000011;

    
    
    #100 $finish;
        
    end

    initial begin
        $dumpfile("cla_tb.vcd");
        $dumpvars(0,kgp_add_pipl_tb);
        $monitor("TIME=%0t | i1=%d,i2=%d,sum=%d (binary: %b)", 
                 $time, in2_s5,in1_s5, sum, sum);
    end



endmodule   