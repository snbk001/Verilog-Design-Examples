// Half Adder Testbench
module half_add_tb;
  reg a, b	;
  wire sum, carry	;
  reg n_sum, n_carry;

  half_add dut(.i_a(a),			//input
             .i_b(b),			//input
             .o_sum(sum),		//output 
             .o_carry(carry)	//output
            );

  initial begin 
//     a = $random;
//     b = $random;
    //$dumpfile
    repeat(10)
      begin
        
    stimulus();
    if (n_sum == sum && n_carry == carry)
      $display("a = %b, b = %b, sum = %b, carry = %b, n_sum = %b, n_carry = %b, Test case Passed", a, b, sum, carry, n_sum, n_carry);
    else
      $display("a = %b, b = %b, sum = %b, carry = %b, n_sum = %b, n_carry = %b, Test case Failed", a, b, sum, carry, n_sum, n_carry);
      
  end
  end
  
  task stimulus;
    reg A, B;
    begin
    A = $random;
    B = $random;
    
    a = A;
    b = B;
    
    {n_carry, n_sum} = A + B;#5;
    
    end
  endtask
      
  
endmodule