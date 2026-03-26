`include "right_shift_pipe.v"

module right_shift_pipe_tb;

reg clk,rst;
reg [7:0] in;
reg [2:0] s;
wire [7:0]out;

right_shift_pipe dut(
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(out),
    .s(s)
);

always 
#10 clk = ~clk;

initial
begin

   

    rst = 1'b1;
    clk = 1'b0;

    #25

    rst=0;
    
    in = 8'b11111111;
    s=3'b001; 

    #20;

   
    
    in = 8'b01010101;
    s=3'b010; 

    #20;
    
    in = 8'b11111111;
    s=3'b100; 

    #20;

   
    
    in = 8'b01010101;
    s=3'b010; 
    #100 $finish;


end

initial
begin
     $monitor("TIME=%0t  output = %8b",$time,out);
end



endmodule