

module non_rest_div (clk,rst,start,divident,divisor,quotient,remainder,done);
input clk,rst,start;
input [7:0] divident,divisor;
output reg done;
output reg  [7:0] quotient,remainder;



reg [3:0] iter_count;

reg [2:0]state;
localparam  IDLE = 3'b000;
localparam  LOAD = 3'b001;
localparam  SHIFT = 3'b010;
localparam  ADD_SUB = 3'b011;
localparam  CONTINUE = 3'b100;
localparam  FEEDBACK = 3'b101;
localparam  DONE = 3'b110;



reg  [8:0] acc;
reg  [8:0] temp_acc;
reg  [8:0] next_acc;


reg [7:0] q;
reg [7:0] temp_q;
reg [7:0] next_q;

wire [8:0] m;
wire [8:0] minus_m;
assign m = {1'b0,divisor};
assign minus_m = ( ~(m) + 1'b1 );

always @ (posedge clk or posedge rst)
begin
    if(rst)begin
        iter_count <= 0;
        acc <= 0;
        temp_acc <= 0;
        next_acc <= 0;
        q <= 0;
        temp_q <= 0;
        next_q <= 0;
        done <= 0;
        state <= IDLE;
       remainder <= 0;
       quotient <= 0;
    end
    else

    begin
        case(state)

        IDLE :begin
                 done <= 0;
                 
                 if(start) state <= LOAD; 

              end

        LOAD : begin
            if (divisor == 0) begin
                quotient  <= 8'hFF;
                remainder <= divident;
                done      <= 1'b1;
                state     <= DONE;
            end
            else
            begin

                  acc <= 9'b0;
                  q <= divident;
                  
                  iter_count <= 4'd8;
                  temp_acc <= 9'b0;
                  temp_q <= 8'b0;
                  next_acc <= 9'b0;
                  next_q <= 8'b0;
                  state <= SHIFT;
            end

               end

        SHIFT : begin

            temp_acc <= {acc[7:0], q[7]};
            temp_q   <= {q[6:0], 1'b0};
            state <=  ADD_SUB;

        end
        ADD_SUB : begin

            if (temp_acc[8] == 1)
                begin
                    next_acc <= temp_acc + m;

                end
                else
                begin
                     next_acc <= temp_acc + minus_m;
                end
                 state <= CONTINUE;
              end
             
        CONTINUE : begin
                next_q <= temp_q;            
                next_q[0] <= ~next_acc[8];     
                state <= FEEDBACK;
                
                end


        FEEDBACK :begin
                acc <= next_acc;
                q <= next_q;

                if (iter_count ==1) state <= DONE;
                else begin
                    iter_count <= iter_count - 1'b1 ;
                    state <= SHIFT;
                end
                

                   end

        DONE:begin

               if (acc[8]) remainder <= acc[7:0] + m;
            else
                begin
                    remainder <= acc[7:0];
                end

                

                quotient <= q;
                done <= 1'b1;
                if (!start) begin
                    done  <= 1'b0;
                    state <= IDLE;
                 end
            
                        
            end

            default: state <= IDLE;
        endcase
    
    
    
    end



end

endmodule