`include "../src/rca16b.v"
`include "../src/half_adder.v"

module vdcmul_16b(
                   x,
                   y,
                   prod
                   );

input [15:0] x, y;


output [31:0] prod;
wire [15:0] pp1, pp2, pp3, pp4;
wire c1, c2, c3,s1,ca1;
wire [15:0] sum1, sum2 ,sum3;

vdcmul_8b v81(x[7:0], y[7:0], pp1);
vdcmul_8b v82(x[7:0], y[15:8], pp2);
vdcmul_8b v83(x[15:8], y[7:0], pp3);
vdcmul_8b v84(x[15:8], y[15:8], pp4);

rca16b r161(pp2, pp3, 1'b0, c1, sum1);
rca16b r162(sum1, {8'b0, pp1[15:8]}, 1'b0, c2, sum2);
half_adder h1(c1,c2,s1,ca1);
rca16b r163(pp4, {6'b0, ca1,s1, sum2[15:8]}, 1'b0, c3, sum3);

assign prod = {sum3, sum2[7:0], pp1[7:0]};

endmodule
