module cntr_3ud_tb                                                ;//testbench module

reg         up_down, clk, reset                                   ;//register declaration 
wire  [2:0] bin_count                                             ;//wire declaration for output
reg   [2:0] new_count                                             ;//register declaration for new count value

//instantiation of design under test
cntr_3ud dut (
             .up_down   (up_down    )                             ,//count control
             .clk       (clk        )                             ,//clock
             .reset     (reset      )                             ,//reset
             .bin_count (bin_count  )                              //output
              )                                                   ;

initial begin
   clk = 0                                                        ;//clock initialization
   forever #5 clk = ~clk                                          ;//toggling clock for every 5ns    
end

initial begin
   reset = 1                                                      ;#25;//reset to 1
   reset = 0                                                      ;//reset to 0
#200 $finish                                                      ;//finish execution with 200ns delay 
end

always @ (posedge clk)
   begin
      stimulus                                                    ;//call the task
      if (reset)
         new_count <= 3'b0                                        ;//reset the count
      else
         new_count <= up_down ? new_count - 1 : new_count + 1     ;#10;//new count value with updown control
      
      /*check for design output and test output from task are same*/
      if (new_count == bin_count)      
         $display("reset = %b, up_down = %b, bin_count = %b, new_count = %b Testcase Passed", reset, up_down, bin_count, new_count);//dispalay for testcase Pass
      else
         $display("reset = %b, up_down = %b, bin_count = %b, new_count = %b Testcase Failed", reset, up_down, bin_count, new_count);//display for testcase Fail
       
   end

task stimulus;
      up_down = $random                                           ;//randomizing control signal
endtask

endmodule
