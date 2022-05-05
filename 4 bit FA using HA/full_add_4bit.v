module full_add_4bit(
                     i_a     ,  //input 
                     i_b     ,  //input 
                     i_cin   ,  //input 
                     o_sum   ,  //output 
                     o_carry    //output 
                     )       ;

//Port declaration

input  [3:0]i_a, i_b                ;     
input  i_cin                        ;    
output [3:0]o_sum                   ;                         
output o_carry                      ;
wire   w_carry1, w_carry2, w_carry3 ;

full_half_add_1bit fa1(
                      .i_a(i_a[0])       ,
                      .i_b(i_b[0])       ,
                      .i_cin(i_cin)      ,
                      .o_sum(o_sum[0])   ,
                      .o_carry(w_carry1)
                      )                  ,
                   fa2(
                      .i_a(i_a[1])       ,
                      .i_b(i_b[1])       ,
                      .i_cin(w_carry1)   ,
                      .o_sum(o_sum[1])   ,
                      .o_carry(w_carry2)
                      )                  ,
                   fa3(
                      .i_a(i_a[2])       ,
                      .i_b(i_b[2])       ,
                      .i_cin(w_carry2)   ,
                      .o_sum(o_sum[2])   ,
                      .o_carry(w_carry3)
                      )                  ,
                   fa4(
                      .i_a(i_a[3])       ,
                      .i_b(i_b[3])       ,
                      .i_cin(w_carry3)  ,
                      .o_sum(o_sum[3])   ,
                      .o_carry(o_carry)
                      )                  ;

endmodule // 4 bit full adder


// module declaration for full adder

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
