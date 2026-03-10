`include "full_addr.v"
`include "half_addr.v"

module common_csa(a,b,c,y,z);
input [7:0] a,b,c;
output [9:0] y;
output [7:0] z;

assign y[0] = a[0];
half_addr h1 (a[1],b[0],y[1],z[0]);

full_addr f1 (a[2],b[1],c[0],y[2],z[1]);
full_addr f2 (a[3],b[2],c[1],y[3],z[2]);
full_addr f3 (a[4],b[3],c[2],y[4],z[3]);
full_addr f4 (a[5],b[4],c[3],y[5],z[4]);
full_addr f5 (a[6],b[5],c[4],y[6],z[5]);
full_addr f6 (a[7],b[6],c[5],y[7],z[6]);

half_addr h2 (b[7],c[6],y[8],z[7]);
assign y[9] = c[7];

endmodule