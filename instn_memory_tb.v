`include "instn_memory.v"

module inst_memory_tb;
reg clk,rst;
reg [31:0] data_in;
reg [5:0] addr_in;
wire [31:0] data_out;

instn_memory dut (clk,rst,data_in,addr_in,data_out);
always 
 #10 clk = ~clk;

initial
begin
    clk = 1'b0;
    rst = 1'b1;
    data_in=32'b00000000000000000000000000000000;
    #5 rst = 1'b0;

    #10 

      data_in=32'b00000000000000000000000000000001;

     #10 

      data_in=32'b00000000000000000000000000000010;
     #10 

      data_in=32'b00000000000000000000000000000011;
       


end
initial
    $monitor("data %b",data_in);





endmodule