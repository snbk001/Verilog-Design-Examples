module seqmult_tb;

//port declaration
reg   [ 7:0]   in_a                                               ;//8 bit multiplicand declaration
reg   [ 7:0]   in_b                                               ;//8 bitmultiplier declaration
reg            clk                                                ;//clock declaration
reg            load                                               ;//load declaration
reg            reset                                              ;//reset declaration
reg   [15:0]   new_out                                            ;//register for testbench output
reg            new_valid                                          ;//register for testbench valid signal
wire           out_valid                                          ;//wire for valid signal declaration
wire  [15:0]   out_prod                                           ;//16 bit output product declaration

//instantiation of the design under the test
seqmult dut(
            .in_a       (in_a       )                             ,//input
            .in_b       (in_b       )                             ,//input
            .clk        (clk        )                             ,//clock
            .load       (load       )                             ,//load
            .reset      (reset      )                             ,//reset
            .out_valid  (out_valid  )                             ,//output valid signal
            .out_prod   (out_prod   )                              //output product
             )                                                    ; 


initial begin
   clk            = 1'b0                                          ;//clock initialization
   forever #5 clk = ~clk                                          ;//toggling clock
end

initial begin
   reset       = 1                                                ;//initialize reset
   load        = 1                                                ;//load to 1 
   #20 reset   = 0                                                ;//reset to 0
   #200 $finish                                                   ;//end execution with delay
end
initial begin
   stimulus;#40                                                   ;//call task
   if (out_prod == new_out)
      $display("input a = %d, input b = %d, design output = %d, testbench output = %d, Testcase Pass", in_a, in_b, out_prod, new_out);//display for pass testcase
   else
      $display("input a = %d, input b = %d, design output = %d, testbench output = %d, Testcase Fail", in_a, in_b, out_prod, new_out);//display for fail testcase
end

task stimulus;
   begin
      in_a = $random                                              ;//random input generation
      in_b = $random                                              ;//random input generation
   end
endtask

/*this block is used to perform direct multiplication for self check*/
always @ (posedge clk or posedge reset)
   begin
      if (reset)
         begin
            new_out    <= 16'bz                                   ;//no output
            new_valid  <= 1'b0                                    ;//invalid output
         end
      else
         begin
            if (load)
               new_out     <= in_a * in_b                         ;
               new_valid   <=  1'b1                               ;//valid signal to 1
         end
   end
endmodule                                                          //end of testbench
