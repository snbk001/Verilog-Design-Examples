module dff_sync (
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

assign o_qb = ~o_q      ;  //assigning qb to be complement of q

always @ (posedge clk)     //sensitivity list as positive edge of clock
   begin
      if (reset)           
         o_q <= 1'b0    ;  //if reset is 1 then assigning q to be 0
      else                 
         o_q <= i_d     ;  //else assign q to the input  
   end

endmodule                  //d flip-flop 
