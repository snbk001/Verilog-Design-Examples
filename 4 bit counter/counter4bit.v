module counter4bit(
                   reset,
                   load,
                   enable,
                   clk,
                   count_out,
                   count
                   );

input reset, load, enable, clk;
output reg [3:0]count_out;
output reg [3:0]count;
parameter S0 = 8, S1 = 7, S2 = 11, S3 = 4, S4 = 9, S5 = 2, S6 = 5, S7 = 12, S8 = 6, S9 = 3, S10 = 15, S11 = 1, S12= 14, S13 = 13;

always @ (posedge clk or posedge reset)
   begin
      if (reset)
         count_out <= S0;
      else
         count_out <= count;
   end

always @ (posedge clk)
   begin
      if (load && enable)
         begin
            case(count_out)
               S0       :  count <= S1 ;
               S1       :  count <= S2 ;
               S2       :  count <= S3 ;
               S3       :  count <= S4 ;
               S4       :  count <= S5 ;
               S5       :  count <= S6 ;
               S6       :  count <= S7 ;
               S7       :  count <= S8 ;
               S8       :  count <= S9 ;
               S9       :  count <= S10;
               S10      :  count <= S11;
               S11      :  count <= S12;
               S12      :  count <= S13;
               S13      :  count <= S0 ;
               default  :  count <= S0 ; 
            endcase
         end
      else if (load == 0)
         count <= S0;
      else if (enable == 0)
         count_out <= count;
   end            

endmodule
