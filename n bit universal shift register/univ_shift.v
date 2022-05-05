module univ_shift
                 #(parameter n = 16)

                 (
                  data_in  ,
                  control  ,
                  clk      ,
                  reset    ,
                  data_out
                  )        ;

input [n-1:0] data_in      ;
input clk, reset           ;
input [1:0] control        ;
output reg [n-1:0] data_out;
parameter hold = 0, shift_left = 1, shift_right = 2, siso = 3;

always @ (posedge clk or negedge reset)
   begin
      if (reset)
         data_out <= 0;
      else
         begin
            case(control)
               hold        : data_out <= data_out      ;
               shift_left  : data_out <= data_in << 1  ;
               shift_right : data_out <= data_in >> 1  ;
               siso        : data_out <= data_in       ;
               default     : data_out <= data_out      ;
            endcase
         end
   end

endmodule
