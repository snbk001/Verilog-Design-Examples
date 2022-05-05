`include "../src/rca16b.v"

module rca32b(
               a,
               b,
               cin,
               cout,
               sum
               );
input [31:0]a, b;
input cin;
output [31:0]sum;
output cout;
wire cin4;

  rca16b   rc161(a[15:0], b[15:0], cin, cin4, sum[15:0]);
  rca16b   rc162(a[31:16], b[31:16], cin4, cout, sum[31:16]);

endmodule
