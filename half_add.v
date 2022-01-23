//Half adder 

module half_add
	(
	i_a		,	//input
	i_b		,	//input 
	o_sum	,	//output
	o_carry		//output
    );	
	
input  i_a		;
input  i_b		;
output o_sum	;
output o_carry	;
  
//sum and carry expression for half adder

assign o_sum   =  i_a ^ i_b	;	//xor operation
assign o_carry =  i_a & i_b	;	//and operation
  
endmodule