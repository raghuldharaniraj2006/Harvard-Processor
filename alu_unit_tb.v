

module alu_full_test_tb;

    // Inputs to UUT
    reg [7:0] A;
    reg [7:0] B;
    reg [5:0] alu_control;

    // Outputs from UUT
    wire [7:0] C;
    wire [7:0] C_hi;

    // Instantiate the Unit Under Test (UUT)
    alu_unit uut (
        .A(A), 
        .B(B), 
        .alu_control(alu_control), 
        .C(C), 
        .C_hi(C_hi)
    );

    initial begin
        // Setup Waveform for GTKWave
        $dumpfile("alu_full_results.vcd");
        $dumpvars(0, alu_full_test_tb);

        $display("Time\t Opcode \t Operation \t A \t B \t Result(C) \t C_Hi");
        $display("--------------------------------------------------------------------------------");

        // --- 1. DATA MOVEMENT ---
        A = 8'd0; B = 8'd150; alu_control = 6'b000001; // MOV
        #10; $display("%0t \t %b \t MOV \t\t %d \t %d \t %d \t\t %d", $time, alu_control, A, B, C, C_hi);

        // --- 2. ARITHMETIC (KGP & Wallace) ---
        A = 8'd125; B = 8'd100; alu_control = 6'b000100; // ADD
        #10; $display("%0t \t %b \t ADD \t\t %d \t %d \t %d \t\t %d", $time, alu_control, A, B, C, C_hi);

        A = 8'd100; B = 8'd125; alu_control = 6'b000101; // SUB (Negative Result)
        #10; $display("%0t \t %b \t SUB \t\t %d \t %d \t %d (signed:-25) \t %d", $time, alu_control, A, B, C, C_hi);

        A = 8'd15; B = 8'd20; alu_control = 6'b000111; // MUL (15*20=300)
        #10; $display("%0t \t %b \t MUL \t\t %d \t %d \t %d \t\t %d", $time, alu_control, A, B, C, C_hi);

        A = 8'd255; B = 8'd5; alu_control = 6'b001000; // DIV (255/5=51)
        #10; $display("%0t \t %b \t DIV \t\t %d \t %d \t %d \t\t %d", $time, alu_control, A, B, C, C_hi);

        // --- 3. LOGICAL OPERATIONS ---
        A = 8'hF0; B = 8'h0F; alu_control = 6'b001001; // OR
        #10; $display("%0t \t %b \t OR  \t\t %h \t %h \t %h \t\t %d", $time, alu_control, A, B, C, C_hi);

        A = 8'hAA; B = 8'h55; alu_control = 6'b001010; // XOR
        #10; $display("%0t \t %b \t XOR \t\t %h \t %h \t %h \t\t %d", $time, alu_control, A, B, C, C_hi);

        A = 8'hFF; B = 8'hFF; alu_control = 6'b001011; // NAND
        #10; $display("%0t \t %b \t NAND \t\t %h \t %h \t %h \t\t %d", $time, alu_control, A, B, C, C_hi);

        A = 8'h00; B = 8'h00; alu_control = 6'b001100; // NOR
        #10; $display("%0t \t %b \t NOR \t\t %h \t %h \t %h \t\t %d", $time, alu_control, A, B, C, C_hi);

        A = 8'h55; alu_control = 6'b001110; // NOT
        #10; $display("%0t \t %b \t NOT \t\t %h \t -- \t %h \t\t %d", $time, alu_control, A, C, C_hi);

        // --- 4. SHIFT OPERATIONS ---
        A = 8'b00000001; B = 8'd3; alu_control = 6'b001111; // LLSH (1 << 3 = 8)
        #10; $display("%0t \t %b \t LLSH \t\t %b \t %d \t %b \t\t %d", $time, alu_control, A, B, C, C_hi);

        A = 8'b10000000; B = 8'd4; alu_control = 6'b010000; // LRSH (128 >> 4 = 8)
        #10; $display("%0t \t %b \t LRSH \t\t %b \t %d \t %b \t\t %d", $time, alu_control, A, B, C, C_hi);

        $display("--------------------------------------------------------------------------------");
        $display("Full ALU Functional Test Completed.");
        $finish;
    end

endmodule