module decode_unit(
    input [31:0] instruction,
    input [7:0] rf_data_rsrc1, // Rsrc2
    input [7:0] rf_data_rsrc2, // Rsrc1
    output [4:0] read_addr1,
    output [4:0] read_addr2,
    output reg [7:0] A,
    output reg [7:0] B
);

    wire [5:0] opcode = instruction[31:26];

   
    assign read_addr1 = instruction[20:16]; // Rsrc2
    assign read_addr2 = instruction[9:5];   // Rsrc1

    always @(*) begin
        A = 8'h00;
        B = 8'h00;

        case(opcode)

            // MOV Immediate
            6'b000000: begin
                A = 8'h00;
                B = instruction[7:0]; 
            end

            // MOV Register
            6'b000001: begin
                A = 8'h00;
                B = rf_data_rsrc1;
            end

            // ALU OPS
            6'b000100, // ADD
            6'b000101, // SUB
            6'b000111, // MUL
            6'b001000: // DIV
            begin
                A = rf_data_rsrc1; // Rsrc2
                B = rf_data_rsrc2; // Rsrc1
            end

            // STORE
            6'b000011: begin
                A = rf_data_rsrc1;
                B = 8'h00;
            end

            // LOGIC OPS
            6'b001001,
            6'b001010,
            6'b001011,
            6'b001100,
            6'b001101:
            begin
                A = rf_data_rsrc1;
                B = rf_data_rsrc2;
            end

            // NOT
            6'b001110: begin
                A = rf_data_rsrc1;
                B = 8'h00;
            end

            // SHIFTS
            6'b001111,
            6'b010000:
            begin
                A = rf_data_rsrc1;
                B = rf_data_rsrc2;
            end

            default: begin
                A = rf_data_rsrc1;
                B = rf_data_rsrc2;
            end
        endcase
    end
endmodule