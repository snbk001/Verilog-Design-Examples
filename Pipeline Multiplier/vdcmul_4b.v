`include "../src/vdcmul_2b.v"
`include "../src/rca_4b.v"

module vdcmul_4b(
                   x,
                   y,
                   prod
                   );

input [3:0] x, y;


output [7:0] prod;
wire [3:0] pp1, pp2, pp3, pp4;
wire c1, c2, c3,s1,ca1;
wire [3:0] sum1, sum2 ,sum3;

vdcmul_2b v1(x[1:0], y[1:0], pp1);
vdcmul_2b v2(x[1:0], y[3:2], pp2);
vdcmul_2b v3(x[3:2], y[1:0], pp3);
vdcmul_2b v4(x[3:2], y[3:2], pp4);

rca_4b r1(pp2, pp3, 1'b0, c1, sum1);
rca_4b r2(sum1, {2'b00, pp1[3:2]}, 1'b0, c2, sum2);
half_adder h1(c1,c2,s1,ca1);
rca_4b r3(pp4, {ca1, s1, sum2[3:2]}, 1'b0, c3, sum3);

assign prod = {sum3, sum2[1:0],pp1[1:0]};

endmodule
module half_adder(a,b,sum,carry);
input a,b;
output sum , carry;

assign sum=a^b;
assign carry=a&b;

endmodule
