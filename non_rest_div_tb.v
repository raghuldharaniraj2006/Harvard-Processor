`include "non_rest_div.v"

module non_dist_div_tb;
reg clk,rst,start;
reg [7:0] divident,divisor;
wire done;
wire [7:0] quotient,remainder;

non_rest_div dut (clk,rst,start,divident,divisor,quotient,remainder,done);

 always 
 #10 clk = ~clk;

 //task defining
  task do_divide(input [7:0] a, input [7:0] b);
    begin
        @(negedge clk);
        divident = a;
        divisor  = b;
        start    = 1'b1;

        @(negedge clk);
        start    = 1'b0;
//wait for the done 
        @(posedge done);

        $display("TIME=%0t : %0d / %0d => Q=%0d R=%0d",
                 $time, a, b, quotient, remainder);

        // Small gap
        repeat(2) @(negedge clk);
    end
    endtask

      initial begin
        // Init
        clk = 0;
        rst = 1;
        start = 0;
        divident = 0;
        divisor = 0;

        // Reset
        repeat(2) @(negedge clk);
        rst = 0;

        // Test cases
        do_divide(8'd127, 8'd127);   
        do_divide(8'd160, 8'd5); 
        do_divide(8'd128, 8'd128);   
        do_divide(8'd128, 8'd127);    
        do_divide(8'd127, 8'd128); 
        do_divide(8'd127, 8'd129);   

        $display("All tests finished");
        $stop;
      end


endmodule