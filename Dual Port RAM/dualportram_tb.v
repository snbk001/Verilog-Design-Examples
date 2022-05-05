module dualportram_tb;

reg            clk                                 ;//declare clock as register
reg            wr_en_a, wr_en_b                    ;//declare write/read enable
reg   [  2:0]  addr_a, addr_b                      ;//declare address lines
reg   [127:0]  data_in_a, data_in_b                ;//declare 128 bit input data
wire  [127:0]  data_out_a, data_out_b              ;//declare 128 bit output data
reg   [127:0]  ram_vector [7:0]                    ;//declare a register that hold memory
reg   [  2:0]  out_a, out_b                        ;//declare testbench output


//instantiation of design under test
dualport_ram dut(
                  .data_in_a  (data_in_a  )        ,//input
                  .wr_en_a    (wr_en_a    )        ,//input
                  .addr_a     (addr_a     )        ,//input
                  .data_in_b  (data_in_b  )        ,//input
                  .wr_en_b    (wr_en_b    )        ,//input
                  .addr_b     (addr_b     )        ,//input
                  .clk        (clk        )        ,//input
                  .data_out_a (data_out_a )        ,//output
                  .data_out_b (data_out_b )         //output
                   )                               ;

//clock generation
initial begin
   clk            =    0;
   forever #5 clk = ~clk;
end

initial begin
   repeat(1)
      begin
         stimulus                                  ;//call task 
         if((out_a == data_out_a) && (out_b == data_out_b))
            $display("addr_a =%b,addr_b =%b,data_in_a =%b,data_in_b =%b,dataout_a =%b,dout_b =%b: Testcase Passed",addr_a,addr_b,data_in_a,data_in_b,data_out_a,data_out_b); //display pass Testcase
         else
            $display("addr_a =%b,addr_b =%b,data_in_a =%b,data_in_b =%b,dataout_a =%b,dout_b =%b: Testcase Failed",addr_a,addr_b,data_in_a,data_in_b,data_out_a,data_out_b); //display fail Testcase
      end
   #200 $finish                                    ;
end


task stimulus                                      ;//task
      begin
         addr_a = $random                          ;//random values for addr_a
         data_in_a  = $random                      ;//random values for data_in_a

         addr_b = $random                          ;//random values for addr_b
         data_in_b  = $random                      ;//random values for data_in_b

         wr_en_a   = 1                             ;// write enable
         wr_en_b   = 1                             ;#5;// write enable

         wr_en_a   = 0                             ;//read enable
         wr_en_b   = 0                             ;#5;//read enable

         if(wr_en_a)
            ram_vector[addr_a]   = data_in_a             ;//write data to vector
         else
            out_a                = ram_vector[addr_a]    ;//read data from vector

         if(wr_en_b )
            ram_vector[addr_b]   = data_in_b             ;//write data to vector
         else
            out_b                = ram_vector[addr_b]    ;//read data from vector
     
         if(addr_a == addr_b)
            out_a = data_in_b                            ;
            out_b = data_in_b                            ;
      end
 endtask 

endmodule                                                //end of module dpram_tb
