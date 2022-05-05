module mealy_nonol_tb                                ;

reg         in                                       ;     //register declration for input
reg         clk                                      ;     //register declration for clock
reg         reset                                    ;     //register declration for reset
wire        out                                      ;     //wire declration for output
parameter   S0 = 0 , S1 = 1 , S2 = 2 , S3 = 3        ;     //parameter declaration for states
reg         new_out                                  ;     //register declaration for test output
reg         [1:0] ps, ns                             ;     //register declaration for present state and next state

// Instantiation of the design under test

mealy_nonol dut (
                .in     (in   )           ,                //input
                .clk    (clk  )           ,                //clock
                .reset  (reset)           ,                //reset
                .out    (out  )                            //output
                )                         ;
    
initial begin
   clk            =  0                    ;                //initialize clock to 0
   reset          =  1                    ;                //initialize reset to 1
   #20 reset      =  0                    ;                //change reset value after 20ns
   forever #5 clk =  ~clk                 ;                //clock with 5ns rising edge and 5ns falling edge
end 

initial begin
   repeat(20)
      begin
         stimulus                         ;               //calling task
         if (out == new_out)                              //check if design output and testbench output are same
            begin
               $display("input = %b, output = %b, new out = %b, Testcase Pass", in, out, new_out)  ;   //display for Testcase pass
               if (out == 1 && new_out == 1)
                  $display("Sequence 1101 is detected")                                            ;   //display for sequence detected
           end
         else
            $display("input = %b, output = %b, new out = %b, Testcase Fail", in, out, new_out)     ;   //display for Testcase Fail
      end
   $finish;
end
  
task stimulus                             ;              //task for input generation
  begin
    in = $random;@(posedge clk)           ;              //input generation
  end
endtask

/*State S0 is assigned to present state if the reset is 1 else the next state is assigned to present state*/
always @ (posedge clk or posedge reset)
   begin
      if(reset)
         ps <= S0                         ;             //S0 assigned to present state if reset is 1  
      else    
         ps <= ns                         ;             //next state is assigned to present state if reset is 0
   end

/*Here the states S0, S1, S2, or S4 is assigned according to the input encountered (for the sequence 1101)*/
always @ (ps or in)
   begin      
      case(ps)    
         S0 : begin
                 if (in)
             	     ns        =  S1      ;              //next state is S1 if input is 1
           		  else
             		  ns        =  S0      ;              //next state is S0 if input is 0
           		  new_out      =  0       ;              //test output is 0 when sequence not detected
              end
         S1 : begin 
              	  if (in)
             		  ns        =  S2      ;              //next state is S1 if input is 1
           		  else
             		  ns        =  S0      ;              //next state is S0 if input is 0
           		  new_out      =  0       ;              //test output is 0 when sequence not detected
              end
         S2 : begin 
              	  if (in)
                    ns        =  S2      ;              //next state is S1 if input is 1
           	 	  else
             		  ns        =  S3      ;              //next state is S0 if input is 0
           		  new_out      =  0       ;              //test output is 0 when sequence not detected
              end 
         S3 : begin  
           	  	  ns           =  S0      ;              //go back to S0
                 if (in)
             	     new_out   =  1       ;              //test output is 1 when sequence detected
           		  else
             		  new_out   =  0       ;              //test output is 0 when sequence not detected
              end
      endcase
   end
         
endmodule                                               //end of mealy machine
