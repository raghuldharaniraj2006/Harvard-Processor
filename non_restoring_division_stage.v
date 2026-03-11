module non_restoring_division_stage (

    input wire [7:0] A_in,
    input wire [7:0] Q_in,
    input wire [7:0] M,
    output wire [7:0] A_out,
    output reg [7:0] Q_out

);
wire [7:0] A_1;
wire [7:0] Q_1;
reg [7:0] M_1;

assign {A_1[7:0], Q_1[7:0]} = {A_in[6:0], Q_in[7:0], 1'b0};
    always @(*) begin
        if (A_in[7] == 0) begin
            M_1[7:0] = ~M[7:0] + 1'b1; 
        end else begin
            M_1[7:0] = M[7:0];
        end
    end

assign A_out = M_1 + A_1;

    always @(*) begin
        if (A_out[7] == 0) begin
            Q_out[7:0] = {Q_1[7:1], 1'b1};
        end else begin
            Q_out[7:0] = {Q_1[7:1], 1'b0};
        end
    end


endmodule


