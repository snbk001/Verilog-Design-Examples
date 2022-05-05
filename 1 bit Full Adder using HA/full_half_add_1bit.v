module full_half_add_1bit(
                          i_a     ,  //input 
                          i_b     ,  //input 
                          i_cin   ,  //input 
                          o_sum   ,  //output 
                          o_carry    //output 
                          )       ;

//Port declaration

input  i_a, i_b, i_cin            ;    
output o_sum, o_carry             ;
wire   w_sum1, w_carry1, w_carry2 ;

half_adder h1(                       //half adder instantiation
              .h_a(i_a)           ,   
              .h_b(i_b)           ,
              .h_sum(w_sum1)      ,	
              .h_carry(w_carry1)    
              )                   ;
half_adder h2(                       //half adder instantiation
              .h_a(w_sum1)        ,
              .h_b(i_cin)         ,
              .h_sum(o_sum)       ,	
              .h_carry(w_carry2)
              )                   ;

assign o_carry = w_carry1 | w_carry2;
  
endmodule // full adder


// module declaration for half adder
module half_adder(
	               h_a	   ,	//input
	               h_b	   ,	//input 
               	h_sum	   ,	//output
	               h_carry     //output
                  )        ;

//Port declaration

input  h_a	   ;
input  h_b	   ;
output h_sum	;
output h_carry	;
  
//sum and carry expression for half adder

assign h_sum   =  h_a ^ h_b;	//xor operation
assign h_carry =  h_a & h_b;	//and operation
  
endmodule // half adder
