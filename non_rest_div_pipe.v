`include "non_rest_division_block.v"

module non_rest_div_pipe(clk, rst,divident,divisor,quotient, remainder);
input clk,rst;
input [7:0] divident,divisor;
output [7:0] quotient,remainder;

    
    wire [8:0] m = {1'b0, divisor};
    wire [8:0] minus_m = (~(m) + 1'b1);
    wire [8:0] acc = 9'b0;
    wire [7:0] q   = divident;

   //stage1
    wire [8:0] temp_acc1;
    wire [7:0] temp_q1;
    reg [8:0] next_acc1, next_m1, next_minus_m1;
    reg [7:0] next_q1;

    division_block b1 (acc, q, m, minus_m, temp_acc1, temp_q1);
    always @ (posedge clk or posedge rst) begin
        if(rst) begin
            {next_acc1, next_q1, next_m1, next_minus_m1} <= 0;
        end else begin
            next_acc1 <= temp_acc1;
            next_q1   <= temp_q1;
            next_m1   <= m;
            next_minus_m1 <= minus_m;
        end
    end

    //stage2
    wire [8:0] temp_acc2;
    wire [7:0] temp_q2;
    reg [8:0] next_acc2, next_m2, next_minus_m2;
    reg [7:0] next_q2;

    division_block b2 (next_acc1, next_q1, next_m1, next_minus_m1, temp_acc2, temp_q2);
    always @ (posedge clk or posedge rst) begin
        if(rst) begin
            {next_acc2, next_q2, next_m2, next_minus_m2} <= 0;
        end else begin
            next_acc2 <= temp_acc2;
            next_q2   <= temp_q2;
            next_m2   <= next_m1;
            next_minus_m2 <= next_minus_m1;
        end
    end

    //stage3
    wire [8:0] temp_acc3;
    wire [7:0] temp_q3;
    reg [8:0] next_acc3, next_m3, next_minus_m3;
    reg [7:0] next_q3;

    division_block b3 (next_acc2, next_q2, next_m2, next_minus_m2, temp_acc3, temp_q3);
    always @ (posedge clk or posedge rst) begin
        if(rst) begin
            {next_acc3, next_q3, next_m3, next_minus_m3} <= 0;
        end else begin
            next_acc3 <= temp_acc3;
            next_q3   <= temp_q3;
            next_m3   <= next_m2;
            next_minus_m3 <= next_minus_m2;
        end
    end

     //stage4
    wire [8:0] temp_acc4;
    wire [7:0] temp_q4;
    reg [8:0] next_acc4, next_m4, next_minus_m4;
    reg [7:0] next_q4;

    division_block b4 (next_acc3, next_q3, next_m3, next_minus_m3, temp_acc4, temp_q4);
    always @ (posedge clk or posedge rst) begin
        if(rst) begin
            {next_acc4, next_q4, next_m4, next_minus_m4} <= 0;
        end else begin
            next_acc4 <= temp_acc4;
            next_q4   <= temp_q4;
            next_m4   <= next_m3;
            next_minus_m4 <= next_minus_m3;
        end
    end

     //stage5
    wire [8:0] temp_acc5;
    wire [7:0] temp_q5;
    reg [8:0] next_acc5, next_m5, next_minus_m5;
    reg [7:0] next_q5;

    division_block b5 (next_acc4, next_q4, next_m4, next_minus_m4, temp_acc5, temp_q5);
    always @ (posedge clk or posedge rst) begin
        if(rst) begin
            {next_acc5, next_q5, next_m5, next_minus_m5} <= 0;
        end else begin
            next_acc5 <= temp_acc5;
            next_q5   <= temp_q5;
            next_m5   <= next_m4;
            next_minus_m5 <= next_minus_m4;
        end
    end

     //stage6
    wire [8:0] temp_acc6;
    wire [7:0] temp_q6;
    reg [8:0] next_acc6, next_m6, next_minus_m6;
    reg [7:0] next_q6;

    division_block b6 (next_acc5, next_q5, next_m5, next_minus_m5, temp_acc6, temp_q6);
    always @ (posedge clk or posedge rst) begin
        if(rst) begin
            {next_acc6, next_q6, next_m6, next_minus_m6} <= 0;
        end else begin
            next_acc6 <= temp_acc6;
            next_q6   <= temp_q6;
            next_m6   <= next_m5;
            next_minus_m6 <= next_minus_m5;
        end
    end

     //stage7
    wire [8:0] temp_acc7;
    wire [7:0] temp_q7;
    reg [8:0] next_acc7, next_m7, next_minus_m7;
    reg [7:0] next_q7;

    division_block b7 (next_acc6, next_q6, next_m6, next_minus_m6, temp_acc7, temp_q7);
    always @ (posedge clk or posedge rst) begin
        if(rst) begin
            {next_acc7, next_q7, next_m7, next_minus_m7} <= 0;
        end else begin
            next_acc7 <= temp_acc7;
            next_q7   <= temp_q7;
            next_m7   <= next_m6;
            next_minus_m7 <= next_minus_m6;
        end
    end

    //stage8
    wire [8:0] temp_acc8;
    wire [7:0] temp_q8;
    reg [8:0] next_acc8, next_m8, next_minus_m8;
    reg [7:0] next_q8;

    division_block b8 (next_acc7, next_q7, next_m7, next_minus_m7, temp_acc8, temp_q8);
    always @ (posedge clk or posedge rst) begin
        if(rst) begin
            {next_acc8, next_q8, next_m8, next_minus_m8} <= 0;
        end else begin
            next_acc8 <= temp_acc8;
            next_q8   <= temp_q8;
            next_m8   <= next_m7;
            next_minus_m8 <= next_minus_m7;
        end
    end

  
    assign quotient  = next_q8;
    assign remainder = (next_acc8[8]) ? (next_acc8[7:0] + next_m8[7:0]) : next_acc8[7:0];

endmodule