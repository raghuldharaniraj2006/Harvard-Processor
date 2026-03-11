`include "non_restoring_division_8bit.v"

module tb_non_restoring_division;
    reg [7:0] QQ;
    reg [7:0] M;
    wire [7:0] quotient;
    wire [7:0] remainder;

    non_restoring_division_8bit uut (
        .QQ(QQ),
        .M(M),
        .quotient(quotient),
        .remainder(remainder)
    );

    initial begin
        $dumpfile("non_restoring_division.vcd");
        $dumpvars(0, tb_non_restoring_division);

        $monitor("QQ=%d M=%d Q=%d R=%d", QQ, M, quotient, remainder);

        QQ = 8'd20;  M = 8'd5;   #10;
        QQ = 8'd27;  M = 8'd4;   #10;
        QQ = 8'd255; M = 8'd10;  #10;
        QQ = 8'd50;  M = 8'd1;   #10;
        QQ = 8'd5;   M = 8'd10;  #10;
        QQ = 8'd160; M = 8'd3;   #10;
        QQ = 8'd100; M = 8'd128; #10;
        QQ = 8'd127; M = 8'd127; #10;

        $finish;
    end
endmodule