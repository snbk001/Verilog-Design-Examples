module mux_always_tb            ;
reg in0, in1     ;
reg select                 ;
wire out                   ; 
reg new_out               ;


mux_always dut(
               .out(out)         ,
               .in0(in0)         ,
               .in1(in1)         ,
               .select(select)
               )                 ;
  
  
initial begin

   in0 = $random;   //input initialization with random bits 
   in1 = $random;   //input initialization with random bits 

   repeat(100)
      begin
         stimulus();#5;
            if (new_out == out)
               $display("in0 = %b, in1 =%b, select = %b, out = %b, new_out = %b, Testcase Passed", in0, in1, select, out, new_out) ;  //displaying inputs and outputs
            else
               $display("in0 = %b, in1 =%b, select = %b, out = %b, new_out = %b, Testcase Failed", in0, in1, select, out, new_out) ;  //displaying inputs and outputs
      end
end
      
task stimulus        ;
   reg Sl            ;
      
   begin
      Sl = $random   ;

      select = Sl    ;                 //mapping Sl to select
      
      new_out = Sl ? in1 : in0 ;#5;    //verification for output

   end
      
endtask
    
endmodule
