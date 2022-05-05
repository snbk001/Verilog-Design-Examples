module mux_case(
                in0      , //input 
                in1      , //input
                in2      , //input
                in3      , //input
                select   , //select line
                out        //output
                )        ;

//port declaration

input [1:0]in0, in1, in2, in3  ;
input [1:0]select              ;
output reg [1:0]out            ;

always @ (select)                //execution of begin-end block whenever the value of select changes
   begin
      case (select)
         0  :  out = in0 ;       //for select = 00, output = in0   
         1  :  out = in1 ;       //for select = 01, output = in1 
         2  :  out = in2 ;       //for select = 10, output = in2 
         3  :  out = in3 ;       //for select = 11, output = in3 
  	   endcase
   end
  
endmodule // Mux 
