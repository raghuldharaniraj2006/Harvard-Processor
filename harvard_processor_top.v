module harvard_processor_top (
    input clk,
    input rst,
    // --- Manual Loading Interface ---
    // These ports allow you to pump instructions into memory from the Testbench
    input [31:0] tb_instr_in,  
    input tb_we,               
    // --- Debug & Result Outputs ---
    output [7:0] alu_result_out,
    output [5:0] pc_debug
);

    // --- Internal Signal Wires ---
    reg  [5:0]  pc_reg;
    wire [31:0] instruction;
    wire [7:0]  reg_data_1, reg_data_2;
    wire [7:0]  alu_out_low, alu_out_high;
    wire [7:0]  mem_read_data;
    
    // Writeback Unit Interface Wires
    wire [4:0]  wb_rf_addr;
    wire [7:0]  wb_mem_addr;
    wire [7:0]  wb_data_out;
    wire        wb_rf_we;
    wire        wb_mem_we;

    // --- 1. Program Counter (PC) Logic ---
    // PC increments only when NOT in reset and NOT in loading mode (tb_we = 0)
    always @(posedge clk or posedge rst) begin
        if (rst)
            pc_reg <= 6'd0;
        else if (!tb_we) 
            pc_reg <= pc_reg + 1'b1;
    end
    assign pc_debug = pc_reg;

    // --- 2. Fetch Unit (Instruction Memory) ---
    // instr_in is now connected to the tb_instr_in port
    fetch_unit fetch_inst (
        .clk(clk),
        .rst(rst),
        .instr_in(tb_instr_in), 
        .write_enable(tb_we),   
        .read_addr(pc_reg),
        .instr_out(instruction)
    );

    // --- 3. Register File (32 x 8-bit) ---
    reg [7:0] register_file [0:31];
    
    // Source operand selection based on instruction bits
   assign reg_data_1 = register_file[instruction[4:0]]; 
   assign reg_data_2 = register_file[instruction[9:5]];

    // Synchronous write from Writeback Unit
    always @(posedge clk) begin
        if (wb_rf_we)
            register_file[wb_rf_addr] <= wb_data_out;
    end

    // --- 4. Decode Unit ---
    wire [7:0] operand_A, operand_B;
    decode_unit decode_inst (
        .instruction(instruction),
        .rf_data_rsrc1(reg_data_1),
        .rf_data_rsrc2(reg_data_2),
        .A(operand_A),
        .B(operand_B)
    );

    // --- 5. ALU Unit (ALU Core) ---
    alu_unit alu_inst (
        .A(operand_A),
        .B(operand_B),
        .alu_control(instruction[31:26]),
        .C(alu_out_low),
        .C_hi(alu_out_high)
    );
    assign alu_result_out = alu_out_low;

    // --- 6. Data Memory (Separate Harvard Data Path) ---
    memory data_mem_inst (
        .clk(clk),
        .data_in(wb_data_out),
        .write_addr(wb_mem_addr),
        .read_addr(instruction[25:18]), 
        .write_en(wb_mem_we),
        .data_out(mem_read_data)
    );

    // --- 7. Writeback Unit (Control Logic) ---
    writeback_unit wb_inst (
        .instruction(instruction),
        .alu_result(alu_out_low),
        .mem_read_data(mem_read_data),
        .rf_addr(wb_rf_addr),
        .mem_addr(wb_mem_addr),
        .data_out(wb_data_out),
        .rf_we(wb_rf_we),
        .mem_we(wb_mem_we)
    );

endmodule