module mux(y,in0,in1,sel);
input in1,in0,sel;
output y;
assign y = ((~sel)&(in0)) |((sel)& (in1));

endmodule