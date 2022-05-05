module singleportram_tb;
  
reg clk, wr_en             ;  //declare clock and write/read enable as input
reg [2:0]addr              ;  //declare address lines
reg [127:0] data_in        ;  //declare 128 bit input data
wire [127:0] data_out      ;  //declare 128 bit output data
reg [127:0] ram_vector [7:0]  ;  //declare a register that hold memory
reg [127:0] new_out      ;

singleport_ram dut (
                    .data_in(data_in)   ,  //input
                    .wr_en(wr_en)       ,  //input
                    .addr(addr)         ,  //input
                    .clk(clk)           ,  //input
                    .data_out(data_out)    //output
                    )                   ;

initial begin
   clk = 0;
   forever #5 clk = ~clk;
end


initial begin
   repeat(10)
   stimulus;

   if (data_out == new_out)   
      #5 $display("data in = %d, write/read_en = %b, data out = %d, Pass", data_in, wr_en, data_out);
   else 
      #5 $display("data in = %d, write/read_en = %b, data out = %d, Fail", data_in, wr_en, data_out);
end

task stimulus;
   begin
      data_in = $random;
      addr = $random;
   end
endtask

initial begin 
   wr_en = 0;
   #15 wr_en = 1; 
#200 $finish;   
end

endmodule   //end of single port RAM
