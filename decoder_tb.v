`include "decoder.v"

module decode_unit_tb;

reg [31:0] instruction;
reg [7:0] rf_data_rsrc1;
reg [7:0] rf_data_rsrc2;

wire [7:0] A;
wire [7:0] B;

// Instantiate decode unit
decode_unit uut (
    .instruction(instruction),
    .rf_data_rsrc1(rf_data_rsrc1),
    .rf_data_rsrc2(rf_data_rsrc2),
    .A(A),
    .B(B)
);

initial begin
    
    rf_data_rsrc1 = 8'h01;
    rf_data_rsrc2 = 8'h05;
    instruction = 32'b0;

    #10;

    // ADD opcode = 000100
    instruction[31:26] = 6'b000100; 
    #10;

    // SUB opcode = 000101
    instruction[31:26] = 6'b000101;
    #10;

    // NEG opcode = 000110
    instruction[31:26] = 6'b000110;
    #10;

    // MUL opcode = 000111
    instruction[31:26] = 6'b000111;
    #10;

    // DIV opcode = 001000
    instruction[31:26] = 6'b001000;
    #10;

    // OR opcode = 001001
    instruction[31:26] = 6'b001001;
    #10;

    // XOR opcode = 001010
    instruction[31:26] = 6'b001010;
    #10;

    // NAND opcode = 001011
    instruction[31:26] = 6'b001011;
    #10;

    // NOR opcode = 001100
    instruction[31:26] = 6'b001100;
    #10;

    // XNOR opcode = 001101
    instruction[31:26] = 6'b001101;
    #10;

    // NOT opcode = 001110
    instruction[31:26] = 6'b001110;
    #10;

    // LLSH opcode = 001111
    instruction[31:26] = 6'b001111;
    #10;

    // LRSH opcode = 010000
    instruction[31:26] = 6'b010000;
    #10;

    #20 $finish;

end

initial begin
    $monitor("Time=%0t opcode=%b A=%h B=%h",
             $time, instruction[31:26], A, B);
end

endmodule