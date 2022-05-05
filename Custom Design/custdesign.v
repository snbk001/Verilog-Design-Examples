module custdesign(
                  x,
                  clk,
                  reset,
                  y
                  );

input x, clk, reset;
output y;
wire a, abar, b, bbar, r2, s2;

srff sr1(.s(b),
         .r(bbar),
         .clk(clk),
         .reset(reset),
         .q(a),
         .qbar(abar)
         );

assign r2 = a ^ x ;
assign s2 = ~r2   ;

srff sr2(.s(s2),
         .r(r2),
         .clk(clk),
         .reset(reset),
         .q(b),
         .qbar(bbar)
         );
assign y = r2 ^ b ;

endmodule

module srff(
            s,
            r,
            clk,
            reset,
            q,
            qbar
            );
            
input s, r, clk, reset;
output reg q, qbar;

always @ (posedge clk)
   begin 
      if (reset)
         q  <= 1'b0;
      else
         q  <= s | (~r & q);
         qbar <= ~q;
   end
endmodule
