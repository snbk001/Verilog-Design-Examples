module dff_sync_tb         ;
reg d, clk, reset          ;     //register declaration for d, clock and reset
wire q, qb                 ;     //wire declaration for q and qbar

dff_sync dut (
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

         if (~reset)                               //for reset equal to 1 condition
            begin
            if (d == q)                            //check if random input d and output from DUT are equal
               $display("d = %b, q = %b, qb = %b, Testcase Passed", d, q, qb);
                                                   //display for passed testcases
            else
               $display("d = %b, q = %b, qb = %b, Testcase Failed", d, q, qb);
                                                   //display for failed testcases
            end

      end
      $finish;
end
         task stimulus;
            begin
               d = $random; reset = $random;#5;    //randomly generating input and reset for DUT
            end
         endtask

endmodule                                          //end of d flip-flop testbench
