
`include "non_rest_div_pipe.v"



module non_rest_div_pipe_tb;



reg clk, rst;

reg [7:0] divident, divisor;

wire [7:0] quotient, remainder;



non_rest_div_pipe dut (

    clk, rst, divident, divisor, quotient, remainder

);



always #10 clk = ~clk;



task do_divide(input [7:0] a, input [7:0] b);

    integer i;

    begin

     

        @(negedge clk);

        divident = a;

        divisor  = b;



        // Wait for pipeline latency (8 cycles)

        for (i = 0; i < 9; i = i + 1)

            @(posedge clk);



        // Print only FINAL result

        $display("TIME=%0t | %0d / %0d => Q=%0d R=%0d",

                 $time, a, b, quotient, remainder);

    end

endtask



initial begin

    clk = 0;

    rst = 1;

    divident = 0;

    divisor  = 0;



    repeat(2) @(posedge clk);

    rst = 0;



    do_divide(8'd10,  8'd2);

    do_divide(8'd100, 8'd10);

    do_divide(8'd255, 8'd15);

    do_divide(8'd200, 8'd7);

    do_divide(8'd50,  8'd3);



    $finish;

end





endmodule