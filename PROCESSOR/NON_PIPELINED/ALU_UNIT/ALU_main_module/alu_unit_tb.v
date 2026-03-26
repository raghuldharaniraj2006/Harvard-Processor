`timescale 1ns / 1ps

module alu_unit_tb();

    // Inputs
    reg [7:0] A;
    reg [7:0] B;
    reg [31:0] instruction;

    // Outputs
    wire [7:0] C;
    wire [7:0] C_hi;

    // Instantiate the Unit Under Test (UUT)
    alu_unit uut (
        .A(A), 
        .B(B), 
        .instruction(instruction), 
        .C(C), 
        .C_hi(C_hi)
    );

    // Task for easier testing
    task check_alu(input [5:0] opcode, input [7:0] valA, input [7:0] valB, input [15:0] expected);
        begin
            instruction = {opcode, 26'b0};
            A = valA;
            B = valB;
            #10;
            $display("OP:%b | A:%h B:%h | C:%h C_hi:%h", opcode, A, B, C, C_hi);
        end
    endtask

    initial begin
        $display("Starting ALU Unit Test...");
        $display("-------------------------------------------");

        // --- Arithmetic Group ---
        $display("Arithmetic Operations:");
        check_alu(6'b000100, 8'h05, 8'h03, 16'h0008); // ADD: 5 + 3 = 8
        check_alu(6'b000101, 8'h0A, 8'h04, 16'h0006); // SUB: 10 - 4 = 6
        check_alu(6'b000110, 8'h01, 8'h00, 16'h00FF); // NEG: -1 = FF (2's complement)
        
        // MUL: 0F * 02 = 001E
        check_alu(6'b000111, 8'h0F, 8'h02, 16'h001E); 
        
        // DIV: 10 / 03 = Q:05, R:01 (Assuming your non-restoring module logic)
        check_alu(6'b001000, 8'h10, 8'h03, 16'h0105); 

        // --- Logical Group ---
        $display("\nLogical Operations:");
        check_alu(6'b001001, 8'hAA, 8'h55, 16'h00FF); // OR
        check_alu(6'b001010, 8'hFF, 8'hAA, 16'h0055); // XOR
        check_alu(6'b001110, 8'hF0, 8'h00, 16'h000F); // NOT A

        // --- Shift Group ---
        $display("\nShift Operations:");
        check_alu(6'b001111, 8'h01, 8'h02, 16'h0004); // LSH: 1 << 2 = 4
        check_alu(6'b010000, 8'h80, 8'h01, 16'h0040); // RSH: 128 >> 1 = 64

        // --- Move Group ---
        $display("\nMove Operations:");
        check_alu(6'b000000, 8'hAA, 8'h42, 16'h0042); // MOV: C should be B

        $display("-------------------------------------------");
        $finish;
    end
      
endmodule