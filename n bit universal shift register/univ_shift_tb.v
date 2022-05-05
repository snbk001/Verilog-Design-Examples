module univ_shift_tb;

parameter n = 4;
reg [n-1:0] data_in;
reg clk, reset;
reg [1:0] control;
wire [n-1:0] data_out;
reg [n-1:0] new_out;


univ_shift #(.n(4)) dut (
              .data_in(data_in),
              .control(control),
              .clk(clk),
              .reset(reset),
              .data_out(data_out)
               );

initial begin
   clk = 0;
   forever #5 clk = ~clk;
end

initial begin
  data_in = 1101;
  reset = 1;
  #15 reset = 0; 
end

initial begin
#200 $finish;
end

always @ (posedge clk or negedge reset)
   begin
      stimulus;
      if (reset)
         new_out <= 0;
      else
         begin
            if (control == 0)
               new_out <= new_out;
            else if (control == 1)
               new_out <= {data_in[n-2:0], data_in[0] == 0};
            else if (control == 2)
               new_out <= {data_in[n-1] == 0, data_in[n-1:1]};
            else if (control == 3)
               new_out <= data_in;
         end
      
      if (new_out == data_out)
         $display("data out = %b, new out = %b, control = %b, Testcase Passed", data_out, new_out, control);
      else
         $display("data out = %b, new out = %b, control = %b, Testcase Failed", data_out, new_out, control);
  
   end

task stimulus;
      control = $random;
endtask

endmodule
