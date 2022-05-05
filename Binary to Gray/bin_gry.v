module bin_gry #(parameter N = 8)                   //parameter declaration
               (
               binary                              ,//input
               gray                                 //output
               )                                   ;

//port declaration
input       [N-1:0] binary                         ;//input declaration
output reg  [N-1:0] gray                           ;//output declaration

/*implement binary to gray conversion*/
always @ (binary)
   begin
      gray[N-1  ] = binary[N-1  ]                  ;//first bit is same as binary code
      gray[N-2:0] = binary[N-1:1] ^ binary[N-2:0]  ;//xor the first bit with 2nd bit and so on
   end

endmodule
