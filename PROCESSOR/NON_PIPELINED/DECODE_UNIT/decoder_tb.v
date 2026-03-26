`timescale 1ns / 1ps

module decode_unit_tb();

    // Inputs
    reg [31:0] instruction;
    reg [7:0] rf_data_rsrc1;
    reg [7:0] rf_data_rsrc2;

    // Outputs
    wire [4:0] read_addr1;
    wire [4:0] read_addr2;
    wire [7:0] A;
    wire [7:0] B;

    // Instantiate the Unit Under Test (UUT)
    decode_unit uut (
        .instruction(instruction), 
        .rf_data_rsrc1(rf_data_rsrc1), 
        .rf_data_rsrc2(rf_data_rsrc2), 
        .read_addr1(read_addr1), 
        .read_addr2(read_addr2), 
        .A(A), 
        .B(B)
    );

    initial begin
        // Initialize Inputs
        instruction = 0;
        rf_data_rsrc1 = 8'hAA; // Dummy register data 1
        rf_data_rsrc2 = 8'hBB; // Dummy register data 2

        $display("Starting Decode Unit Test...");
        $display("Time\t Opcode\t Inst[7:0]\t Rsrc1_In\t Rsrc2_In\t A_Out\t B_Out");
        $display("---------------------------------------------------------------------------");

        // --- Test 1: MOV Immediate (Opcode 000000) ---
        // Expect: A = 0, B = instruction[7:0]
        instruction = {6'b000000, 18'b0, 8'h42}; 
        #10;
        $display("%0t\t %b\t %h\t\t %h\t\t %h\t\t %h\t %h", $time, instruction[31:26], instruction[7:0], rf_data_rsrc1, rf_data_rsrc2, A, B);

        // --- Test 2: MOV Register (Opcode 000001) ---
        // Expect: A = 0, B = rf_data_rsrc1
        instruction = {6'b000001, 21'b0, 5'd5}; // Addr1 = 5
        #10;
        $display("%0t\t %b\t %h\t\t %h\t\t %h\t\t %h\t %h", $time, instruction[31:26], instruction[7:0], rf_data_rsrc1, rf_data_rsrc2, A, B);

        // --- Test 3: ADD (Opcode 000100) ---
        // Expect: A = rf_data_rsrc1, B = rf_data_rsrc2
        instruction = {6'b000100, 16'b0, 5'd10, 5'd2}; // Addr2=10, Addr1=2
        #10;
        $display("%0t\t %b\t %h\t\t %h\t\t %h\t\t %h\t %h", $time, instruction[31:26], instruction[7:0], rf_data_rsrc1, rf_data_rsrc2, A, B);

        // --- Test 4: STORE (Opcode 000011) ---
        // Expect: A = rf_data_rsrc1, B = 0
        instruction = {6'b000011, 26'b0};
        #10;
        $display("%0t\t %b\t %h\t\t %h\t\t %h\t\t %h\t %h", $time, instruction[31:26], instruction[7:0], rf_data_rsrc1, rf_data_rsrc2, A, B);

        // --- Test 5: NOT (Opcode 001110) ---
        // Expect: A = rf_data_rsrc1, B = 0
        instruction = {6'b001110, 26'b0};
        #10;
        $display("%0t\t %b\t %h\t\t %h\t\t %h\t\t %h\t %h", $time, instruction[31:26], instruction[7:0], rf_data_rsrc1, rf_data_rsrc2, A, B);

        $display("---------------------------------------------------------------------------");
        $finish;
    end
      
endmodule