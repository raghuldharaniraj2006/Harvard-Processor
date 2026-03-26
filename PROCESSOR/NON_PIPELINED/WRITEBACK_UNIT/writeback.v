module writeback_unit(
    input [31:0] instruction,
    input [7:0] alu_result,
    input [7:0] mem_read_data,
    output reg [4:0] rf_addr,
    output reg [7:0] mem_addr,
    output reg [7:0] data_out,
    output reg rf_we,
    output reg mem_we
);

    wire [5:0] opcode = instruction[31:26];

    always @(*) begin
        // --- Default Values ---
        rf_addr = 5'bxxxxx;
        mem_addr = 8'bxxxxxxxx;
        data_out = 8'h00;
        rf_we = 0;
        mem_we = 0;

        if (opcode == 6'b000000) begin // MOV Immediate
            rf_addr = instruction[25:21]; // Rdst
            data_out = instruction[7:0];
            rf_we = 1;
        end
        else if (opcode == 6'b000001) begin // MOV Register
            rf_addr = instruction[25:21]; // Rdst
            data_out = alu_result;
            rf_we = 1;
        end
        else if (opcode == 6'b000010) begin // LOAD
            rf_addr = instruction[25:21]; // Rdst
            data_out = mem_read_data;
            rf_we = 1;
        end
        else if (opcode == 6'b000011) begin // STORE
            mem_addr = instruction[25:18]; // Dst Address
            data_out = alu_result;
            mem_we = 1;
        end
        else if (opcode == 6'b000100) begin // ADD
            rf_addr = instruction[25:21]; // Rdst1
            data_out = alu_result;
            rf_we = 1;
        end
        else if (opcode == 6'b000101) begin // SUB
            rf_addr = instruction[25:21]; // Rdst1
            data_out = alu_result;
            rf_we = 1;
        end
        else if (opcode == 6'b000110) begin // NEG
            rf_addr = instruction[25:21]; // Rdst1
            data_out = alu_result;
            rf_we = 1;
        end
        else if (opcode == 6'b000111) begin // MUL
            rf_addr = instruction[25:21]; // Rdst1
            data_out = alu_result;
            rf_we = 1;
        end
        else if (opcode == 6'b001000) begin // DIV
            rf_addr = instruction[25:21]; // Rdst1
            data_out = alu_result;
            rf_we = 1;
        end
        else if (opcode == 6'b001001) begin // OR
            rf_addr = instruction[25:21]; // Rdst1
            data_out = alu_result;
            rf_we = 1;
        end
        else if (opcode == 6'b001010) begin // XOR
            rf_addr = instruction[25:21]; // Rdst1
            data_out = alu_result;
            rf_we = 1;
        end
        else if (opcode == 6'b001011) begin // NAND
            rf_addr = instruction[25:21]; // Rdst1
            data_out = alu_result;
            rf_we = 1;
        end
        else if (opcode == 6'b001100) begin // NOR
            rf_addr = instruction[25:21]; // Rdst1
            data_out = alu_result;
            rf_we = 1;
        end
        else if (opcode == 6'b001101) begin // XNOR
            rf_addr = instruction[25:21]; // Rdst1
            data_out = alu_result;
            rf_we = 1;
        end
        else if (opcode == 6'b001110) begin // NOT
            rf_addr = instruction[25:21]; // Rdst1
            data_out = alu_result;
            rf_we = 1;
        end
        else if (opcode == 6'b001111) begin // LLSH
            rf_addr = instruction[25:21]; // Rdst1
            data_out = alu_result;
            rf_we = 1;
        end
        else if (opcode == 6'b010000) begin // LRSH
            rf_addr = instruction[25:21]; // Rdst1
            data_out = alu_result;
            rf_we = 1;
        end
    end
endmodule