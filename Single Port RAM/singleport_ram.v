module singleport_ram(
                      data_in ,  //input
                      wr_en   ,  //input
                      addr    ,  //input
                      clk     ,  //input
                      data_out   //output
                      )       ;

input clk, wr_en           ;  //declare clock and write/read enable as input
input [2:0]addr            ;  //declare address lines
input [127:0] data_in      ;  //declare 128 bit input data
output [127:0] data_out    ;  //declare 128 bit output data
reg [127:0] ram_vector [7:0]  ;  //declare a register that hold memory
reg [2:0] read_addr        ;  //declare temp read address

//execute always block at the positive edge of clock cycle
always @ (posedge clk)
   begin
      if (wr_en)
         ram_vector[addr] <= data_in      ;  //write the data into ram vector when write/read enable is 1
      
      read_addr <= addr                ;  //update read address
   end
assign data_out = ram_vector[read_addr]   ;  //read the data from ram vector

endmodule   //end of single port RAM
