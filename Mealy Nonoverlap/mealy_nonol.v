module mealy_nonol(
                   in       ,                   //input
                   clk      ,                   //clock
                   reset    ,                   //reset
                   out                          //output
                   )        ;

//port declaration
input in, clk, reset                         ;  //input declaration
output reg out                               ;  //output declaration
parameter S0 = 0 , S1 = 1 , S2 = 2 , S3 = 3  ;  //parameter declaration for states
reg [1:0] present_state,next_state           ;  //register declaration for states

always @ (posedge clk or posedge reset)
   begin
      if(reset)
         present_state <= S0           ;        //if reset is true then go to state S0   
      else    
         present_state <= next_state   ;        //if reset is false then make next state as present state
   end             

always@(present_state or in)
   begin      
      case(present_state)    
         S0 : begin 
               next_state = in ? S1 : S0   ;    //next state will be S1 if input is 1 otherwise S2
               out = 0                     ;    //output is 0 till the desired sequence is acquired
              end
         S1 : begin 
               next_state = in ? S2 : S0   ;    //next state will be S1 if input is 1 otherwise S2
               out = 0                     ;    //output is 0 till the desired sequence is aquired
              end
         S2 : begin 
               next_state = in ? S2 : S3   ;    //next state will be S1 if input is 1 otherwise S2             
               out = 0                     ;    //output is 0 till the desired sequence is aquired
              end 
         S3 : begin 
               next_state = S0             ;    //next state is zero
               out = in ? 1 : 0            ;    //output is 1 when the desired sequence is aquired
              end
         default: next_state = S0          ;    //set default value as S0 state
      endcase
   end
endmodule                                       //end of mealy machine
