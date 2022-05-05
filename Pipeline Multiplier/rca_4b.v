module rca_4b(
                   a,
                   b,
                   cin,
                   cout,
                   sum
                   );
  input [3:0]a, b;
  input cin;
  output [3:0]sum;
  output cout;
  wire [2:0]c;
  
  rca_1b 	r1(a[0], b[0], cin , c[0], sum[0]);
  rca_1b	r2(a[1], b[1], c[0], c[1], sum[1]);
  rca_1b	r3(a[2], b[2], c[1], c[2], sum[2]);
  rca_1b	r4(a[3], b[3], c[2], cout, sum[3]);
  
  
endmodule


module rca_1b(
                   a,
                   b,
                   cin,
                   cout,
                   sum
                   );

input a, b;
input cin;
output sum;
output cout;

assign sum = a ^ b ^ cin;
assign cout = a&b | b&cin | cin&a;
endmodule
