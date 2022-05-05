module lfsr_tb;

reg reset, clk;
wire [3:0]data_out;
reg [3:0]new_out;
wire new_bit;


lfsr dut (
         .reset(reset),
         .clk(clk),
         .data_out(data_out)
         );

initial begin
   clk = 0;
   forever #5 clk = ~clk;
end

initial begin
   reset = 1;
   #20 reset = 0;
   #400 $finish;
end

assign new_bit = new_out[1] ^ new_out[0];

always @ (posedge clk)
   begin
      if(reset)
         new_out = 1;
      else
         new_out <= {new_bit, new_out[3:1]};

      if (new_out == data_out)
         $display("new out = %b, data out = %b, Testcase Pass", new_out, data_out);
      else 
         $display("new out = %b, data out = %b, Testcase Fail", new_out, data_out);
   end

endmodule
