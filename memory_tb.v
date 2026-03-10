`include "memory.v"

module memory_tb;

reg clk;
reg [7:0] data_in;
reg [7:0] write_addr;
reg [7:0] read_addr;
reg write_en;
wire [7:0] data_out;

// Instantiate memory module
memory uut (
    clk,
    data_in,
    write_addr,
    read_addr,
    write_en,
    data_out
);

// Clock generation
always #5 clk = ~clk;

initial begin
    clk = 0;
    write_en = 0;
    data_in = 0;
    write_addr = 0;
    read_addr = 0;

    #10;

    // Write values
    write_en = 1;
    write_addr = 8'd1; data_in = 8'hAA; #10;
    write_addr = 8'd2; data_in = 8'hBB; #10;
    write_addr = 8'd3; data_in = 8'hCC; #10;

    // Stop writing
    write_en = 0;

    // Read values
    read_addr = 8'd1; #10;
    read_addr = 8'd2; #10;
    read_addr = 8'd3; #10;

    #20 $finish;
end

initial begin
    $monitor("Time=%0t write_en=%b write_addr=%d data_in=%h read_addr=%d data_out=%h",
              $time, write_en, write_addr, data_in, read_addr, data_out);
end

endmodule