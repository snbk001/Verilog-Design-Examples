module syncfifo_tb                  ;

reg  clk,reset,write_en,read_en                ;
reg  [7:0]data_in                    ;
wire full,empty                   ;
wire [7:0]out                     ;

//instantiation of design under test
syncfifo dut(
             .clk  (clk  )          ,
             .reset  (reset  )          ,
             .write_en   (write_en   )          ,
             .read_en   (read_en   )          , 
             .data_in (data_in )          ,
             .full (full )          ,
             .empty(empty)          , 
             .out  (out  )
            )                       ;

//clock generation 
initial begin
   clk = 1'b0                       ;
   forever #5 clk = ~clk            ;
end

initial begin
    reset  = 1'b1                     ;
    write_en   = 1'b0                     ;
    read_en   = 1'b0                     ;
    data_in = 8'b0                     ;
    #10 reset  = 1'b0                     ;
    #10 reset  = 1'b1                     ;
    write                           ;//calling the task write
    #20 read                            ;//calling the task read
    #200 $finish                    ;//finish simulation
  end

task write                        ;
   begin
      write_en   = 1'b1                   ;
      read_en   = 1'b0                   ;
      data_in = $random                ;
   end
endtask

task read                         ;
   begin
      write_en = 1'b0                     ;
      read_en = 1'b1                     ;
   end
endtask 

endmodule  //end of testbench
