

module wall_mul_tb;

    
    reg [7:0] in1;
    reg [7:0] in2;

   
    wire [15:0] mul;

    
    reg [15:0] expected_mul;
    integer i;
    integer error_count;

   
    wall_mul uut (
        .in1(in1), 
        .in2(in2), 
        .mul(mul)
    );

    initial begin
        $dumpfile("wall_mul.vcd");
        $dumpvars(0,wall_mul_tb);

       
        in1 = 0;
        in2 = 0;
        error_count = 0;

        $display("Starting Wallace Multiplier Test...");
        $monitor("Time: %0t | in1: %d | in2: %d | mul: %d | Expected: %d", 
                 $time, in1, in2, mul, expected_mul);

      
        in1 = 8'd0; in2 = 8'd0;
        expected_mul = in1 * in2;
        #10;
        check_result();

       
        in1 = 8'hFF; in2 = 8'hFF; 
        expected_mul = in1 * in2;
        #10;
        check_result();

       
        in1 = 8'd12; in2 = 8'd10;
        expected_mul = in1 * in2;
        #10;
        check_result();

        for (i = 0; i < 20; i = i + 1) begin
            in1 = $urandom_range(0, 255);
            in2 = $urandom_range(0, 255);
            expected_mul = in1 * in2;
            #10;
            check_result();
        end

       
        if (error_count == 0)
            $display("TEST PASSED: All calculations are correct.");
        else
            $display("TEST FAILED: Found %d mismatches.", error_count);
            
        $finish;
    end

    task check_result;
        begin
            if (mul !== expected_mul) begin
                $display("ERROR: Mismatch at %d * %d. Got %d, Expected %d", in1, in2, mul, expected_mul);
                error_count = error_count + 1;
            end
        end
    endtask

endmodule