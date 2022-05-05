module bin_gry_tb                                           ;//testbench module               

parameter  N = 8                                            ;//initializing parameter 
reg       [N-1:0] binary                                    ;//declaring binary input as regster
wire      [N-1:0] gray                                      ;//declaring output as wire
reg       [N-1:0] new_gray                                  ;//declaring output as gegister for self checking

//instantiation of design under test
bin_gry #(.N(8)) dut (
                     .binary  (binary  )                    ,//input
                     .gray    (gray    )                     //output
                     )                                      ;

initial begin
   repeat(10)
      begin
         stimulus                                           ;//call task
         if (new_gray == gray)                               //check if design output and testbench output are same
            $display("input binary = %b, output gray = %b, new output gray = %b, Testcase Pass", binary, gray, new_gray)   ;//dispaly for testcase Pass 
         else
            $display("input binary = %b, output gray = %b, new output gray = %b, Testcase Fail", binary, gray, new_gray)   ;//display for testcase Fail
      end
end

task stimulus;
   begin 
      binary            = $random                           ;//random input generation
      new_gray[N-1   ]  = binary[N-1  ]                     ;//test output
      new_gray[N-2:0 ]  = binary[N-1:1] ^ binary[N-2:0]  ;#5;//test output
   end
endtask

endmodule                                                    //end of testbench
