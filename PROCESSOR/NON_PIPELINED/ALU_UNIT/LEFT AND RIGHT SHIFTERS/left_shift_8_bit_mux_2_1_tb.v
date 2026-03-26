`include "left_shift_8_bit_mux_2_1.v"

module left_shift_8_bit_tb;
reg [7:0] in;
reg [2:0] s;
wire [7:0]out;
left_shift_8_bit dut(in,out,s);
initial 
begin
    $monitor("input = %8b, left_shift_by %3b, output = %8b",in,s,out);

    in = 8'b10101010;
    s=3'b001; #10 ;
    s=3'b010; #10 ;

    in = 8'b11111111;
    s=3'b111; #10 ;

    
    $finish;
end
endmodule