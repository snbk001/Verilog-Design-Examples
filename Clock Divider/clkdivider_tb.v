module clkdivider_tb                               ;//testbench module

reg         clk,reset                              ;//reg for clk , reset
wire        out_clk                                ;//wire for out_clk
reg         new_clk                                ;//reg for self checking output
reg [1:0]   clk_count                              ;//reg for count for self checking

//instantiation of design under test
clkdivider dut(
           .clk(clk)                               ,//input clock
           .reset(reset)                           ,//reset 
           .out_clk(out_clk)                        //output clock
            )                                      ; 
            
 initial begin
   new_clk     =  1'b0                             ;//set the self checking output to 0
   clk_count   =  2'b0                             ;//set q to 0
   end

 initial begin         
   clk      =  1'b0                                ;//initialize clock to 0             
   #1 reset =  1'b1                                ;//initialize reset to 1
   stimulus                                        ;//calling the task 
   #200 $finish                                    ;//stop execution
 end

 task stimulus;
   repeat(30)
      begin
         #3 clk      =  ~clk                       ; 
         #10 reset   =  1'b0                       ;//set the reset bit to 0
         verify(clk)                               ;//calling the task
      end
 endtask

 task verify ;
   input clk                                       ;//declaring input for check
   parameter  count  =  4                          ;//declaring count
   begin
      if (clk_count == count- 1) 
         begin
            new_clk     <=    ~new_clk             ;//at count 3 new_clk is inverted
            clk_count   <=    2'b0                 ;//set q to 0
         end
      else
         begin
            new_clk   <=   new_clk                 ;//otherwise it is kept same
            clk_count <=   clk_count + 1           ;//increment the by 1
        end

     if (new_clk  == out_clk)
         $display("reset=%b  clk=%b  clk_out=%b and new_clk=%b  : Testcase Pass ",reset,clk,out_clk,new_clk)   ;//dispaly Pass Testcase
     else
         $display("reset=%b  clk=%b  clk_out=%b and new_clk=%b  : Testcase Fail ",reset,clk,out_clk,new_clk)   ;//diaplay Fail Testcase
   end
endtask

endmodule                                           //end of testbench
