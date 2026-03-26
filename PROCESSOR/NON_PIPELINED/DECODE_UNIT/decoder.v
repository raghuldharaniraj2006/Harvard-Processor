module decode_unit(
    input [31:0] instruction,
    input [7:0] rf_data_rsrc1, // From Register File [4:0] (Rsrc1)
    input [7:0] rf_data_rsrc2, // From Register File [9:5] (Rsrc2)
    output [4:0] read_addr1,
    output [4:0] read_addr2,
    output reg [7:0] A,
    output reg [7:0] B
);

    // Extracting the 6-bit Opcode
    wire [5:0] opcode = instruction[31:26];
    assign read_addr1 = instruction[4:0];
    assign read_addr2 = instruction[9:5];


    always @(*) begin
        // --- 1. DEFAULT VALUES ---
        // Prevents latches and ensures no "floating" signals in 45nm synthesis
        A = 8'h00;
        B = 8'h00;

        case(opcode)
            
            // --- Figure (a): MOV Immediate ---
            // A is not used, B gets the 8-bit immediate value from the instruction
            6'b000000: begin
                A = 8'h00;
                B = instruction[7:0]; 
            end

            // --- Figure (b): MOV Register ---
            // A is not used, B gets data from the source register
            6'b000001: begin
                A = 8'h00;
                B = rf_data_rsrc1;
            end

            // --- Figure (e): Arithmetic/Logic (ADD, SUB, DIV, etc.) ---
            // A gets Rsrc1 data, B gets Rsrc2 data
            6'b000100, // ADD
            6'b000101, // SUB
            6'b000111, // MUL
            6'b001000: // DIV
            begin
                A = rf_data_rsrc1; 
                B = rf_data_rsrc2;
            end

            // --- Figure (d): STORE ---
            // For a store, A usually carries the data to be written
            6'b000011: begin
                A = rf_data_rsrc1;
                B = 8'h00;
            end

            6'b001001, // OR
            6'b001010, // XOR
            6'b001011, // NAND
            6'b001100, // NOR
            6'b001101: // XNOR
            begin
                 A = rf_data_rsrc1;
                B = rf_data_rsrc2;
            end

            6'b001110: begin // NOT
                A = rf_data_rsrc1;
                B = 8'h00;
            end

            6'b001111, // LLSH
            6'b010000: // LRSH
            begin
             A = rf_data_rsrc1;
             B = rf_data_rsrc2;
            end

            // Default case for safety
            default: begin
                A = rf_data_rsrc1;
                B = rf_data_rsrc2;
            end
        endcase
    end
endmodule