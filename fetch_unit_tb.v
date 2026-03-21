

module fetch_unit_tb;

    reg clk;
    reg reset;
    reg write_enable;
    reg [31:0] instr_in;
    reg [5:0] read_addr;
    wire [31:0] instr_out;

    fetch_unit uut(
        .clk(clk),
        .reset(reset),
        .instr_in(instr_in),
        .write_enable(write_enable),
        .read_addr(read_addr),
        .instr_out(instr_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    integer i;

    initial begin
        // GTKWave dump
        $dumpfile("fetch_unit_tb.vcd");
        $dumpvars(0, fetch_unit_tb);
    end

    initial begin
        clk = 0;
        reset = 1;
        write_enable = 0;
        read_addr = 0;
        instr_in = 0;

        #10;
        reset = 0;
        write_enable = 1;

        // Write instructions
        for(i = 0; i < 25; i = i + 1) begin
            instr_in = 32'hA0000000 + i;
            #10;
        end

        instr_in = {6'b000100,16'b0,5'b00010,5'b00011};
        #10;

        write_enable = 0;

        // Read instructions
        #10 read_addr = 6'd0;
        #10 read_addr = 6'd1;
        #10 read_addr = 6'd2;
        #10 read_addr = 6'd21;
        #10 read_addr = 6'd3;
        #10 read_addr = 6'd25;

        #50 $finish;
    end

    initial begin
        $monitor("Time: %0t | Read Addr: %d | Instruction Out: %b",
                  $time, read_addr, instr_out);
    end

endmodule