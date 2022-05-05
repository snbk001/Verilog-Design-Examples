module mux_case_tb            ;
reg [1:0]in0, in1, in2, in3   ;
reg [1:0]select               ;
wire [1:0]out                 ; 
reg [1:0] new_out             ;



mux_case dut(
            .out(out)         ,
            .in0(in0)         ,
            .in1(in1)         ,
            .in2(in2)         ,
            .in3(in3)         ,
            .select(select)
            )                 ;
  
  
initial begin

   in0 = 2'b00 ;
   in1 = 2'b01 ;
   in2 = 2'b10 ;
   in3 = 2'b11 ;

   repeat(100)
      begin
         stimulus();
            if (new_out == out)
               $display("select[1] = %b, select[0] = %b, out = %b, new_out = %b, Testcase Passed", select[1], select[0], out, new_out) ;  //displaying inputs and outputs
            else
               $display("select[1] = %b, select[0] = %b, out = %b, new_out = %b, Testcase Failed", select[1], select[0], out, new_out) ;  //displaying inputs and outputs
      end
end
      
task stimulus     ;
   reg [1:0] Sl   ;
      
   begin
      Sl = $random   ;

      select = Sl    ;      //mapping Sl to select
      
      new_out = Sl[1] ? (Sl[0] ? in3 : in2) : (Sl[0] ? in1 : in0);#5;   //verification for output

   end
      
endtask
    
endmodule
