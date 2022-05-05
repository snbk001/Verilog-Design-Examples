module asyncfifo_tb                                         ;//testbench module

reg        write_clk, read_clk, reset, write_en, read_en    ;//register declaration 
reg  [7:0] data_in                                          ;
wire       mem_full, mem_empty                              ;
wire [7:0] out                                              ;

//instantiation of design module
asyncfifo dut(
             .write_clk (write_clk)          ,//input write clock
             .read_clk  (read_clk )          ,//input read clock
             .reset     (reset    )          ,//input reset
             .write_en  (write_en )          ,//write enable
             .read_en   (read_en  )          ,//read enable 
             .data_in   (data_in  )          ,//data input
             .mem_full  (mem_full )          ,//memory full
             .mem_empty (mem_empty)          ,//memory empty 
             .out       (out      )           //output
            )                                ;

//generates clock for write operation 
initial begin
   write_clk            = 1'b0               ;
   forever #5 write_clk = ~write_clk         ;
end

//generates clock for read operation 
initial begin
   read_clk             = 1'b0               ;
   forever #10 read_clk = ~read_clk          ;
end

//calling the write and read operations
initial begin
   reset      = 1'b1                         ;
   write_en   = 1'b0                         ;
   read_en    = 1'b0                         ;
   data_in    = 8'b0                         ;#10;
   reset      = 1'b0                         ;#10;
   reset      = 1'b1                         ;
   
   write_task                                ;#20;//calling the task write
   read_task                                 ;#20;//calling the task read
   write_task;#20                            ;
   write_task                                ;
   #200 $finish                              ;//finish simulation
end

task write_task                              ;//task
   begin
      write_en    = 1'b1                     ;
      read_en     = 1'b0                     ;
      data_in     = $random                  ;#20;
      $display("write_en = %b , read_en = %b , data_in = %b , out = %b , mem_full = %b , mem_empty = %b",write_en,read_en,data_in,out,mem_full,mem_empty);//display statement
   end
endtask

task read_task                               ;//task
   begin
      write_en   = 1'b0                      ;
      read_en    = 1'b1                      ;#20;
      $display("write_en = %b , read_en = %b , data_in = %b , out = %b , mem_full = %b , mem_empty = %b",write_en,read_en,data_in,out,mem_full,mem_empty);//display statement
   end
endtask 

endmodule                                     //end of testbench
