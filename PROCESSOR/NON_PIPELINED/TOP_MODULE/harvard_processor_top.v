module harvard_processor_top(
    input clk,
    input rst,
    input write_enable,
    input [31:0] instr_in
);

reg [5:0] pc;
always @ (posedge clk or posedge rst) begin
    if(rst)
        pc <= 6'd0;
    else if(!write_enable)
        pc <= pc + 1'b1;
end



wire [31:0] instruction;

fetch_unit fetch (
    .clk(clk),
    .rst(rst),
    .instr_in(instr_in),
    .write_enable(write_enable),
    .read_addr(pc),
    .instr_out(instruction)
);

wire [7:0] reg_data1;
wire [7:0] reg_data2;
 
wire [4:0] reg_addr1;
wire [4:0] reg_addr2;

wire [4:0] rf_addr;
wire [7:0] write_data;

wire reg_file_en;


register_file_dual regfile (
    .clk(clk),
    .write_en(reg_file_en),  // No register writes in this simplified version
    .read_addr1(reg_addr1),
    .read_addr2(reg_addr2), 
    .write_addr(rf_addr),
    .data_in(write_data),
    .data_out1(reg_data1),
    .data_out2(reg_data2)
);

wire [7:0]A,B;

decode_unit deco (
    .instruction(instruction),
    .read_addr1(reg_addr1),
    .read_addr2(reg_addr2),
    .rf_data_rsrc1(reg_data1),
    .rf_data_rsrc2(reg_data2),
    .A(A),
    .B(B)
);

wire [7:0] alu_result;
wire [7:0] carry_out;

alu_unit alu (
    .A(A),
    .B(B),
    .instruction(instruction),
    .C(alu_result),
    .C_hi(carry_out)
);

wire [7:0] mem_addr;

wire write_en_mem;

writeback_unit writeback (
    .instruction(instruction),
    .alu_result(alu_result),
    .mem_read_data(), // No memory reads in this simplified version
    .rf_addr(rf_addr),
    .mem_addr(mem_addr),
    .data_out(write_data),
    .rf_we(reg_file_en),  // Not used in this simplified version
    .mem_we(write_en_mem)  // Not used in this simplified version
);

memory mem (
    .clk(clk),
  
    .write_en(write_en_mem), // Not used in this simplified version
    .read_addr(mem_addr),
    .write_addr(mem_addr),
    .data_in(alu_result),
    .data_out() // No memory reads in this simplified version
);


endmodule