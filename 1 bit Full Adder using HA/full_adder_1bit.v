module full_adder_1bit(
                      i_a     ,  //input 
                      i_b     ,  //input 
                      i_cin   ,  //input 
                      o_sum   ,  //output 
                      o_carry    //output 
                      )       ;

//Port declaration

input i_a ,i_b ,i_cin ;    
output o_sum ,o_carry ;

//sum and carry expression for full adder  
assign o_sum   = i_a ^ i_b ^ i_cin                             ;//xor operation

assign o_carry = (i_a & i_b) | (i_b & i_cin) | (i_cin & i_a)   ;
  
endmodule
