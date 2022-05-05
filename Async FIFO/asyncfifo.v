module asyncfifo(
                 write_clk                             ,//input write clock
                 read_clk                              ,//input read clock 
                 reset                                 ,//input reset
                 write_en                              ,//input write enable
                 read_en                               ,//input read enable
                 data_in                               ,//input data
                 mem_full                              ,//output memory full 
                 mem_empty                             ,//output memory empty
                 out                                    //output data
                 )                                     ;

//port declarations
input            write_clk, read_clk, reset, write_en, read_en ;//input
input      [7:0] data_in                                       ;//input
output           mem_full, mem_empty                           ;//output
output reg [7:0] out                                           ;//output

reg        [7:0] mem [0:7]                            ;//8 * 8 memory
reg        [2:0] write_ptr                            ;//write pointer
reg        [2:0] read_ptr                             ;//read pointer
reg        [3:0] count                                ;//count

//condition for mem_full and empty
assign mem_full  = (count == 8   )                    ;
assign mem_empty = (count == 4'b0)                    ;

/*Whenever the reset is 0 then make write pointer 0 otherwise if write enable
 * and memory is not full then write data into memory and increment write
 * pointer*/
always @ (posedge write_clk or negedge reset)
   begin
      if(!reset)
         begin
            write_ptr <= 3'b0                         ;//reset pointer
         end
      else
         begin
            if(write_en == 1 && !mem_full)
               begin
                  mem[write_ptr] <= data_in           ;//data is written 
                  write_ptr      <= write_ptr + 1'b1  ;//pointer increment
                  out            <= 8'bz              ;
               end
         end
    end

/*Whenever the reset is 0 then make read pointer 0 otherwise if read enable
 * and memory is not empty then read data from memory and increment read
 * pointer*/
always @ (posedge read_clk or negedge reset)
   begin
      if(!reset)
         begin
            read_ptr <= 3'b0                          ;//reset pointer
         end
      else
         begin
            if(read_en == 1 && !mem_empty)
               begin
                  out    <= mem[read_ptr]             ;//data is read 
                  read_ptr <= read_ptr + 1'b1         ;//pointer increment
               end
         end
    end

/*increment count for write enable 1 and decrement count for read enable 1*/
always @ (posedge write_clk or posedge read_clk or negedge reset)
   begin
      if(!reset)
         count <= 4'b0                                ;//reset counter
      else
         begin
            case({write_en,read_en})
               2'b10:  count <= count + 1'b1          ;//counter increment
               2'b01:  count <= count - 1'b1          ;//counter increment
               default:count <= count                 ;
            endcase 
         end
   end
endmodule                                              //end of async FIFO
