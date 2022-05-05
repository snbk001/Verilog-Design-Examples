module syncfifo(
                clk                                                     ,//input clk
                reset                                                   ,//input reset
                write_en                                                ,//input write enable
                read_en                                                 ,//input read enable
                data_in                                                 ,//input data
                full                                                    ,//output if the memory is full 
                empty                                                   ,//output if the memory is empty
                out                                                      //output out
                )                                                       ;

//port declarations
input            clk,reset,write_en,read_en                             ;
input      [7:0] data_in                                                ;
output           full,empty                                             ;
output reg [7:0] out                                                    ;

//reg declarations
reg [7:0] memory_vec   [0:7]                                            ;//memory of 8 * 8 
reg [2:0] write_pointer                                                 ;//write pointer
reg [2:0] read_pointer                                                  ;//read pointer
reg [3:0] count                                                         ;

assign full  = (count == 8    )                                         ;//assign full to 8
assign empty = (count == 4'b0 )                                         ;

/*reset the write pointer to 0 if active low reset and when write enable is 1 & the stack is not full the carryout the write and increment pointer operation*/
always @ (posedge clk or negedge reset)
   begin
      if(!reset)
         begin
            write_pointer <= 3'b0                                       ;//reset write pointer
         end
      else
         begin
            if(write_en == 1 && !full)
               begin
                  memory_vec   [write_pointer] <=  data_in              ;//data is written to the pointer location
                  write_pointer                <=  write_pointer + 1'b1 ;//increment pointer
               end
         end
    end

/*reset the write pointer to 0 if active low reset and when write enable is 1 & the stack is not full the carryout the write and increment pointer operation*/
always @ (posedge clk or negedge reset)
   begin
      if(!reset)
         begin
            read_pointer <= 3'b0                                        ;//reset read pointer
         end
      else
         begin
            if(read_en == 1 && !empty)
               begin
                  out          <=  memory_vec[read_pointer]             ;//data is read from the pointer location
                  read_pointer <=  read_pointer + 1'b1                  ;//increment read pointer
               end
         end
    end

/*reset the count to 0 if active low reset. When write_en = 1 and read_en = 0 then count is incremented. write_en = 0 and read_en = 1 then count is decremented*/
  always @(posedge clk or negedge reset)
   begin
      if(!reset)
         count <= 4'b0                                                  ;//reset count
      else
         begin
            case({write_en,read_en})
               2'b10  :  count <=  count + 1'b1                         ;//increment count
               2'b01  :  count <=  count - 1'b1                         ;//decrement count
               default:  count <=  count                                ;//default
            endcase 
         end
   end
endmodule                                                                //end of synchronous FIFo
