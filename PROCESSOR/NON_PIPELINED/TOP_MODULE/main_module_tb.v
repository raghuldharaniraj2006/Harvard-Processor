`timescale 1ns/1ps

module main_module_tb;

    reg clk;
    reg reset;
    reg [31:0] instr_in;
    reg instr_write_en;

    // Instantiate your CPU
    main_module uut (
        .clk(clk),
        .reset(reset),
        .instr_in(instr_in),
        .instr_write_en(instr_write_en)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        instr_write_en = 1;

        #10 reset = 0;

        // =============================
        // LOAD VALUES INTO REGISTERS
        // =============================
        // Example values: A=45, B=9, C=20, D=4, E=30, F=5
        instr_in = {6'b000000,5'd1,13'd0,8'd45}; #10; // R1 = A
        instr_in = {6'b000000,5'd2,13'd0,8'd9};  #10;  // R2 = B
        instr_in = {6'b000000,5'd3,13'd0,8'd20}; #10; // R3 = C
        instr_in = {6'b000000,5'd4,13'd0,8'd4};  #10;  // R4 = D
        instr_in = {6'b000000,5'd5,13'd0,8'd30}; #10; // R5 = E
        instr_in = {6'b000000,5'd6,13'd0,8'd5};  #10;  // R6 = F

        // =============================
        // COMPUTATION STEPS
        // =============================

        // Step 1: R7 = A / B
        instr_in = {6'b001000,5'd7,5'd1,6'd0,5'd2,5'd0}; #10;

        // Step 2: R8 = C / D
        instr_in = {6'b001000,5'd8,5'd3,6'd0,5'd4,5'd0}; #10;

        // Step 3: R9 = R7 - R8
        instr_in = {6'b000101,5'd9,5'd7,6'd0,5'd8,5'd0}; #10;

        // Step 4: R10 = E / F
        instr_in = {6'b001000,5'd10,5'd5,6'd0,5'd6,5'd0}; #10;

        // Step 5: R11 = R9 + R10 (FINAL RESULT)
        instr_in = {6'b000100,5'd11,5'd9,6'd0,5'd10,5'd0}; #10;

        // Stop instruction writes
        instr_write_en = 0;

        #200;

        // =============================
        // DISPLAY FINAL RESULTS
        // =============================
        $display("------ FINAL RESULT ------");
        $display("R7  (A/B)   = %0d", uut.regfile.rf[7]);
        $display("R8  (C/D)   = %0d", uut.regfile.rf[8]);
        $display("R9  (SUB)   = %0d", uut.regfile.rf[9]);
        $display("R10 (E/F)   = %0d", uut.regfile.rf[10]);
        $display("R11 FINAL   = %0d", uut.regfile.rf[11]);

        // =============================
        // DISPLAY ALL REGISTERS
        // =============================
        $display("------ REGISTER FILE CONTENTS ------");
        for (integer i = 0; i < 32; i = i + 1) begin
            $display("R%0d = %0d", i, uut.regfile.rf[i]);
        end
        $display("------ END OF REGISTERS ------");

        // Test check
        if (uut.regfile.rf[11] == 6)
            $display("TEST PASSED");
        else
            $display("TEST FAILED");

        $finish;
    end

    // Optional: Display PC and instruction at each clock
    always @(posedge clk) begin
        $display("PC=%0d INSTR=%h", uut.pc, uut.instruction);
    end

    // VCD dump for waveform viewing
    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars(0, main_module_tb);
    end

endmodule


