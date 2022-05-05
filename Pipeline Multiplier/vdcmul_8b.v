`include "../src/vdcmul_4b.v"
`include "../src/rca8b.v"
`include "../src/half_adder.v"

module vdcmul_8b(
                   x,
                   y,
                   prod
                   );

input [7:0] x, y;


output [15:0] prod;
wire [7:0] pp1, pp2, pp3, pp4;
wire c1, c2, c3 ,s1,ca1;
wire [7:0] sum1, sum2 ,sum3;

vdcmul_4b v41(x[3:0], y[3:0], pp1);
vdcmul_4b v42(x[3:0], y[7:4], pp2);
vdcmul_4b v43(x[7:4], y[3:0], pp3);
vdcmul_4b v44(x[7:4], y[7:4], pp4);

rca8b r81(pp2, pp3, 1'b0, c1, sum1);
rca8b r82(sum1, {4'b0, pp1[7:4]}, 1'b0, c2, sum2);
half_adder h1(c1,c2,s1,ca1);
rca8b r83(pp4, {2'b0,ca1,s1 , sum2[7:4]}, 1'b0, c3, sum3);

assign prod = {sum3, sum2[3:0], pp1[3:0]};

endmodule
