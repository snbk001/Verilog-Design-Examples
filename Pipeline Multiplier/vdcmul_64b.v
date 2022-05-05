`include "../src/rca64.v"
`include "../src/half_adder.v"

module vdcmul_64b(
                   x,
                   y,
                   prod
                   );

input [63:0] x, y;


output [127:0] prod;
wire [63:0] pp1, pp2, pp3, pp4;
wire c1, c2, c3,s1,ca1;
wire [63:0] sum1, sum2 ,sum3;

vdcmul_32b v321(x[31:0], y[31:0], pp1);
vdcmul_32b v322(x[31:0], y[63:32], pp2);
vdcmul_32b v323(x[63:32], y[31:0], pp3);
vdcmul_32b v324(x[63:32], y[63:32], pp4);

rca64       r321(pp2, pp3, 1'b0, c1, sum1);
rca64       r322(sum1, {32'b0, pp1[63:32]}, 1'b0, c2, sum2);
half_adder  h1(c1,c2,s1,ca1);
rca64      r323(pp4, {30'b0, ca1,s1, sum2[63:32]}, 1'b0, c3, sum3);

assign prod = {sum3, sum2[31:0], pp1[31:0]};

endmodule
