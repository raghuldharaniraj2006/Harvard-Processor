`timescale 1ns/1ps

module writeback_unit_tb;

reg [31:0] instruction;
reg [7:0] alu_result;
reg [7:0] mem_data;
reg [7:0] reg_src_data;

wire [7:0] mem_src_addr;
wire [7:0] data_out;
wire [4:0] reg_addr;
wire [7:0] mem_addr;
wire reg_write_en;
wire mem_write_en;

// Instantiate DUT
writeback_unit uut (
    .instruction(instruction),
    .alu_result(alu_result),
    .mem_data(mem_data),
    .reg_src_data(reg_src_data),

    .mem_src_addr(mem_src_addr),
    .data_out(data_out),
    .reg_addr(reg_addr),
    .mem_addr(mem_addr),

    .reg_write_en(reg_write_en),
    .mem_write_en(mem_write_en)
);

initial begin
    // Initialize
    instruction = 0;
    alu_result = 0;
    mem_data = 0;
    reg_src_data = 0;

    #10;

    // -------------------------
    // MOV Immediate
    // -------------------------
    instruction = {6'b000000, 5'd1, 13'd0, 8'hAA};
    #10;

    // -------------------------
    // MOV Register
    // -------------------------
    reg_src_data = 8'h55;
    instruction = {6'b000001, 5'd2, 21'd0};
    #10;

    // -------------------------
    // LOAD
    // -------------------------
    mem_data = 8'hCC;
    instruction = {6'b000010, 5'd3, 21'd0};
    #10;

    // -------------------------
    // STORE
    // -------------------------
    alu_result = 8'h99;
    instruction = {6'b000011, 8'd20, 18'd0};
    #10;

    // -------------------------
    // ADD
    // -------------------------
    alu_result = 8'h11;
    instruction = {6'b000100, 5'd4, 21'd0};
    #10;

    // SUB
    alu_result = 8'h22;
    instruction = {6'b000101, 5'd5, 21'd0};
    #10;

    // MUL
    alu_result = 8'h33;
    instruction = {6'b000111, 5'd6, 21'd0};
    #10;

    // XOR
    alu_result = 8'h44;
    instruction = {6'b001010, 5'd7, 21'd0};
    #10;

    // NOT
    alu_result = 8'hF0;
    instruction = {6'b001110, 5'd8, 21'd0};
    #10;

    // SHIFT
    alu_result = 8'h0F;
    instruction = {6'b001111, 5'd9, 21'd0};
    #10;

    #20 $finish;
end

// Monitor everything
initial begin
    $monitor("Time=%0t | opcode=%b | reg_we=%b | mem_we=%b | reg_addr=%d | mem_addr=%d | data_out=%h",
        $time,
        instruction[31:26],
        reg_write_en,
        mem_write_en,
        reg_addr,
        mem_addr,
        data_out
    );
end

endmodule