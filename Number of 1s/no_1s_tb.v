module no_1s_tb                           ;//testbench module 

reg [15:0] a                              ;//register declaration for a              
wire [3:0] no_ones                        ;//wire declaration for no. of 1s
reg [3:0] new_no                          ;//register declaration for test output no. of 1s
integer i                                 ;//integer declaration
reg clk, reset                            ;//clock and reset declaration

no_1s dut(
         .i_a     (a       )              ,//input
         .clk     (clk     )              ,//clock
         .reset   (reset   )              ,//reset
         .no_ones (no_ones )               //output        
         )                                ;

initial begin
   clk            =  0                    ;//clock initialized to 0
   forever #5 clk =  ~clk                 ;//clock with 5ns rising edge and 5ns falling edge
end

initial begin
  reset     =  1                          ;//reset initialized to 1
  #20 reset =  0                          ;//reset initialized to 0
#200 $finish                              ;//finish the execution with 200ns delay
end

initial begin
   stimulus()                                                                             ;//calling task
   if (new_no == no_ones)
      $display("a = %b, no_ones = %b, new_no = %b, Testcase Passed", a, no_ones, new_no)  ;//display for output Pass

   else
      $display("a = %b, no_ones = %b, new_no = %b, Testcase Failed", a, no_ones, new_no)  ;//dispaly for output Fail

end

task stimulus                             ;//task
   begin
      new_no = 0                          ;//initialize no. of 1s to 0
      a = $random                         ;//input generation
      for (i = 0; i < 16; i = i + 1)
         begin
            if (a[i] == 1)
               new_no = new_no + 1; #10   ;//increment the no. of 1 counter of testbench
         end
   end
endtask

endmodule                                  //end of testbench 
