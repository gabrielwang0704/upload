module mac_16in_pipelined (
    input clk,
    input rst,
    input [pr*bw-1:0] a,
    input [pr*bw-1:0] b,
    output reg [bw_psum-1:0] out
);
parameter bw = 8;
parameter bw_psum = 2*bw+4;
parameter pr = 16;

// Wire for initial products
wire [2*bw-1:0] product[0:pr-1];
// Register for storing products in first pipeline stage
reg [2*bw+3:0] product_reg[0:pr-1];
integer j;

// Generate block for parallel multiplications
genvar i;
generate
    for (i = 0; i < pr; i++) begin
        assign product[i] = {{(bw){a[bw*(i+1)-1]}}, a[bw*(i+1)-1:bw*i]} * 
                           {{(bw){b[bw*(i+1)-1]}}, b[bw*(i+1)-1:bw*i]};
    end
endgenerate

// Pipeline stage 1: register all products with sign extension
always @(posedge clk or posedge rst) begin
    if (rst) begin
        for (j = 0; j < pr; j = j + 1) begin
            product_reg[j] <= 0;
        end
    end else begin
        for (j = 0; j < pr; j = j + 1) begin
            product_reg[j] <= {{(4){product[j][2*bw-1]}}, product[j]};
        end
    end
end

// Pipeline stage 2: perform summation
always @(posedge clk or posedge rst) begin
    if (rst) begin
        out <= 0;
    end else begin
        out <= product_reg[0] + product_reg[1] + product_reg[2] + product_reg[3] +
               product_reg[4] + product_reg[5] + product_reg[6] + product_reg[7] +
               product_reg[8] + product_reg[9] + product_reg[10] + product_reg[11] +
               product_reg[12] + product_reg[13] + product_reg[14] + product_reg[15];
    end
end
endmodule
