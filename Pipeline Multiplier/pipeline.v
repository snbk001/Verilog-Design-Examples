`include "../src/rca64.v"
`include "../src/half_adder.v"

module pipeline(
                   x          ,//input
                   y          ,//input
                   clk        ,//clock
                   reset      ,//reset
                   prod        //product
                   );

//port declaration
input    [ 63:0]  x, y                                ;//input
input             clk, reset                          ;//clock and reset
output   [127:0]  prod                                ;//product
wire     [ 63:0]  pp1, pp2, pp3, pp4                  ;//paratial products
wire              s1, ca1                             ;//sum and carry for half addre
reg               tempc1, tempc2, tempc3, has, haca   ;//registers for sum and carry
wire     [ 63:0]  sum1, sum2 ,sum3                    ;//wires for sum
reg      [ 63:0]  xtemp, ytemp                        ;//register for inputs
reg      [ 63:0]  temp1, temp2, temp3, temp4          ;//registers for pp
reg      [ 63:0]  temps1, temps2, temps3              ;//registers for sum


always @ (posedge clk)
   begin
      if (reset)
         xtemp  <= 0 ;
         ytemp  <= 0 ;
         
   end

always @ (posedge clk)
   begin
      xtemp <= x  ;
      ytemp <= y  ;
   end

//instantiation of 32 bit multipliers
vdcmul_32b v321(
               xtemp[31: 0], 
               ytemp[31: 0], 
               pp1
               )           ;

vdcmul_32b v322(
               xtemp[31: 0], 
               ytemp[63:32], 
               pp2
               )           ;

vdcmul_32b v323(
               xtemp[63:32],
               ytemp[31: 0], 
               pp3
               )           ;

vdcmul_32b v324(
               xtemp[63:32], 
               ytemp[63:32], 
               pp4
               )           ;  

//assign pp to register
always @ (posedge clk)
   begin 
      temp1 <= pp1   ;
      temp2 <= pp2   ;
      temp3 <= pp3   ;
      temp4 <= pp4   ;
   end

//instantiation of 64bit RCA
rca64 r321(
           temp2  , 
           temp3  , 
           1'b0   ,   
           c1     , 
           sum1
           )      ;

//assign sum and carry to register
always @ (posedge clk)
   begin
      tempc1 <= c1   ;
      temps1 <= sum1 ;
   end

//instantiation of 64bit RCA
rca64 r322(
           sum1                  , 
           {32'b0, temp1[63:32]} , 
           1'b0                  , 
           c2                    , 
           sum2
           )                     ;

//assign sum and carry to register
always @ (posedge clk)
   begin
      tempc2 <= c2   ;
      temps2 <= sum2 ;
   end

//instantiation of half adder
half_adder  h1(
               tempc1   ,
               tempc2   ,
               s1       ,
               ca1
               )        ;

//assign sum and carry to register
always @ (posedge clk)
   begin
      has <= s1   ;
      haca <= ca1 ;
   end

//instantiation of 64bit RCA
rca64 r323(
           temp4                             , 
           {30'b0, haca, has, temps2[63:32]} , 
           1'b0                              , 
           c3                                ,    
           sum3
           )                                 ;

//assign sum and carry to register
always @ (posedge clk)
   begin
      temps3 <= sum3 ;
   end

//final product
assign prod = {temps3, temps2[31:0], temp1[31:0]};

endmodule
