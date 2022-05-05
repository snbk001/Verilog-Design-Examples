module counter4bit_tb ;

reg reset, load, enable, clk;
wire [3:0]count_out;
wire [3:0]count;
reg [3:0] new_count;
parameter S0 = 8, S1 = 7, S2 = 11, S3 = 4, S4 = 9, S5 = 2, S6 = 5, S7 = 12, S8 = 6, S9 = 3, S10 = 15, S11 = 1, S12= 14, S13 = 13;

counter4bit dut(
               .reset(reset),
               .load(load),
               .enable(enable),
               .clk(clk),
               .count_out(count_out),
               .count(count)
                );

initial begin
   clk = 0;
   forever #5 clk = ~clk;
   reset = 1;
   enable =0;
   #20 reset =0;
   
end

always @ (posedge clk)
   begin
      if (reset)
         new_count <= 0;
      else
         begin
            if (S0)
               new_count <= S1;
            else if (S1)
               new_count <= S2;
            else if (S2)
               new_count <= S3;
            else if (S3)
               new_count <= S4;
            else if (S4)
               new_count <= S5;
            else if (S5)
               new_count <= S6;
            else if (S6)
               new_count <= S7;
            else if (S7)
               new_count <= S8;
            else if (S8)
               new_count <= S9;
            else if (S9)
               new_count <= S10;
            else if (S10)
               new_count <= S11;
            else if (S11)
               new_count <= S12;
            else if (S12)
               new_count <= S13;
         end    

       if(new_count == count_out)
         $display("Pass");
       else
         $display("Fail");
   end

//task stimulus;


initial begin
   reset = 1; load = 0; enable = 0;
   #20 reset = 0; load = 1; enable = 1;
   #5 load = 0; 
   #5 enable = 0;
   #10 load = 1;
   #10 enable = 1;
     
#200 $finish;
end

endmodule
