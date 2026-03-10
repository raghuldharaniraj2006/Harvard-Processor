module decode_unit(
    input [31:0] instruction,
    input [7:0] rf_data_rsrc1, 
    input [7:0] rf_data_rsrc2, 
    output reg [7:0] A,       
    output reg [7:0] B         
);

    
    wire [5:0] opcode = instruction[31:26];

     
    always @(*) begin
       
        A = 8'h00;
        B = 8'h00;

        if (opcode == 6'b000100)
         begin      // ADD Rdst1, Rsrc2, Rsrc1 
            A = rf_data_rsrc2;
            B = rf_data_rsrc1;
        end 
        
        else if (opcode == 6'b000101) 
        begin // SUB Rdst1, Rsrc2, Rsrc1 
            A = rf_data_rsrc2;
            B = rf_data_rsrc1;
        end
        
         else if (opcode == 6'b000110) 
         begin // NEG Rdst1, Rsrc1 
            A = rf_data_rsrc1;
            B = 8'h00;
        end 
        
        else if (opcode == 6'b000111) 
        begin // MUL Rdst2, Rdst1, Rsrc2, Rsrc1 
            A = rf_data_rsrc2;
            B = rf_data_rsrc1;
        end 
        
        else if (opcode == 6'b001000) 
        begin // DIV Rdst1, Rsrc2, Rsrc1 
            A = rf_data_rsrc2;
            B = rf_data_rsrc1;
        end 
        
        else if (opcode == 6'b001001) begin // OR Rdst1, Rsrc2, Rsrc1 
            A = rf_data_rsrc2;
            B = rf_data_rsrc1;
        end
        
        else if (opcode == 6'b001010)
          begin // XOR Rdst1, Rsrc2, Rsrc1 
            A = rf_data_rsrc2;
            B = rf_data_rsrc1;
        end
        
        else if (opcode == 6'b001011) 
        begin // NAND Rdst1, Rsrc2, Rsrc1 
            A = rf_data_rsrc2;
            B = rf_data_rsrc1;
        end 
        
        else if (opcode == 6'b001100) 
        begin // NOR Rdst1, Rsrc2, Rsrc1 
            A = rf_data_rsrc2;
            B = rf_data_rsrc1;
        end 
        
        else if (opcode == 6'b001101) 
        begin // XNOR Rdst1, Rsrc2, Rsrc1 
            A = rf_data_rsrc2;
            B = rf_data_rsrc1;
        end 
        
        else if (opcode == 6'b001110) 
        begin // NOT Rdst1, Rsrc1 
            A = rf_data_rsrc1;
            B = 8'h00;
        end 
        
        else if (opcode == 6'b001111) 
        begin // LLSH Rdst1, Rsrc2, Rsrc1 
            A = rf_data_rsrc2;
            B = rf_data_rsrc1;
        end 
        
        else if (opcode == 6'b010000) 
        begin // LRSH Rdst1, Rsrc2, Rsrc1 
            A = rf_data_rsrc2;
            B = rf_data_rsrc1;
        end
    end
endmodule