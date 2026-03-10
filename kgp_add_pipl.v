`include "four_1_mux.v"

    module kgp_add_pipl(clk,rst,i1,i2,sum, in2_s5,in1_s5);
    input clk,rst;
    input [7:0]i1,i2;
    output reg [8:0]sum;
    output reg [7:0] in2_s5,in1_s5;

    //stage1

    reg [17:0]kgp;
    reg [7:0]in1_s1,in2_s1;

    always @ (posedge clk)
    begin
        if(rst)
            begin
                kgp <= 0;
                in1_s1 <= 0;
                in2_s1 <= 0;
            end

        else 
            begin
                kgp[1:0]   <=   2'b00;
                kgp[3:2]   <=  {i1[0],i2[0]};
                kgp[5:4]   <=  {i1[1],i2[1]};
                kgp[7:6]   <=  {i1[2],i2[2]};
                kgp[9:8]   <=  {i1[3],i2[3]};
                kgp[11:10] <=  {i1[4],i2[4]};
                kgp[13:12] <=  {i1[5],i2[5]};
                kgp[15:14] <=  {i1[6],i2[6]};
                kgp[17:16] <=  {i1[7],i2[7]};

                in1_s1 <= i1;
                in2_s1 <= i2;           
            end

    end

    //stage2

    reg [15:0]kgp1;
    reg [7:0]in1_s2,in2_s2;
    wire [15:0] mux_s2;
    reg [1:0] c2;


    four_1_mux m1(2'b00,kgp[1:0],kgp[1:0],2'b11,kgp[3:2],mux_s2[3:2]);
    four_1_mux m2(2'b00,kgp[3:2],kgp[3:2],2'b11,kgp[5:4],mux_s2[5:4]);
    four_1_mux m3(2'b00,kgp[5:4],kgp[5:4],2'b11,kgp[7:6],mux_s2[7:6]);
    four_1_mux m4(2'b00,kgp[7:6],kgp[7:6],2'b11,kgp[9:8],mux_s2[9:8]);
    four_1_mux m5(2'b00,kgp[9:8],kgp[9:8],2'b11,kgp[11:10],mux_s2[11:10]);
    four_1_mux m6(2'b00,kgp[11:10],kgp[11:10],2'b11,kgp[13:12],mux_s2[13:12]);
    four_1_mux m7(2'b00,kgp[13:12],kgp[13:12],2'b11,kgp[15:14],mux_s2[15:14]);

    always @ (posedge clk)
    begin
        
        if (rst)
        begin
            kgp1 <= 0;
            in1_s2 <= 0;
            in2_s2 <= 0;
            c2 <= 0;
        end
        else
        begin
            kgp1 <= {mux_s2[15:2],kgp[1:0]};
            c2 <= kgp[17:16];
            in1_s2 <= in1_s1;
            in2_s2 <= in2_s1;
        end  

    end

    //stage3
    reg [15:0]kgp2;
    reg [7:0] in2_s3,in1_s3;
    reg [1:0] c3;
    wire [15:0]mux_s3;


    four_1_mux m8(2'b00,kgp1[1:0],kgp1[1:0],2'b11,kgp1[5:4],mux_s3[5:4]);
    four_1_mux m9(2'b00,kgp1[3:2],kgp1[3:2],2'b11,kgp1[7:6],mux_s3[7:6]);
    four_1_mux m10(2'b00,kgp1[5:4],kgp1[5:4],2'b11,kgp1[9:8],mux_s3[9:8]);
    four_1_mux m11(2'b00,kgp1[7:6],kgp1[7:6],2'b11,kgp1[11:10],mux_s3[11:10]);
    four_1_mux m12(2'b00,kgp1[9:8],kgp1[9:8],2'b11,kgp1[13:12],mux_s3[13:12]);
    four_1_mux m13(2'b00,kgp1[11:10],kgp1[11:10],2'b11,kgp1[15:14],mux_s3[15:14]);

    always @ (posedge clk)
    begin

        if (rst)
        begin
            kgp2 <= 0;
            in1_s3 <= 0;
            in2_s3 <= 0;
            c3 <= 0;

        end
        else
        begin
            kgp2 <= {mux_s3[15:4],kgp1[3:2],kgp1[1:0]};
            c3 <= c2;
            in1_s3 <= in1_s2;
            in2_s3 <= in2_s2;
        end


    end

    //stage 4

    reg [15:0]kgp3;
    reg [7:0] in1_s4,in2_s4;
    reg [1:0] c4;
    wire [15:0]mux_s4;

    four_1_mux m14(2'b00,kgp2[1:0],kgp2[1:0],2'b11,kgp2[9:8],mux_s4[9:8]);
    four_1_mux m15(2'b00,kgp2[3:2],kgp2[3:2],2'b11,kgp2[11:10],mux_s4[11:10]);
    four_1_mux m16(2'b00,kgp2[5:4],kgp2[5:4],2'b11,kgp2[13:12],mux_s4[13:12]);
    four_1_mux m17(2'b00,kgp2[7:6],kgp2[7:6],2'b11,kgp2[15:14],mux_s4[15:14]);

    always @ (posedge clk)
    begin
        if (rst)
            begin 
                kgp3 <= 0;
                in1_s4 <= 0;
                in2_s4 <= 0;
                c4 <= 0;
            end

        else
            begin
            
            kgp3 <= {mux_s4[15:8],kgp2[7:0]};
            c4 <= c3;
            in1_s4 <= in1_s3;
            in2_s4 <= in2_s3;

            end

    end

    reg [7:0]kgp4;

    always @ (posedge clk)
        begin
        if (rst)
        begin
            sum <= 9'b0;
            in1_s5 <= 0;
            in2_s5 <= 0;
        end

        else
            begin  

                 in1_s5 <= in1_s4;
                 in2_s5 <= in2_s4;
            
                kgp4[0]=kgp3[1];
                kgp4[1]=kgp3[3];
                kgp4[2]=kgp3[5];
                kgp4[3]=kgp3[7];
                kgp4[4]=kgp3[9];
                kgp4[5]=kgp3[11];
                kgp4[6]=kgp3[13];
                kgp4[7]=kgp3[15];








            sum[0] <= in1_s4[0] ^ in2_s4[0] ^ kgp4[0];
            sum[1] <= in1_s4[1] ^ in2_s4[1] ^ kgp4[1];
            sum[2] <= in1_s4[2] ^ in2_s4[2] ^ kgp4[2];
            sum[3] <= in1_s4[3] ^ in2_s4[3] ^ kgp4[3];
            sum[4] <= in1_s4[4] ^ in2_s4[4] ^ kgp4[4];
            sum[5] <= in1_s4[5] ^ in2_s4[5] ^ kgp4[5];
            sum[6] <= in1_s4[6] ^ in2_s4[6] ^ kgp4[6];
            sum[7] <= in1_s4[7] ^ in2_s4[7] ^ kgp4[7];

            if (c4 == 2'b00)
                sum[8] <= 1'b0;
            else if (c4 == 2'b11)
                sum[8] <= 1'b1;
            else 
                sum[8] <= kgp3[15]; 
            
            end
        end




    endmodule