module mux(y,in1,in0,sel);
input sel,in1,in0;
output y;
assign y = ((~sel) & in0) | ((sel) & in1);
endmodule

module right_shift_pipe(clk,rst,in,out,s);
input clk,rst;
input [7:0]in;
output [7:0]out;
input [2:0]s;

wire w0,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15;
reg r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15;
reg [2:0] s1;
reg [2:0] s2;

mux m0(w0,in[1],in[0],s[0]);
mux m1(w1,in[2],in[1],s[0]);
mux m2(w2,in[3],in[2],s[0]);
mux m3(w3,in[4],in[3],s[0]);
mux m4(w4,in[5],in[4],s[0]);
mux m5(w5,in[6],in[5],s[0]);
mux m6(w6,in[7],in[6],s[0]);
mux m7(w7,1'b0,in[7],s[0]);

always @ (posedge clk)
begin

    if (rst )
        begin
        s1 <= 0;
        r0 <= 0; r1 <= 0; r2 <= 0; r3 <= 0;
        r4 <= 0; r5 <= 0; r6 <= 0; r7 <= 0;
        end
    else   
        begin
        s1 <= s;
        r0 <= w0; r1 <= w1; r2 <= w2; r3 <= w3;
        r4 <= w4; r5 <= w5; r6 <= w6; r7 <= w7;
        end
end


mux m8(w8,r2,r0,s1[1]);
mux m9(w9,r3,r1,s1[1]);
mux m10(w10,r4,r2,s1[1]);
mux m11(w11,r5,r3,s1[1]);
mux m12(w12,r6,r4,s1[1]);
mux m13(w13,r7,r5,s1[1]);
mux m14(w14,1'b0,r6,s1[1]);
mux m15(w15,1'b0,r7,s1[1]);


always @ (posedge clk)
begin
if (rst ) begin
        s2 <= 0;
        r8 <= 0; r9 <= 0; r10 <= 0; r11 <= 0;
        r12 <= 0; r13 <= 0; r14 <= 0; r15 <= 0;
        end
        
else    begin
        s2 <= s1;
        r8 <= w8; r9 <= w9; r10 <= w10; r11 <= w11;
        r12 <= w12; r13 <= w13; r14 <= w14; r15 <= w15;
        end
end

mux m16(out[0],r12,r8,s2[2]);
mux m17(out[1],r13,r9,s2[2]);
mux m18(out[2],r14,r10,s2[2]);
mux m19(out[3],r15,r11,s2[2]);
mux m20(out[4],1'b0,r12,s2[2]);
mux m21(out[5],1'b0,r13,s2[2]);
mux m22(out[6],1'b0,r14,s2[2]);
mux m23(out[7],1'b0,r15,s2[2]);

endmodule