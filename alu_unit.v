



module alu_unit (
    input [7:0] A,           // Operand A from Decode Unit
    input [7:0] B,           // Operand B from Decode Unit
    input [5:0] alu_control, // 6-bit Opcode
    output reg [7:0] C,      // 8-bit Result (Lower Byte)
    output reg [7:0] C_hi    // 8-bit Result (Upper Byte for MUL)
);

   
    wire [8:0]  sum_9bit;    
    wire [7:0]  sub_out, div_quot, div_rem, shift_r_out, shift_l_out;
    wire [15:0] mul_out;

    
    kgp_add adder_inst (.i1(A), .i2(B), .sum(sum_9bit));

    
    kgp_sub sub_inst (.i1(A), .i2(B), .sub(sub_out));

    wall_mul mul_inst (.in1(A), .in2(B), .mul(mul_out));

    
    non_restoring_division_8bit div_inst (.QQ(A), .M(B), .quotient(div_quot), .remainder(div_rem));

    
    right_shift_8_bit rs_inst (.in(A), .out(shift_r_out), .s(B[2:0]));

    left_shift_8_bit ls_inst (.in(A), .out(shift_l_out), .s(B[2:0]));


    always @(*) begin
        C = 8'h00;
        C_hi = 8'h00;
        
        case(alu_control)
            6'b000100: C = sum_9bit[7:0];   // ADD [cite: 62]
            6'b000101: C = sub_out;         // SUB [cite: 62]
            6'b000110: C = ~A + 1'b1;       // NEG (Arithmetic Negation) [cite: 62]
            6'b000111: begin                // MUL [cite: 62]
                C    = mul_out[7:0];        // Lower Byte (Rdst1)
                C_hi = mul_out[15:8];       // Upper Byte (Rdst2)
            end
            6'b001000: C = div_quot;        // DIV [cite: 62]
            
            // Logical Operations
            6'b001001: C = A | B;           // OR [cite: 62]
            6'b001010: C = A ^ B;           // XOR [cite: 62]
            6'b001011: C = ~(A & B);        // NAND [cite: 62]
            6'b001100: C = ~(A | B);        // NOR [cite: 62]
            6'b001101: C = ~(A ^ B);        // XNOR [cite: 62]
            6'b001110: C = ~A;              // NOT [cite: 62]
            
            // Shift Operations
            6'b010000: C = shift_r_out;     // LRSH [cite: 62]
            6'b001111: C = shift_l_out;
            // Move Operations
            6'b000000, 6'b000001: C = B;    // MOV [cite: 62]
            
            default: C = 8'h00;
        endcase
    end
endmodule