module mux_always(
                in0      , //input 
                in1      , //input
                select   , //select line 
                out        //output
                )        ;

//port declaration

input in0, in1       ;
input select         ;
output out           ;


assign out = (~select & in0) | (select & in1)   ;  //logical expression

endmodule
