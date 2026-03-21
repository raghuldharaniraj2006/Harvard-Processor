module fetch_unit(
    input clk,
    input rst,
    input [31:0] instr_in,       
    input write_enable,           
    input [5:0] read_addr,        
    output [31:0] instr_out       
);

    // Instruction Memory (64 x 32-bit)
    reg [31:0] instr_mem [0:63];

    // 6-bit counter
    reg [5:0] counter;

    // Counter logic
    always @(posedge clk or posedge rst) begin
        if(rst)
            counter <= 6'd0;
        else if(write_enable)
            counter <= counter + 1'b1;
    end

    always @(posedge clk) begin
        if(write_enable)
            instr_mem[counter] <= instr_in;
    end
    
    // Read instruction using given address
    assign instr_out = instr_mem[read_addr];

endmodule