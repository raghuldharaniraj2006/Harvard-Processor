`include "four_1_mux.v"

module kgp_sub(i1,i2,sub);
input [7:0] i1;
input [7:0] i2;
wire [7:0] I2;
output reg [7:0] sub;
wire [17:0] kgp;
wire [15:0] kgp1;
wire [15:0] kgp2;
wire [15:0] kgp3;
wire [7:0] kgp4; 

assign I2 = ~i2;
assign kgp[1:0]=2'b11;
assign kgp[3:2]   =  {i1[0],I2[0]};
assign kgp[5:4]   =  {i1[1],I2[1]};
assign kgp[7:6]   =  {i1[2],I2[2]};
assign kgp[9:8]   =  {i1[3],I2[3]};
assign kgp[11:10] =  {i1[4],I2[4]};
assign kgp[13:12] =  {i1[5],I2[5]};
assign kgp[15:14] =  {i1[6],I2[6]};
assign kgp[17:16] =  {i1[7],I2[7]};

//stage1
assign kgp1[1:0]=kgp[1:0];

four_1_mux m1(2'b00,kgp[1:0],kgp[1:0],2'b11,kgp[3:2],kgp1[3:2]);
four_1_mux m2(2'b00,kgp[3:2],kgp[3:2],2'b11,kgp[5:4],kgp1[5:4]);
four_1_mux m3(2'b00,kgp[5:4],kgp[5:4],2'b11,kgp[7:6],kgp1[7:6]);
four_1_mux m4(2'b00,kgp[7:6],kgp[7:6],2'b11,kgp[9:8],kgp1[9:8]);
four_1_mux m5(2'b00,kgp[9:8],kgp[9:8],2'b11,kgp[11:10],kgp1[11:10]);
four_1_mux m6(2'b00,kgp[11:10],kgp[11:10],2'b11,kgp[13:12],kgp1[13:12]);
four_1_mux m7(2'b00,kgp[13:12],kgp[13:12],2'b11,kgp[15:14],kgp1[15:14]);

//stage2
assign kgp2[1:0]=kgp1[1:0];
assign kgp2[3:2]=kgp1[3:2];

four_1_mux m8(2'b00,kgp1[1:0],kgp1[1:0],2'b11,kgp1[5:4],kgp2[5:4]);
four_1_mux m9(2'b00,kgp1[3:2],kgp1[3:2],2'b11,kgp1[7:6],kgp2[7:6]);
four_1_mux m10(2'b00,kgp1[5:4],kgp1[5:4],2'b11,kgp1[9:8],kgp2[9:8]);
four_1_mux m11(2'b00,kgp1[7:6],kgp1[7:6],2'b11,kgp1[11:10],kgp2[11:10]);
four_1_mux m12(2'b00,kgp1[9:8],kgp1[9:8],2'b11,kgp1[13:12],kgp2[13:12]);
four_1_mux m13(2'b00,kgp1[11:10],kgp1[11:10],2'b11,kgp1[15:14],kgp2[15:14]);

//stage3
assign kgp3[1:0]=kgp2[1:0];
assign kgp3[3:2]=kgp2[3:2];
assign kgp3[5:4]=kgp2[5:4];
assign kgp3[7:6]=kgp2[7:6];

four_1_mux m14(2'b00,kgp2[1:0],kgp2[1:0],2'b11,kgp2[9:8],kgp3[9:8]);
four_1_mux m15(2'b00,kgp2[3:2],kgp2[3:2],2'b11,kgp2[11:10],kgp3[11:10]);
four_1_mux m16(2'b00,kgp2[5:4],kgp2[5:4],2'b11,kgp2[13:12],kgp3[13:12]);
four_1_mux m17(2'b00,kgp2[7:6],kgp2[7:6],2'b11,kgp2[15:14],kgp3[15:14]);

//carrys

assign kgp4[0] = kgp3[0];
assign kgp4[1] = kgp3[3];
assign kgp4[2] = kgp3[5];
assign kgp4[3] = kgp3[7];
assign kgp4[4] = kgp3[9];
assign kgp4[5] = kgp3[11];
assign kgp4[6] = kgp3[13];
assign kgp4[7] = kgp3[15];

//sum



always @(*)
begin
        sub[0] = i1[0] ^ I2[0] ^ kgp4[0];
        sub[1] = i1[1] ^ I2[1] ^ kgp4[1];
        sub[2] = i1[2] ^ I2[2] ^ kgp4[2];
        sub[3] = i1[3] ^ I2[3] ^ kgp4[3];
        sub[4] = i1[4] ^ I2[4] ^ kgp4[4];
        sub[5] = i1[5] ^ I2[5] ^ kgp4[5];
        sub[6] = i1[6] ^ I2[6] ^ kgp4[6];
        sub[7] = i1[7] ^ I2[7] ^ kgp4[7];

        if (i1 < i2)  sub = (~sub) + 1;




end











endmodule