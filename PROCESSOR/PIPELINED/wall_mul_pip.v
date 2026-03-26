`include "partial_product.v"
`include "half_addr.v"
`include "full_addr.v"
`include "kgp_add.v"



module wall_mul_pip(clk,rst,in1,in2,mul,in1_s,in2_s);
input [7:0] in1,in2;
input clk,rst;
output reg [7:0] in1_s,in2_s;
output  [15:0] mul;

wire [7:0] a,b,c,d,e,f,g,h;

partial_product p0 (in1,in2[0],a);
partial_product p1 (in1,in2[1],b);
partial_product p2 (in1,in2[2],c);
partial_product p3 (in1,in2[3],d);
partial_product p4 (in1,in2[4],e);
partial_product p5 (in1,in2[5],f);
partial_product p6 (in1,in2[6],g);
partial_product p7 (in1,in2[7],h);

//stage 1 

reg [7:0] g_s1, h_s1;

//CSA 1

reg [7:0] l_s;
reg [9:0] y_s;
reg [7:0] in1_s1, in2_s1;

wire [9:0] y;
wire [7:0] l;



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


wire [9:0] w;
wire [7:0] k;


reg [9:0] w_s;
reg [7:0]k_s;


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






always @ (posedge clk or posedge rst)
begin
    if (rst)
        begin
            in1_s1 <= 0;
            in2_s1 <= 0;

            l_s <= 0; w_s <=0;
            y_s <= 0; k_s <=0;
            g_s1 <= 0;  h_s1 <=0;

        end
    else  
        begin
            in1_s1 <= in1;
            in2_s1 <= in2;
            
            y_s <= y; w_s <= w;
            l_s <= l; k_s <= k;
            g_s1 <= g; h_s1 <= h;
        end


end


//stage 2

// CSA 3
wire [12:0]u;
wire [7:0]v;

assign u[0] = y_s[0];
assign u[1] = y_s[1];

half_addr h5 (y_s[2],l_s[0],u[2],v[0]);

full_addr f13 (y_s[3],l_s[1],w_s[0],u[3],v[1]);
full_addr f14 (y_s[4],l_s[2],w_s[1],u[4],v[2]);
full_addr f15 (y_s[5],l_s[3],w_s[2],u[5],v[3]);
full_addr f16 (y_s[6],l_s[4],w_s[3],u[6],v[4]);
full_addr f17 (y_s[7],l_s[5],w_s[4],u[7],v[5]);
full_addr f18 (y_s[8],l_s[6],w_s[5],u[8],v[6]);
full_addr f19 (y_s[9],l_s[7],w_s[6],u[9],v[7]);

assign u[10] = w_s[7];
assign u[11] = w_s[8];
assign u[12] = w_s[9];


//CSA 4


wire [9:0]r;
wire [7:0]s;



assign r[0] = k_s[0];

half_addr h6 (k_s[1],g_s1[0],r[1],s[0]);



full_addr f20 (k_s[2],g_s1[1],h_s1[0],r[2],s[1]);
full_addr f21 (k_s[3],g_s1[2],h_s1[1],r[3],s[2]);
full_addr f22 (k_s[4],g_s1[3],h_s1[2],r[4],s[3]);
full_addr f23 (k_s[5],g_s1[4],h_s1[3],r[5],s[4]);
full_addr f24 (k_s[6],g_s1[5],h_s1[4],r[6],s[5]);
full_addr f25 (k_s[7],g_s1[6],h_s1[5],r[7],s[6]);

half_addr h7 (g_s1[7],h_s1[6],r[8],s[7]);
assign r[9] = h_s1[7];

reg [12:0]u_s;
reg [7:0]v_s,in1_s2,in2_s2,s_s;
reg [9:0] r_s;

always @ (posedge clk or posedge rst)
begin
    if (rst)
        begin
            in1_s2 <= 0;
            in2_s2 <= 0;

            u_s <= 0; v_s <=0;
            r_s <= 0; s_s <=0;
            

        end
    else  
        begin
            in1_s2 <= in1_s1;
            in2_s2 <= in2_s1;
            
            u_s <= u; v_s <= v;
            r_s <= r; s_s <= s;
          
        end


