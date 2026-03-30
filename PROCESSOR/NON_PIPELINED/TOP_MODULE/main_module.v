`include "alu_unit.v"
`include "decoder.v"
`include "fetch_unit.v"     
`include "memory.v"
`include "register_file.v"
`include "writeback.v"






module main_module(
    input clk,
    input reset,
    input [31:0] instr_in,
    input instr_write_en
);
    // PROGRAM COUNTER (PC)
    reg [5:0] pc;

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 6'd0;
        else if  (!instr_write_en)   
            pc <= pc + 1'b1;
    end

    // Instruction wire 
    wire [31:0] instruction;

    // FETCH UNIT
  fetch_unit fetch (
        .clk(clk),
        .reset(reset),
        .instr_in(instr_in),
        .write_enable(instr_write_en),
        .read_addr(pc),
        .instr_out(instruction)
    );

    wire [5:0] opcode;
    assign opcode = instruction[31:26];

   //REGISTER FILE
    wire [4:0] reg_addr_A, reg_addr_B;

    wire [7:0] reg_data_A, reg_data_B;
   
    wire reg_write_en;
    wire [4:0] reg_write_addr;
    wire [7:0] reg_write_data;


    register_file regfile (
        .clk(clk),
        .write_en(reg_write_en), 
        .read_addr1(reg_addr_A),
        .read_addr2(reg_addr_B),    
        .write_addr(reg_write_addr),
        .data_in(reg_write_data),   
        .data_out1(reg_data_A),
        .data_out2(reg_data_B)
         
    );

    // DECODE UNIT
    wire [7:0] A, B;    
    decode_unit decode (
        .instruction(instruction),
        .rf_data_rsrc1(reg_data_A),
        .rf_data_rsrc2(reg_data_B),
        .read_addr1(reg_addr_A),
        .read_addr2(reg_addr_B),
        .A(A),
        .B(B)
    );

    // ALU UNIT
    
     wire [7:0] alu_C;
     wire [7:0] alu_C_hi;

    

    alu_unit alu (
            .A(A),
            .B(B),
            .instruction(instruction),
            .C(alu_C),
            .C_hi(alu_C_hi)
        ) ;

    //DATA MEMORY  UNIT

    wire [7:0] mem_addr;
    wire [7:0] mem_src_addr;
    wire [7:0] mem_data_out;
    wire mem_write_en;

    memory data_memory (
        .clk(clk),
        .data_in(reg_write_data),        
        .write_addr(mem_addr), 
        .read_addr(mem_src_addr),  
        .write_en(mem_write_en), 
        .data_out(mem_data_out) 
    );

    //WRITE BACK




   writeback_unit wb (
        .instruction(instruction),
        .alu_result(alu_C),
        .mem_data(mem_data_out),
        .reg_src_data(A),

        .mem_src_addr(mem_src_addr),

        .data_out(reg_write_data),
        .reg_addr(reg_write_addr),
        .mem_addr(mem_addr),

        .reg_write_en(reg_write_en),
        .mem_write_en(mem_write_en)
    );


endmodule




