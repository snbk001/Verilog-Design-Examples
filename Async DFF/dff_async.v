module dff_async (
                 i_d    ,  //input
                 clk    ,  //clock
                 reset  ,  //reset
                 o_q    ,  //output
                 o_qb      //output complement
                 )      ;

//port declaration
input i_d, clk, reset   ;
output o_q, o_qb        ; 
reg o_q                 ;

assign o_qb = ~o_q            ;              //assigning qb to be complement of q

always @ (posedge clk or posedge reset)      //sensitivity list as positive edge of clock or reset
   begin
      if (reset)                            //if reset is 1 then assigning q to be 0
         o_q <= 1'b0          ;
      else                                   //else assign q to the input
         o_q <= i_d           ;    
   end

endmodule                                    //end of d flip-flop 
