`include "register_file.v"

module register_file_tb;

reg clk;
reg write_en;
reg [7:0] data_in;
reg [4:0] read_addr;
reg [4:0] write_addr;

wire [7:0] data_out;

register_file uut (
    .clk(clk),
    .write_en(write_en),
    .data_in(data_in),
    .read_addr(read_addr),
    .write_addr(write_addr),
    .data_out(data_out)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    clk = 0;
    write_en = 0;
    data_in = 0;
    read_addr = 0;
    write_addr = 0;

    #10;

    // Writing values into registers
    write_en = 1;
    write_addr = 5'd1; data_in = 8'hAA; #10;
    write_addr = 5'd2; data_in = 8'hBB; #10;
    write_addr = 5'd3; data_in = 8'hCC; #10;

    // Stop writing
    write_en = 0;

    // Reading the registers
    read_addr = 5'd1; #10;
    read_addr = 5'd2; #10;
    read_addr = 5'd3; #10;

    #20 $finish;
end

// Monitor outputs
initial begin
    $monitor("Time=%0t | write_en=%b | write_addr=%d | data_in=%h | read_addr=%d | data_out=%h",
             $time, write_en, write_addr, data_in, read_addr, data_out);
end

endmodule