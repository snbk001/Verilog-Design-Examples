`include "../src/rca32b.v"
`include "../src/half_adder.v"

module vdcmul_32b(
                   x,
                   y,
                   prod
                   );

input [31:0] x, y;


output [63:0] prod;
wire [31:0] pp1, pp2, pp3, pp4;
wire c1, c2, c3,s1,ca1;
wire [31:0] sum1, sum2 ,sum3;

vdcmul_16b v161(x[15:0], y[15:0], pp1);
vdcmul_16b v162(x[15:0], y[31:16], pp2);
vdcmul_16b v163(x[31:16], y[15:0], pp3);
vdcmul_16b v164(x[31:16], y[31:16], pp4);

rca32b r321(pp2, pp3, 1'b0, c1, sum1);
rca32b r322(sum1, {16'b0, pp1[31:16]}, 1'b0, c2, sum2);
half_adder h1(c1,c2,s1,ca1);
rca32b r323(pp4, {14'b0, ca1,s1, sum2[31:16]}, 1'b0, c3, sum3);

assign prod = {sum3, sum2[15:0], pp1[15:0]};

endmodule
