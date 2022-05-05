module cntr_3ud(
                up_down                      ,//count control
                clk                          ,//clock
                reset                        ,//reset
                bin_count                     //output
                )                            ;

//port declaration
input             up_down, clk, reset        ;//count control, clock, reset declaration
output reg  [2:0] bin_count                  ;//output declaration

/*implement the counter when reset is 0, then execute up count if up_down is 0 else execute down count*/
always @ (posedge clk)                        //clock in the sensitivity list
   begin
      if (reset)                              //check for reset
         bin_count <= 0                      ;//count value will be 0 if reset is 1
      else
         begin
            if (up_down)                      //check for up count or down count
               bin_count <= bin_count - 1    ;//down count
            else
               bin_count <= bin_count + 1    ;//up count
         end
   end

endmodule                                     //end of counter
