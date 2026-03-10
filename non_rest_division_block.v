module division_block(acc,q,m,minus_m,next_acc,next_q);
input [8:0] acc,m,minus_m;
input [7:0] q;
output  [8:0] next_acc;
output  [7:0] next_q;

wire [8:0] temp_acc;


assign temp_acc = {acc[7:0],q[7]};

assign next_acc = (temp_acc[8]) ? (temp_acc + m) : (temp_acc + minus_m);

assign next_q = {q[6:0],~(next_acc[8])};


endmodule