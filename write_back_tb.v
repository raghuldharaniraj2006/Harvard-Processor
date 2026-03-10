`include "writeback.v"

module writeback_unit_tb;

reg [31:0] instruction;
reg [7:0] alu_result;
reg [7:0] mem_read_data;

wire [4:0] rf_addr;
wire [7:0] mem_addr;
wire [7:0] data_out;
wire rf_we;
wire mem_we;

// Instantiate writeback unit
writeback_unit uut (
    .instruction(instruction),
    .alu_result(alu_result),
    .mem_read_data(mem_read_data),
    .rf_addr(rf_addr),
    .mem_addr(mem_addr),
    .data_out(data_out),
    .rf_we(rf_we),
    .mem_we(mem_we)
);

initial begin

    instruction = 32'b0;
    alu_result = 8'h55;
    mem_read_data = 8'hAA;

    #10;

    // MOV Immediate (opcode 000000)
    instruction[31:26] = 6'b000000;
    instruction[25:21] = 5'd3;   
    instruction[7:0]   = 8'h12;  
    #10;

    // MOV Register (opcode 000001)
    instruction[31:26] = 6'b000001;
    instruction[25:21] = 5'd4;
    #10;

    // LOAD (opcode 000010)
    instruction[31:26] = 6'b000010;
    instruction[25:21] = 5'd5;
    #10;

    // STORE (opcode 000011)
    instruction[31:26] = 6'b000011;
    instruction[25:18] = 8'h20;   
    #10;

    // ADD (opcode 000100)
    instruction[31:26] = 6'b000100;
    instruction[25:21] = 5'd6;
    #10;

    // SUB (opcode 000101)
    instruction[31:26] = 6'b000101;
    instruction[25:21] = 5'd7;
    #10;

    // NEG (opcode 000110)
    instruction[31:26] = 6'b000110;
    instruction[25:21] = 5'd8;
    #10;

    // OR (opcode 001001)
    instruction[31:26] = 6'b001001;
    instruction[25:21] = 5'd9;
    #10;

    // NOT (opcode 001110)
    instruction[31:26] = 6'b001110;
    instruction[25:21] = 5'd10;
    #10;

    // LRSH (opcode 010000)
    instruction[31:26] = 6'b010000;
    instruction[25:21] = 5'd11;
    #10;

    #20 $finish;

end

initial begin
    $monitor("Time=%0t opcode=%b rf_addr=%d mem_addr=%h data_out=%h rf_we=%b mem_we=%b",
             $time, instruction[31:26], rf_addr, mem_addr, data_out, rf_we, mem_we);
end

endmodule