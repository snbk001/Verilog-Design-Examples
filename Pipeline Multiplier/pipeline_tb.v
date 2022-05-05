module pipeline_tb         ;//testbench module

reg  [ 63:0]   x, y        ;//input
reg            clk, reset  ;//clock and reset
wire [127:0]   prod        ;//product

//instantiation of pipeline multiplier
pipeline dut (
              x      ,
              y      ,
              clk    ,
              reset  ,
              prod
              )      ;

//clock generation
initial begin 
   clk =1'b0            ;
   forever #5 clk =~clk ;
end

//reset initialization
initial begin
   reset = 1'b1      ;
   #10 reset = 1'b0  ;
end

//input generation
initial begin 
   repeat(5)
      begin
         x = 64'd10231                                      ;
         y = 64'd11231;@(posedge clk)                       ;
         $display("x = %d, y =%d, product = %d", x, y, prod);
         $display("actual prod = %d", (x * y))              ;
      end
  #100 $finish                                              ;
end

endmodule
