module full_half_add_1bit_tb  ;
   reg a, b, cin              ;  //register declaration for input signals a & b
   wire sum, carry	         ;  //wire declaration for nets
   reg new_sum, new_carry     ;  //register declaration for verification of sum and carry

full_half_add_1bit dut(
                       .i_a(a)           ,		//input
                       .i_b(b)           ,		//input
                       .i_cin(cin)       ,      //input
                       .o_sum(sum)       ,		//output 
                       .o_carry(carry)	         //output
                       );

initial begin 
   repeat(100)
      begin
         stimulus();                                //instantiating task
         if (new_sum == sum && new_carry == carry)  //condition to check DUT outputs and calculated 
                                                    //outputs from task are equal 
            $display("a = %b, b = %b, cin = %b, sum = %b, carry = %b, new_sum = %b, new_carry = %b, Test case Passed", a, b, cin, sum, carry, new_sum, new_carry);      //displaying inputs, outputs and result

         else
            $display("a = %b, b = %b, cin = %b, sum = %b, carry = %b, new_sum = %b, new_carry = %b, Test case Failed", a, b, cin, sum, carry, new_sum, new_carry);      //displaying inputs, outputs and result
      
      end
      $finish;
end
  
task stimulus     ;    //task for inputs and sum & carry calculation
   reg A, B, Cin  ;    //register declaration for inputs

   begin 
   A   = $random;   //random input
   B   = $random;   //random input
   Cin = $random;   //random input

    
   a   = A;         //mapping input from task to register 
   b   = B;         //mapping input from task to register 
   cin = Cin;         //mapping input from task to register 
    
   {new_carry, new_sum} = A + B + Cin;#5; //carry and sum by addition
   
   end
    
endtask     
  
endmodule         //full adder testbench
