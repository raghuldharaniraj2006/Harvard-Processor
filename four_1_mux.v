 module four_1_mux(i1,i2,i3,i4,sel,y);
    
    input [1:0] i1,i2,i3,i4,sel;
    output reg [1:0]y;
    always @(i1 or i2 or i3 or i4 or sel)
    begin
         case(sel)
            2'b00 : y=2'b00;
            2'b01 : y=i2;
            2'b10 : y=i3;
            2'b11 : y=2'b11;
         endcase
    end
endmodule


