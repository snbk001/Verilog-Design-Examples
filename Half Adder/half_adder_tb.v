module half_adder_tb                                  ;//testbench module
   reg   a, b	                                       ;//register declaration for input signals a & b
   wire  sum, carry	                                 ;//wire declaration for nets
   reg   new_sum, new_carry                           ;//register declaration for verification of sum and carry

half_adder dut(
               .i_a     (a    )                       ,//input
               .i_b     (b    )                       ,//input
               .o_sum   (sum  )                       ,//output 
               .o_carry (carry)	                      //output
               )                                      ; 

initial begin 
   repeat(10)
      begin
         stimulus()                                   ;//instantiating task
         if (new_sum == sum && new_carry == carry)     //condition to check DUT outputs and calculated outputs from task are equal 
            $display("a = %b, b = %b, sum = %b, carry = %b, new_sum = %b, new_carry = %b, Test case Passed", a, b, sum, carry, new_sum, new_carry);                                                                            //displaying inputs, outputs and result

         else
            $display("a = %b, b = %b, sum = %b, carry = %b, new_sum = %b, new_carry = %b, Test case Failed", a, b, sum, carry, new_sum, new_carry);                                                                           //displaying inputs, outputs and result
      
      end
end
  
task stimulus                                         ;//task for inputs and sum & carry calculation
   reg A, B                                           ;//register declaration for inputs

   begin 
   A = $random                                        ;//random input
   B = $random                                        ;//random input
    
   a = A                                              ;//mapping input from task to register 
   b = B                                              ;//mapping input from task to register 
    
   {new_carry, new_sum} = A + B                       ;#5;//carry and sum by addition
   
   end
    
endtask     
  
endmodule                                             //end of half adder testbench
