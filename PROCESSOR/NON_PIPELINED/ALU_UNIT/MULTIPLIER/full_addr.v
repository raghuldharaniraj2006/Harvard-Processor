module full_addr(in1,in2,in3,sum,carry);
input in1,in2,in3;
output sum,carry;

assign sum = in1 ^ in2 ^ in3;
assign carry = (in1 & in2)  |  (in3 & in2) |  (in1 & in3);


endmodule