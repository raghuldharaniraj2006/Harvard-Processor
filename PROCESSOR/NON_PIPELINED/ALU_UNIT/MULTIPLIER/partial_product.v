module partial_product(in,bit,pp);
input [7:0]in;
input bit;
output [7:0]pp;

assign pp[0]= bit & in[0];
assign pp[1]= bit & in[1];
assign pp[2]= bit & in[2];
assign pp[3]= bit & in[3];
assign pp[4]= bit & in[4];
assign pp[5]= bit & in[5];
assign pp[6]= bit & in[6];
assign pp[7]= bit & in[7];

endmodule