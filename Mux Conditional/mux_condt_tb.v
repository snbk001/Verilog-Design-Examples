module mux_condt_tb           ;
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
         stimulus();#5;
            if (new_out == out)
               $display("select[1] = %b, select[0] = %b, out = %b, new_out = %b, Testcase Passed", select[1], select[0], out, new_out) ;  //displaying inputs and outputs
            else
               $display("select[1] = %b, select[0] = %b, out = %b, new_out = %b, Testcase Failed", select[1], select[0], out, new_out) ;  //displaying inputs and outputs
      end
    $finish;
end
      
task stimulus     ;
   reg [1:0] Sl   ;
      
   begin
      Sl = $random   ;

      select = Sl    ;                 //mapping Sl to select
      begin
         case (select)
            0  :  new_out = in0 ;      
            1  :  new_out = in1 ;
            2  :  new_out = in2 ;
            3  :  new_out = in3 ;
  	      endcase
      end

   end
      
endtask
    
endmodule
