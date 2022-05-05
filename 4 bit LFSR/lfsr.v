module lfsr(
            reset,
            clk,
            data_out
            );

input reset, clk;
wire next_bit;
output reg [3:0]data_out;

assign next_bit = data_out[1] ^ data_out[0];

always @ (posedge clk)
   begin
      if (reset || data_out == 0)
         data_out <= 1;
      else
         data_out <= {next_bit, data_out[3:1]};
   end
endmodule
