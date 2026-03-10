module register_file (clk,write_en,data_in,read_addr,write_addr,data_out);

input clk;
input [4:0] read_addr,write_addr;
input [7:0] data_in;
input write_en;
output [7:0] data_out;

reg [7:0] rf [0:31];

always @ (posedge clk)

begin
    
    begin
        if (write_en)
            rf[write_addr] <= data_in;
    
    end
end
assign data_out = rf[read_addr];


endmodule