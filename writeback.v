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
        // --- 1. DEFAULTS ---
        // For Arithmetic (Fig e), Rdst1 is [20:16]
        rf_addr  = instruction[20:16]; 
        mem_addr = 8'h00;
        data_out = 8'h00;
        rf_we    = 0;
        mem_we   = 0;

        case(opcode)
            
            // MOV Immediate (Fig a)
            6'b000000: begin
                rf_addr  = instruction[25:21]; // MUST override to bits [25:21]
                data_out = instruction[7:0];   // Immediate value
                rf_we    = 1;
            end

            // Arithmetic: ADD (000100), SUB (000101), DIV (001000) (Fig e)
            6'b000100, 6'b000101, 6'b001000: begin
                // rf_addr is already [20:16] from the default
                data_out = alu_result;
                rf_we    = 1;
            end

            // LOAD (Fig c)
            6'b000010: begin
                rf_addr  = instruction[25:21]; // MUST override to bits [25:21]
                data_out = mem_read_data;
                rf_we    = 1;
            end

            // STORE (Fig d)
            6'b000011: begin
                mem_addr = instruction[25:18]; // Dst Address is [25:18]
                data_out = alu_result;         // Data to store
                mem_we   = 1;
            end

            default: begin
                rf_we  = 0;
                mem_we = 0;
            end
        endcase
    end
endmodule