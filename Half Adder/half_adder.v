module half_adder(
	               i_a	                  ,//input
	               i_b	   	            ,//input 
               	o_sum	   	            ,//output
	               o_carry                  //output
                  )                       ;

//Port declaration

input  i_a	                              ;//input declaration
input  i_b	                              ;//input declaration
output o_sum	                           ;//output declaration
output o_carry	                           ;//output declaration
  
//sum and carry expression for half adder

assign o_sum   =  i_a ^ i_b               ;//xor operation
assign o_carry =  i_a & i_b               ;//and operation
  
endmodule 
