module dff_async_tb        ;
reg d, clk, reset          ;     //register declaration for d, clock and reset
wire q, qb                 ;     //wire declaration for q and qbar

dff_async dut (
              .i_d(d)      ,     //input
              .clk(clk)    ,     //clock
              .reset(reset),     //reset
              .o_q(q)      ,     //output
              .o_qb(qb)          //output complement
              )            ;

initial begin
   clk = 1'b0              ;
   forever #1 clk = ~clk   ;     //for every 1 time units clock will toggle
end

initial begin
   repeat(100)
      begin
         stimulus();
            if (q == d || reset == 1)                 //check for randomly generated input                                                                                and output from DUT are equal or not
               $display("d = %b, q = %b, qb = %b, reset = %b, Testcase Passed", d, q, qb, reset); 
                                                      //display for passed testcases                
            else
               $display("d = %b, q = %b, qb = %b, reset = %b, Testcase Failed", d, q, qb, reset);
                                                      //display for failed testcases
               end
   $finish;
end
         task stimulus;
            begin
               d = $random; reset = $random;#5;       //randomly generating input for DUT
            end
         endtask

endmodule                                             //end of d flip-flop testbench