end

//stage 3
reg [7:0]s_s3;
reg [7:0]in1_s3,in2_s3;
wire [14:0]p;
wire [9:0]q;

reg [14:0] p_s;
reg [9:0] q_s;


assign p[0] = u_s[0];
assign p[1] = u_s[1];
assign p[2] = u_s[2];

half_addr h8 (u_s[3],v_s[0],p[3],q[0]);
half_addr h9 (u_s[4],v_s[1],p[4],q[1]);

full_addr f26 (u_s[5],v_s[2],r_s[0],p[5],q[2]);
full_addr f27 (u_s[6],v_s[3],r_s[1],p[6],q[3]);
full_addr f28 (u_s[7],v_s[4],r_s[2],p[7],q[4]);
full_addr f29 (u_s[8],v_s[5],r_s[3],p[8],q[5]);
full_addr f30 (u_s[9],v_s[6],r_s[4],p[9],q[6]);
full_addr f31 (u_s[10],v_s[7],r_s[5],p[10],q[7]);


half_addr h10 (u_s[11],r_s[6],p[11],q[8]);
half_addr h11 (u_s[12],r_s[7],p[12],q[9]);

assign p[13] = r_s[8];
assign p[14] = r_s[9];

always @ (posedge clk or posedge rst)
begin
    if (rst)
        begin
            in1_s3 <= 0;
            in2_s3 <= 0;
            s_s3 <= 0;
            p_s <= 0;
            q_s <=0;
          
            

        end
    else  
        begin
            in1_s3 <= in1_s2;
            in2_s3 <= in2_s2;
            s_s3 <= s_s;
            p_s <= p; 
            q_s <= q;
         
          
        end
end

//stage 4




wire [14:0] m;
wire [10:0] n;

assign m[0] = p_s[0];
assign m[1] = p_s[1];
assign m[2] = p_s[2];
assign m[3] = p_s[3];

half_addr h12 (p_s[4],q_s[0],m[4],n[0]);
half_addr h13 (p_s[5],q_s[1],m[5],n[1]);
half_addr h14 (p_s[6],q_s[2],m[6],n[2]);

full_addr f32 (p_s[7],q_s[3],s_s3[0],m[7],n[3]);
full_addr f33 (p_s[8],q_s[4],s_s3[1],m[8],n[4]);
full_addr f34 (p_s[9],q_s[5],s_s3[2],m[9],n[5]);
full_addr f35 (p_s[10],q_s[6],s_s3[3],m[10],n[6]);
full_addr f36 (p_s[11],q_s[7],s_s3[4],m[11],n[7]);
full_addr f37 (p_s[12],q_s[8],s_s3[5],m[12],n[8]);
full_addr f38 (p_s[13],q_s[9],s_s3[6],m[13],n[9]);

half_addr h15 (p_s[14],s_s3[7],m[14],n[10]);


reg [15:0] sum_f;
reg [15:0] carry_f;




wire [8:0]mul_0;
wire [8:0]mul_1;
wire [8:0]mul_2;
wire [8:0]mul_3;


kgp_add k1 (sum_f[7:0],carry_f[7:0],mul_0);
kgp_add k2 (sum_f[15:8],carry_f[15:8],mul_1);
kgp_add k3 (sum_f[15:8],carry_f[15:8],mul_2);
kgp_add k4 (mul_2[7:0],8'b00000001,mul_3);



always @ (posedge clk or posedge rst)
begin
    if (rst)
        begin
            sum_f <= 0;
            carry_f <= 0;
            in1_s <= 0;
            in2_s <= 0;

        end
    else
        begin
            sum_f <= {1'b0,m[14:0]};
            carry_f <= {n[10:0],5'b00000};
            in1_s <= in1_s3;
            in2_s <= in2_s3;

            
        end

end


   
assign mul = (mul_0[8] == 1'b0) ? {mul_1[7:0], mul_0[7:0]} : {mul_3[7:0], mul_0[7:0]};

    







endmodule