module fetch_unit(
    input clk,
    input reset,

    input [31:0] instr_in,
    input write_enable,
    input [5:0] read_addr,

    output [31:0] instr_out
);

    // Instruction memory (64 x 32-bit)
    reg [31:0] instr_mem [0:63];

    // Write (program loading)
    always @(posedge clk) begin
        if (write_enable)
            instr_mem[read_addr] <= instr_in;
    end

    // Read (instruction fetch)
    assign instr_out = instr_mem[read_addr];

endmodule