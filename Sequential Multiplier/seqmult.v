module seqmult(
               in_a                                                     ,//input
               in_b                                                     ,//input
               clk                                                      ,//clock
               load                                                     ,//load
               reset                                                    ,//reset
               out_valid                                                ,//output valid signal
               out_prod                                                  //output product
               )                                                        ; 

//port declaration
input       [ 7:0]   in_a                                               ;//8 bit multiplicand declaration
input       [ 7:0]   in_b                                               ;//8 bitmultiplier declaration
input                clk                                                ;//clock declaration
input                load                                               ;//load declaration
input                reset                                              ;//reset declaration
output reg           out_valid                                          ;//output valid signal declaration
output reg  [15:0]   out_prod                                           ;//16 bit output product declaration
reg         [15:0]   p1, p2, p3, p4, p5, p6, p7, p8                     ;//partial products(pp)
wire        [15:0]   temp_prod                                          ;//temparory product for shift operation

assign temp_prod = {8'b0, in_b}                                         ;//make multiplier 16 bit so that shift operation becomes easier

/*this block is used to perform shift operation according to the each bit if 
 * it is 0 or 1 to get the partial products and then partial products are
 * added to get final product */
always @ (posedge clk or posedge reset)
   begin
      if (reset)
         begin
            out_prod    <= 16'bz                                        ;//no output
            out_valid   <= 1'b0                                         ;//invalid output
         end
      else
         begin
            if (load)
               begin
                  if (in_a[0])
                     p1 <= temp_prod                                    ;//p1 without shift
                  else
                     p1 <= 8'b0                                         ;
                  if (in_a[1])
                     p2 <= temp_prod << 1                               ;//p2 leftshift 1 time
                  else
                     p2 <= 8'b0                                         ;
                  if (in_a[2])
                     p3 <= temp_prod << 2                               ;//p3 leftshift 2 times
                  else
                     p3 <= 8'b0                                         ;
                  if (in_a[3])
                     p4 <= temp_prod << 3                               ;//p4 leftshift 3 times
                  else
                     p4 <= 8'b0                                         ;
                  if (in_a[4])
                     p5 <= temp_prod << 4                               ;//p5 leftshift 4 times
                  else
                     p5 <= 8'b0                                         ;
                  if (in_a[5])
                     p6 <= temp_prod << 5                               ;//p6 leftshift 5 times
                  else
                     p6 <= 8'b0                                         ;
                  if (in_a[6])
                     p7 <= temp_prod << 6                               ;//p7 leftshift 6 times
                  else
                     p7 <= 8'b0                                         ;
                  if (in_a[7])
                     p8 <= temp_prod << 7                               ;//p8 leftshift 7 times
                  else
                     p8 <= 8'b0                                         ;
                  out_prod    <=  p1 + p2 + p3 + p4 + p5 + p6 + p7 + p8 ;//partial product addition
                  out_valid   <=  1'b1                                  ;
               end
         end
   end
endmodule
