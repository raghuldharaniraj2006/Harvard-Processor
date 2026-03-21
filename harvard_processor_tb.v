`timescale 1ns/1ps

module harvard_processor_tb;

    // 1. Inputs to Top Module
    reg clk;
    reg rst;
    reg [31:0] tb_instr_in;
    reg tb_we;
    
    // 2. Outputs from Top Module
    wire [7:0] alu_result;
    wire [5:0] pc_val;

    // 3. Instantiate Processor
    harvard_processor_top dut (
        .clk(clk),
        .rst(rst),
        .tb_instr_in(tb_instr_in),
        .tb_we(tb_we),
        .alu_result_out(alu_result),
        .pc_debug(pc_val)
    );

    // 4. Clock Generation (3ns period for 333MHz 45nm target)
    always #1.5 clk = ~clk;

    integer i;
    initial begin
        // --- STEP 1: INITIALIZATION ---
        $dumpfile("harvard_system.vcd");
        $dumpvars(0, harvard_processor_tb);

        clk = 0;
        rst = 1;      // Start in Reset
        tb_we = 0;
        tb_instr_in = 32'h0;

        // Optional: Pre-clear Register File to avoid 'x'
        for (i = 0; i < 32; i = i + 1) dut.register_file[i] = 8'h00;

        #10; // Wait for stable power-on

      // --- STEP 2: HARDWARE LOADING PHASE ---
@(posedge clk);
tb_we = 1;

// 1. (20 / 2)
tb_instr_in = 32'h00200014; @(posedge clk); // MOV R1, #20  (Op:0, Rdst:1, Imm:20)
tb_instr_in = 32'h00400002; @(posedge clk); // MOV R2, #2   (Op:0, Rdst:2, Imm:2)
tb_instr_in = 32'h20100041; @(posedge clk); // DIV R1, R1, R2 (Op:8, Rdst1:1, Rsrc2:2, Rsrc1:1) -> R1=10

// 2. (30 / 5)
tb_instr_in = 32'h0060001E; @(posedge clk); // MOV R3, #30  (Op:0, Rdst:3, Imm:30)
tb_instr_in = 32'h00800005; @(posedge clk); // MOV R4, #5   (Op:0, Rdst:4, Imm:5)
tb_instr_in = 32'h20300083; @(posedge clk); // DIV R3, R3, R4 (Op:8, Rdst1:3, Rsrc2:4, Rsrc1:3) -> R3=6

// 3. Subtraction: (20/2) - (30/5)
tb_instr_in = 32'h14100061; @(posedge clk); // SUB R1, R1, R3 (Op:5, Rdst1:1, Rsrc2:3, Rsrc1:1) -> R1=4

// 4. (40 / 8)
tb_instr_in = 32'h00A00028; @(posedge clk); // MOV R5, #40  (Op:0, Rdst:5, Imm:40)
tb_instr_in = 32'h00C00008; @(posedge clk); // MOV R6, #8   (Op:0, Rdst:6, Imm:8)
tb_instr_in = 32'h205000C5; @(posedge clk); // DIV R5, R5, R6 (Op:8, Rdst1:5, Rsrc2:6, Rsrc1:5) -> R5=5

// 5. Final Addition: (4) + (5)
tb_instr_in = 32'h101000A1; @(posedge clk); // ADD R1, R1, R5 (Op:4, Rdst1:1, Rsrc2:5, Rsrc1:1) -> R1=9

tb_we = 0;
tb_instr_in = 32'h0;

        // --- STEP 3: EXECUTION PHASE ---
        #5 rst = 0; // Release Reset to start the PC

        $display("\n--- Harvard Processor: Formula Calculation ---");
        $display("Target: (20/2) - (30/5) + (40/8) = 9");
        $display("Time\t PC \t ALU_Result \t Status");
        $display("----------------------------------------------");

        #200; // Allow time for full pipeline execution

        $display("----------------------------------------------");
        if (alu_result == 8'd9)
            $display("SUCCESS: Final Formula Result is 9!");
        else
            $display("FAILURE: Result is %d. Check Decode/Writeback.", alu_result);
            
        $finish;
    end

    // Monitor Log
    always @(posedge clk) begin
        if (!rst && !tb_we) begin
            $display("%0t \t %d \t %d \t\t Executing...", $time, pc_val, alu_result);
        end
    end

endmodule