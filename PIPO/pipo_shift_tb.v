module pipo_shift_tb                         ;
   
reg   [15:0]   data_in                       ;
reg            load, clk, reset              ;
reg   [ 1:0]   shift_en                      ;
wire  [15:0]   data_out                      ;

pipo_shift dut(
              .data_in  (data_in )           ,
              .load     (load    )           ,
              .shift_en (shift_en)           ,
              .clk      (clk     )           ,
              .reset    (reset   )           ,
              .data_out (data_out)
               )                             ;

initial begin
   clk            = 0                        ;
   reset          = 1                        ;
   #15 reset      = 0                        ;
   forever #5 clk = ~clk                     ;
end
  
initial begin 
   data_in        = 16'b1000111000010110     ;
   load           = 0                        ;
   #20 load       = 1                        ;
   #25 shift_en   = 0                        ;
   #35 shift_en   = 1                        ;
   #45 shift_en   = 2                        ;
   #55 shift_en   = 3                        ;
#500 $finish                                 ;
end

endmodule
