`include "fetch_unit.v"

module fetch_unit_tb;

reg clk;
reg rst;
reg [31:0] tb_instruction;
reg [5:0] view_addr;

wire [31:0] out_instruction;
wire [5:0] pc_out;

fetch_unit uut (
    .clk(clk),
    .rst(rst),
    .tb_instruction(tb_instruction),
    .view_addr(view_addr),
    .out_instruction(out_instruction),
    .pc_out(pc_out)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    tb_instruction = 0;
    view_addr = 0;

    #10 rst = 0;

    // Load instructions
    tb_instruction = 32'hAABBCC01; #10;
    tb_instruction = 32'hAABBCC02; #10;
    tb_instruction = 32'hAABBCC03; #10;
    tb_instruction = 32'hAABBCC04; #10;

    // Read instructions
    view_addr = 0; #10;
    view_addr = 1; #10;
    view_addr = 2; #10;
    view_addr = 3; #10;

    #20 $finish;
end

// Monitor outputs
initial begin
    $monitor("Time=%0t | PC=%d | view_addr=%d | Instruction=%h",
             $time, pc_out, view_addr, out_instruction);
end

endmodule