
module instn_memory(clk,rst,data_in,addr_in,data_out);
input clk,rst;
input [31:0]data_in;
output reg [31:0] data_out;
input [5:0] addr_in;

reg [31:0] memory [63:0];

always @ (posedge clk or posedge rst)
begin
    if (rst) data_out <= 0;
    else 
    begin
    memory[addr_in] <= data_in;
    data_out <= data_in;
    end
end





endmodule