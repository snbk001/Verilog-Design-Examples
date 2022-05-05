`include "../src/rca32b.v"

module rca64(
               a,
               b,
               cin,
               cout,
               sum
               );
input [63:0]a, b;
input cin;
output [63:0]sum;
output cout;
wire cin4;

rca32b   rc321(a[31:0], b[31:0], cin, cin4, sum[31:0]);
rca32b   rc322(a[63:32], b[63:32], cin4, cout, sum[63:32]);

endmodule
