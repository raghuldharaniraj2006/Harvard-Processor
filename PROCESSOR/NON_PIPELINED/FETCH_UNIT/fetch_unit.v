module fetch_unit(
    clk,
    rst,
    tb_instruction,
    view_addr,
    out_instruction,
    pc_out
);

input clk, rst;
input [31:0] tb_instruction;
input [5:0] view_addr;
output [31:0] out_instruction;
output [5:0] pc_out;

reg [31:0] instn_mem [63:0];
reg [5:0] pc;

always @(posedge clk) begin
    if (rst)
        pc <= 0;
    else begin
        pc <= pc + 1'b1;   // fixed quote issue
        instn_mem[pc] <= tb_instruction;
    end
end

assign pc_out = pc;
assign out_instruction = instn_mem[view_addr];

endmodule