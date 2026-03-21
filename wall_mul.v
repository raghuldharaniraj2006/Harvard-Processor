`include "partial_product.v"
`include "half_addr.v"
`include "full_addr.v"



module wall_mul(in1,in2,mul);
input [7:0] in1,in2;
output reg [15:0]mul;


//CSA 1

wire [7:0]a;
wire [7:0]b;
wire [7:0]c;
wire [9:0] y;
wire [7:0] l;

partial_product p0 (in1,in2[0],a);
partial_product p1 (in1,in2[1],b);
partial_product p2 (in1,in2[2],c);


assign y[0] = a[0];
half_addr h1 (a[1],b[0],y[1],l[0]);

full_addr f1 (a[2],b[1],c[0],y[2],l[1]);
full_addr f2 (a[3],b[2],c[1],y[3],l[2]);
full_addr f3 (a[4],b[3],c[2],y[4],l[3]);
full_addr f4 (a[5],b[4],c[3],y[5],l[4]);
full_addr f5 (a[6],b[5],c[4],y[6],l[5]);
full_addr f6 (a[7],b[6],c[5],y[7],l[6]);

half_addr h2 (b[7],c[6],y[8],l[7]);
assign y[9] = c[7];


//CSA 2

wire [7:0]d;
wire [7:0]e;
wire [7:0]f;
wire [9:0] w;
wire [7:0]k;

partial_product p3 (in1,in2[3],d);
partial_product p4 (in1,in2[4],e);
partial_product p5 (in1,in2[5],f);


assign w[0] = d[0];
half_addr h3 (d[1],e[0],w[1],k[0]);

full_addr f7 (d[2],e[1],f[0],w[2],k[1]);
full_addr f8 (d[3],e[2],f[1],w[3],k[2]);
full_addr f9 (d[4],e[3],f[2],w[4],k[3]);
full_addr f10 (d[5],e[4],f[3],w[5],k[4]);
full_addr f11 (d[6],e[5],f[4],w[6],k[5]);
full_addr f12 (d[7],e[6],f[5],w[7],k[6]);

half_addr h4 (e[7],f[6],w[8],k[7]);
assign w[9] = f[7];

// CSA 3
wire [12:0]u;
wire [7:0]v;

assign u[0] = y[0];
assign u[1] = y[1];

half_addr h5 (y[2],l[0],u[2],v[0]);

full_addr f13 (y[3],l[1],w[0],u[3],v[1]);
full_addr f14 (y[4],l[2],w[1],u[4],v[2]);
full_addr f15 (y[5],l[3],w[2],u[5],v[3]);
full_addr f16 (y[6],l[4],w[3],u[6],v[4]);
full_addr f17 (y[7],l[5],w[4],u[7],v[5]);
full_addr f18 (y[8],l[6],w[5],u[8],v[6]);
full_addr f19 (y[9],l[7],w[6],u[9],v[7]);

assign u[10] = w[7];
assign u[11] = w[8];
assign u[12] = w[9];


//CSA 4

wire [7:0]g;
wire [7:0]h;
wire [9:0]r;
wire [7:0]s;


partial_product p6 (in1,in2[6],g);
partial_product p7 (in1,in2[7],h);

assign r[0] = k[0];

half_addr h6 (k[1],g[0],r[1],s[0]);


full_addr f20 (k[2],g[1],h[0],r[2],s[1]);
full_addr f21 (k[3],g[2],h[1],r[3],s[2]);
full_addr f22 (k[4],g[3],h[2],r[4],s[3]);
full_addr f23 (k[5],g[4],h[3],r[5],s[4]);
full_addr f24 (k[6],g[5],h[4],r[6],s[5]);
full_addr f25 (k[7],g[6],h[5],r[7],s[6]);

half_addr h7 (g[7],h[6],r[8],s[7]);
assign r[9] = h[7];

// CSA 5

wire [14:0]p;
wire [9:0]q;

assign p[0] = u[0];
assign p[1] = u[1];
assign p[2] = u[2];

half_addr h8 (u[3],v[0],p[3],q[0]);
half_addr h9 (u[4],v[1],p[4],q[1]);

full_addr f26 (u[5],v[2],r[0],p[5],q[2]);
full_addr f27 (u[6],v[3],r[1],p[6],q[3]);
full_addr f28 (u[7],v[4],r[2],p[7],q[4]);
full_addr f29 (u[8],v[5],r[3],p[8],q[5]);
full_addr f30 (u[9],v[6],r[4],p[9],q[6]);
full_addr f31 (u[10],v[7],r[5],p[10],q[7]);


half_addr h10 (u[11],r[6],p[11],q[8]);
half_addr h11 (u[12],r[7],p[12],q[9]);

assign p[13] = r[8];
assign p[14] = r[9];

//CSA 6

wire [14:0] m;
wire [10:0] n;

assign m[0] = p[0];
assign m[1] = p[1];
assign m[2] = p[2];
assign m[3] = p[3];

half_addr h12 (p[4],q[0],m[4],n[0]);
half_addr h13 (p[5],q[1],m[5],n[1]);
half_addr h14 (p[6],q[2],m[6],n[2]);

full_addr f32 (p[7],q[3],s[0],m[7],n[3]);
full_addr f33 (p[8],q[4],s[1],m[8],n[4]);
full_addr f34 (p[9],q[5],s[2],m[9],n[5]);
full_addr f35 (p[10],q[6],s[3],m[10],n[6]);
full_addr f36 (p[11],q[7],s[4],m[11],n[7]);
full_addr f37 (p[12],q[8],s[5],m[12],n[8]);
full_addr f38 (p[13],q[9],s[6],m[13],n[9]);

half_addr h15 (p[14],s[7],m[14],n[10]);


wire [15:0] sum_f;
wire [15:0] carry_f;

assign sum_f = {1'b0,m[14:0]};
assign carry_f = {n[10:0],5'b00000};

wire [8:0]mul_0;
wire [8:0]mul_1;
wire [8:0]mul_2;
wire [8:0]mul_3;


kgp_add k1 (sum_f[7:0],carry_f[7:0],mul_0);
kgp_add k2 (sum_f[15:8],carry_f[15:8],mul_1);
kgp_add k3 (sum_f[15:8],carry_f[15:8],mul_2);
kgp_add k4 (mul_2[7:0],8'b00000001,mul_3);



always @ (mul_0,mul_1,mul_2,mul_3)
    begin
        if (mul_0[8] == 0)
            mul = {mul_1,mul_0[7:0]};
        else
            mul = {mul_3,mul_0[7:0]};




    end

endmodule