//`include "../src/rca_4b.v"
module rca8b(
               a,
               b,
               cin,
               cout,
               sum
               );
input [7:0]a, b;
input cin;
output [7:0]sum;
output cout;
wire cin4;

rca_4b rc41(a[3:0], b[3:0],  cin, cin4, sum[3:0]);
rca_4b rc42(a[7:4], b[7:4], cin4, cout, sum[7:4]);

endmodule
