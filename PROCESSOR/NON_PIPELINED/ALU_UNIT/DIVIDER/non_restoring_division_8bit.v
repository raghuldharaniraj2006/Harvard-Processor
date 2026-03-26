`include "non_restoring_division_stage.v"
module non_restoring_division_8bit (

    input [7:0] QQ,
    input [7:0] M,
    output reg [7:0] quotient,
    output reg [7:0] remainder 
);

wire [7:0] AA;
wire [7:0] AA0;
wire [7:0] QQ0;
assign AA = 8'b0;
non_restoring_division_stage stage0 (.A_in(AA),.Q_in(QQ),.M(M),.A_out(AA0),.Q_out(QQ0));

wire [7:0] AA1;
wire [7:0] QQ1;
non_restoring_division_stage stage1 (.A_in(AA0),.Q_in(QQ0),.M(M),.A_out(AA1),.Q_out(QQ1));

wire [7:0] AA2;
wire [7:0] QQ2;
non_restoring_division_stage stage2 (.A_in(AA1),.Q_in(QQ1),.M(M),.A_out(AA2),.Q_out(QQ2));

wire [7:0] AA3;
wire [7:0] QQ3;
non_restoring_division_stage stage3 (.A_in(AA2),.Q_in(QQ2),.M(M),.A_out(AA3),.Q_out(QQ3));

wire [7:0] AA4;
wire [7:0] QQ4; 
non_restoring_division_stage stage4 (.A_in(AA3),.Q_in(QQ3),.M(M),.A_out(AA4),.Q_out(QQ4));

wire [7:0] AA5;
wire [7:0] QQ5; 
non_restoring_division_stage stage5 (.A_in(AA4),.Q_in(QQ4),.M(M),.A_out(AA5),.Q_out(QQ5));

wire [7:0] AA6;
wire [7:0] QQ6;
non_restoring_division_stage stage6 (.A_in(AA5),.Q_in(QQ5),.M(M),.A_out(AA6),.Q_out(QQ6));

wire [7:0] AA7;
wire [7:0] QQ7;
non_restoring_division_stage stage7 (.A_in(AA6),.Q_in(QQ6),.M(M),.A_out(AA7),.Q_out(QQ7));



always @(AA7) begin
     quotient = QQ7;
    if (AA7[7]) begin
        remainder <= AA7 + M;
    end else begin
        remainder <= AA7;
    end
end
    
endmodule