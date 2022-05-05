module pipo_shift(
                  data_in                                                  ,//input
                  load                                                     ,//input to load data
                  shift_en                                                 ,//input to shift
                  clk                                                      ,//clock
                  reset                                                    ,//reset
                  data_out                                                  //output
                  )                                                        ;

//port declaration
input       [15:0] data_in                                                 ;//input 16 bit data
input              load, clk, reset                                        ;//inputs
input       [1:0 ] shift_en                                                ;//2 bit shift enable
output reg  [15:0] data_out                                                ;//16 bit output
reg         [15:0] temp_data                                               ;//16 bit temporary register to store data

/*Here the data is loaded and then the left, right, arithmatic left, arithmatic right shift is done*/
always @ (posedge clk)
   begin
      if (reset)
         data_out <= 0                                                     ;//output data 0 if reset
      else
         begin
            if (load)
               begin 
                  temp_data <= data_in                                     ;//load data to temporary register
                  case(shift_en)
                     0 : data_out <=  temp_data <<  1                      ;//shift left
                     1 : data_out <=  temp_data >>  1                      ;//shift right
                     2 : data_out <=  temp_data <<< 1                      ;//arithmatic left shift
                     3 : data_out <= {temp_data[15], temp_data[14:0] >> 1} ;//arithmatic right shift
                  endcase
               end
         end
   end

endmodule                                                                   //end of pipo
