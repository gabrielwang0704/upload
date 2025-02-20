// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module mac_col (clk, reset, out, q_in, q_out, i_inst,  o_inst);

parameter bw = 8;
parameter bw_psum = 2*bw+4;
parameter pr = 16;
parameter col_id = 0;

output reg signed [bw_psum-1:0] out;
input  signed [pr*bw-1:0] q_in;
output signed [pr*bw-1:0] q_out;
input  clk, reset;
input  [1:0] i_inst; // [1]: execute, [0]: load 
output [1:0] o_inst;  
reg    load_ready_q;
reg    [1:0] inst_q;
reg   signed [pr*bw-1:0] query_q;
reg   signed [pr*bw-1:0] key_q;
wire  signed [bw_psum-1:0] psum;

assign o_inst = inst_q;
assign q_out  = query_q;

mac_16in  mac_16in_instance (
        .a(query_q), 
        .b(key_q),
	.out(psum)
); 

always @ (posedge clk) begin
  if (reset) begin
    load_ready_q <= 1;
    inst_q <= 0;
  end
  else begin
    out <= psum;
    inst_q <= i_inst;
    if (inst_q[0]) begin
         query_q <= q_in;
         key_q <= q_in;
         load_ready_q <= 0;
    end
    else if(inst_q[1]) begin
      query_q <= q_in;
    end
  end
end

endmodule
