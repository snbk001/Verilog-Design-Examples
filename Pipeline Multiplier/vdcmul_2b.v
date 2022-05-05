module vdcmul_2b(
                   x,
                   y,
                   prod
                   );

input [1:0] x, y;
wire [2:0]s;
wire [2:1]c;
output [3:0] prod;

assign s[0] = x[0] & y [0];
assign {c[1], s[1]} = (x[1] & y[0]) + (x[0] & y[1]);
assign {c[2], s[2]} = c[1] + (x[1] & y[1]);
assign prod = {c[2], s[2], s[1], s[0]};

endmodule
