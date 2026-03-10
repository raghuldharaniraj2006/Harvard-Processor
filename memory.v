module memory(clk,data_in,write_addr,read_addr,write_en,data_out);

input clk;
input  [7:0] data_in;

input [7:0] write_addr;
input [7:0] read_addr;
input write_en;
output [7:0] data_out;

reg[7:0] mem[0:255];


always @ (posedge clk) 
begin
    if(write_en)
    mem[write_addr] = data_in;
end

assign data_out = mem[read_addr];

endmodule
