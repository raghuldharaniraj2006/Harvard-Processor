`timescale 1ns/1ps

module tb_top;

    reg clk;
    reg reset; // Matching your 'rst' input
    reg [31:0] instr_in;
    reg instr_write_en;

    // Instantiate your processor
    // Note: Ensure port names match: .rst(reset) and .write_enable(instr_write_en)
    harvard_processor_top dut (
        .clk(clk),
        .rst(reset),
        .instr_in(instr_in),
        .write_enable(instr_write_en)
    );

    // Clock generation
    always #20 clk = ~clk;

    // Monitor for debugging
    initial begin
        $monitor("Time:%0t | PC:%d | Instr:%h | Op:%b | ALU_Out:%h | WB_Data:%h | WE:%b", 
                 $time, dut.pc, dut.instruction, dut.instruction[31:26], 
                 dut.alu_result, dut.write_data, dut.reg_file_en);
    end

    integer i;
    initial begin
        // --- 1. System Setup ---
        clk = 0;
        reset = 1;
        instr_write_en = 0;
        instr_in = 0;

        // Initialize Register File to 0 to prevent 'x' propagation
        for (i = 0; i < 32; i = i + 1) begin
            dut.regfile.rf[i] = 8'h00; 
        end

        #15 reset = 0; // Release reset

        // --- 2. LOAD PROGRAM ---
        // Writing instructions into the Instruction Memory/Fetch Unit
        instr_write_en = 1;

        // MOV R1, #5
        instr_in = {6'b000000, 5'd1, 13'd0, 8'd5}; #10;
        // MOV R2, #7
        instr_in = {6'b000000, 5'd2, 13'd0, 8'd7}; #10;
        // MOV R3, #5
        instr_in = {6'b000000, 5'd3, 13'd0, 8'd5}; #10;
        // MOV R4, #7
        instr_in = {6'b000000, 5'd4, 13'd0, 8'd7}; #10;
        // MOV R5, #5
        instr_in = {6'b000000, 5'd5, 13'd0, 8'd5}; #10;
        // MOV R6, #7
        instr_in = {6'b000000, 5'd6, 13'd0, 8'd7}; #10;

        // ADD R7 = R3 + R1 (Rdst:7, Rsrc2:3, Rsrc1:1)
        instr_in = {6'b000100, 5'd7, 13'd0, 5'd3, 5'd1}; #10;
        // ADD R7 = R7 + R5
        instr_in = {6'b000100, 5'd7, 13'd0, 5'd7, 5'd5}; #10;
        // ADD R8 = R2 + R4
        instr_in = {6'b000100, 5'd8, 13'd0, 5'd2, 5'd4}; #10;
        // ADD R8 = R8 + R6
        instr_in = {6'b000100, 5'd8, 13'd0, 5'd8, 5'd6}; #10;

        // DIV R9 = R8 / R7 (Rdst:9, Rsrc2:8, Rsrc1:7)
        instr_in = {6'b001000, 5'd9, 13'd0, 5'd8, 5'd7}; #10;

        // STORE Mem[0] = R8 (Addr:0, Rsrc1:8)
        instr_in = {6'b000011, 8'd0, 13'd0, 5'd8}; #10;

        // LOAD R12 = Mem[0] (Rdst:12, Addr:0)
        instr_in = {6'b000010, 5'd12, 13'd0, 8'd0}; #10;

        instr_write_en = 0;

        // --- 3. RUN PROGRAM ---
        // Let the PC run and the instructions propagate through the pipeline
        repeat (30) @(posedge clk);

        // --- 4. VERIFY RESULTS ---
        $display("\n--- Final Results Verification ---");
        
        #1; // Offset from clock edge for clean reading
        
        force dut.regfile.read_addr1 = 5'd7;
        #2; $display("R7 value (Expect 10) = %d", dut.regfile.data_out1);
        release dut.regfile.read_addr1;
        
        force dut.regfile.read_addr1 = 5'd8;
        #2; $display("R8 value (Expect 14) = %d", dut.regfile.data_out1);
        release dut.regfile.read_addr1;
        
        force dut.regfile.read_addr1 = 5'd9;
        #2; $display("R9 value (Expect 1)  = %d", dut.regfile.data_out1);
        release dut.regfile.read_addr1;

        force dut.mem.read_addr = 8'd0;
        #2; $display("D0 value (Expect 14) = %d", dut.mem.data_out);
        release dut.mem.read_addr;

        force dut.regfile.read_addr1 = 5'd12;
        #2; $display("R12 value (Expect 14)= %d", dut.regfile.data_out1);
        release dut.regfile.read_addr1;

    end

endmodule