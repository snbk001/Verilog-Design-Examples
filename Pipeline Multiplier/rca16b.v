`include "../src/rca8b.v"

module rca16b(
               a,
               b,
               cin,
               cout,
               sum
               );
input [15:0]a, b;
input cin;
output [15:0]sum;
output cout;
wire cin4;

  rca8b   rc81(a[7:0], b[7:0], cin, cin4, sum[7:0]);
  rca8b   rc82(a[15:8], b[15:8], cin4, cout, sum[15:8]);

endmodule
