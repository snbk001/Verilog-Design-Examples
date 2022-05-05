module clkdivider(
                  reset                   ,//input
                  clk                     ,//input
                  out_clk                  //output
                  )                       ;
//port declaration
input             reset, clk              ;//input declaration 
output reg        out_clk                 ;//output declaration
reg         [1:0] clk_count               ;//register for count

/*Here the clock count is incremented for every positive edge and the out clock is taken as msb of clock count that will be equal to 2 times period of original clock*/
always @ (posedge clk)
   begin
      if (reset)
         begin
            clk_count <= 0                ;//reset clk count
            out_clk   <= 0                ;//reset output
         end
      else
         begin
            clk_count <= clk_count + 1    ;//clock count is incremented
            out_clk   <= clk_count[1]     ;
         end
   end
endmodule                                  //end of clock divider
