module mealy_ol_tb                                    ;//testbench module

reg            in                                     ;//input
reg            clk                                    ;//clock
reg            reset                                  ;//reset
wire           out                                    ;//output
parameter      S0 = 0 , S1 = 1 , S2 = 2 , S3 = 3      ;//parameters
reg            new_out                                ;//testbench output
reg      [1:0] ps, ns                                 ;//testbench present and next state

// Instantiation of the design under test
mealy_ol dut (
             .in(in)                                  ,//input
             .clk(clk)                                ,//clock
             .reset(reset)                            ,//reset
             .out(out)                                 //output
              )                                       ;
    
initial begin
   clk            = 0                                 ;//clock initialization
   reset          = 1                                 ;//reset initialized to 1
   #20 reset      = 0                                 ;//reset to 0
   forever #5 clk = ~clk                              ;//toggle clock for every 5ns
end
  
initial begin
   repeat(20)
      begin
         stimulus                                     ;//call task
         if (out == new_out)                           //check if design output and testbench output are same
            begin
               $display("input = %b, output = %b, new out = %b, Testcase Pass", in, out, new_out)  ;//display for Testcase pass
               if (out == 1 && new_out == 1)
                  $display("Sequence 1101 is detected")                                            ;//display for sequence detected
            end
         else
            $display("input = %b, output = %b, new out = %b, Testcase Fail", in, out, new_out)     ;//display for Testcase pass
      end
$finish                                               ;//stop execution
end
  
task stimulus                                         ;//task
  begin
    in = $random;@(posedge clk)                       ;//generation of input
  end
endtask

/*State S0 is assigned to present state if the reset is 1 else the next state is assigned to present state*/
always@(posedge clk or posedge reset)
   begin
      if(reset)
         ps <= S0                                     ;//ps is S0 for reset = 1    
      else    
         ps <= ns                                     ;//ps is ns for reset = 0
   end

/*Here the states S0, S1, S2, or S3 is assigned according to the input encountered (for the sequence 1101)*/
always@(ps or in)
   begin      
      case(ps)    
         S0 : begin 
               new_out  = 0                           ;//test output is 0 when sequence not detected
               ns       = in ? S1 : S0                ;//ns is S1 if in is 1 else ns is S0
              end
         S1 : begin 
               new_out  = 0                           ;//test output is 0 when sequence not detected
               ns       = in ? S2 : S0                ;//ns is S2 if in is 1 else ns is S0
              end
         S2 : begin 
               new_out  = 0                           ;//test output is 0 when sequence not detected
               ns       = in ? S2 : S3                ;//ns is S2 if in is 1 else ns is S0             
              end 
         S3 : begin 
               new_out  = in ?  1 : 0                 ;//test output is 1 when sequence is detected
               ns       = in ? S1 : S0                ;//ns is S1 if in is 1 else ns is S0
              end
         default: ns    = S0                          ;//default
      endcase
   end

         
endmodule                                              //end of mealy machine testbench
