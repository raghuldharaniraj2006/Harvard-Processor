`timescale 1ns / 1ps

module writeback_unit_tb();

    // Inputs
    reg [31:0] instruction;
    reg [7:0] alu_result;
    reg [7:0] mem_read_data;

    // Outputs
    wire [4:0] rf_addr;
    wire [7:0] mem_addr;
    wire [7:0] data_out;
    wire rf_we;
    wire mem_we;

    // Instantiate the Unit Under Test (UUT)
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
        // Initialize Inputs
        instruction = 0;
        alu_result = 8'hA5;      // Mock ALU result
        mem_read_data = 8'h3C;   // Mock Memory result

        $display("Starting Writeback Unit Test...");
        $display("Time\t Opcode\t RF_Addr\t RF_WE\t Mem_WE\t Data_Out");
        $display("------------------------------------------------------------");

        // --- Test 1: MOV Immediate (Opcode 000000) ---
        // Expect: rf_we=1, data_out=instruction[7:0] (0x77)
        instruction = {6'b000000, 5'd10, 13'b0, 8'h77}; 
        #10;
        $display("%0t\t %b\t %d\t\t %b\t %b\t %h", $time, instruction[31:26], rf_addr, rf_we, mem_we, data_out);

        // --- Test 2: LOAD (Opcode 000010) ---
        // Expect: rf_we=1, data_out=mem_read_data (0x3C)
        instruction = {6'b000010, 5'd15, 21'b0}; 
        #10;
        $display("%0t\t %b\t %d\t\t %b\t %b\t %h", $time, instruction[31:26], rf_addr, rf_we, mem_we, data_out);

        // --- Test 3: STORE (Opcode 000011) ---
        // Expect: mem_we=1, data_out=alu_result (0xA5), mem_addr=instruction[25:18]
        instruction = {6'b000011, 8'hFF, 18'b0}; 
        #10;
        $display("%0t\t %b\t --\t\t %b\t %b\t %h (MemAddr: %h)", $time, instruction[31:26], rf_we, mem_we, data_out, mem_addr);

        // --- Test 4: ADD (Opcode 000100) ---
        // Expect: rf_we=1, data_out=alu_result (0xA5)
        instruction = {6'b000100, 5'd21, 21'b0}; 
        #10;
        $display("%0t\t %b\t %d\t\t %b\t %b\t %h", $time, instruction[31:26], rf_addr, rf_we, mem_we, data_out);

        // --- Test 5: Unknown Opcode ---
        // Expect: All WE signals 0
        instruction = {6'b111111, 26'b0}; 
        #10;
        $display("%0t\t %b\t --\t\t %b\t %b\t %h", $time, instruction[31:26], rf_we, mem_we, data_out);

        $display("------------------------------------------------------------");
        $finish;
    end
      
endmodule