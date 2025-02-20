// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 

`timescale 1ns/1ps

module mac_col_tb;

parameter total_cycle = 8;   // how many streamed Q vectors will be processed
parameter bw = 8;            // Q & K vector bit precision
parameter bw_psum = 2*bw+4;  // partial sum bit precision
parameter pr = 16;           // how many products added in each dot product 

integer qk_file ; // file handler
integer qk_scan_file ; // file handler


integer  captured_data;
`define NULL 0




integer  K[pr-1:0];
integer  Q[total_cycle-1:0][pr-1:0];
integer  result[total_cycle-1:0];

integer i,j,k,t,p,q,s,u, m;



reg reset = 1;
reg clk = 0;
reg [pr*bw-1:0] q_in; 
reg [1:0] inst = 0; 
wire [1:0] o_inst; 

wire [bw_psum-1:0] out;
reg [bw_psum-1:0] temp5b;
reg [bw_psum+3:0] temp_sum;
reg [bw_psum-1:0] temp16b;


mac_col #(.bw(bw), .bw_psum(bw_psum), .pr(pr)) mac_col_instance (
      .reset(reset),
      .clk(clk), 
      .q_in(q_in), 
      .out(out),
      .i_inst(inst),
      .o_inst(o_inst)
);


initial begin 

  $dumpfile("mac_col_tb.vcd");
  $dumpvars(0,mac_col_tb);



///// Q data txt reading /////

$display("##### Q data txt reading #####");


  qk_file = $fopen("qdata.txt", "r");

  //// To get rid of first 3 lines in data file ////
  qk_scan_file = $fscanf(qk_file, "%s\n", captured_data);
  qk_scan_file = $fscanf(qk_file, "%s\n", captured_data);
  qk_scan_file = $fscanf(qk_file, "%s\n", captured_data);
  qk_scan_file = $fscanf(qk_file, "%s\n", captured_data);


  for (q=0; q<total_cycle; q=q+1) begin
    for (j=0; j<pr; j=j+1) begin
          qk_scan_file = $fscanf(qk_file, "%d\n", captured_data);
          Q[q][j] = captured_data;
          //$display("%d\n", K[q][j]);
    end
  end
/////////////////////////////////



  for (q=0; q<2; q=q+1) begin
    #0.5 clk = 1'b0;   
    #0.5 clk = 1'b1;   
  end



///// K data txt reading /////

$display("##### K data txt reading #####");

  for (q=0; q<10; q=q+1) begin
    #0.5 clk = 1'b0;   
    #0.5 clk = 1'b1;   
  end
  reset = 0;

  qk_file = $fopen("kdata.txt", "r");

  //// To get rid of first 1 lines in data file ////
  qk_scan_file = $fscanf(qk_file, "%s\n", captured_data);



    for (j=0; j<pr; j=j+1) begin
          qk_scan_file = $fscanf(qk_file, "%d\n", captured_data);
          K[j] = captured_data;
          //$display("##### %d\n", K[j]);
    end
/////////////////////////////////








/////////////// Estimated result printing /////////////////


$display("##### Estimated multiplication result #####");

  for (t=0; t<total_cycle; t=t+1) begin
     result[t] = 0;
  end

  for (t=0; t<total_cycle; t=t+1) begin
         for (k=0; k<pr; k=k+1) begin
            result[t] = result[t] + Q[t][k] * K[k];
         end

         temp5b = result[t];

     //$display("%d %d %d %d %d %d %d %d", result[t][0], result[t][1], result[t][2], result[t][3], result[t][4], result[t][5], result[t][6], result[t][7]);
     $display("prd @cycle%2d: %5h", t, temp5b);
  end

//////////////////////////////////////////////




///// Kdata loading  /////

$display("##### Kdata loading #####");


    #0.5 clk = 1'b0;  
    inst[0] = 1;  
    
    q_in[1*bw-1:0*bw] = K[0];
    q_in[2*bw-1:1*bw] = K[1];
    q_in[3*bw-1:2*bw] = K[2];
    q_in[4*bw-1:3*bw] = K[3];
    q_in[5*bw-1:4*bw] = K[4];
    q_in[6*bw-1:5*bw] = K[5];
    q_in[7*bw-1:6*bw] = K[6];
    q_in[8*bw-1:7*bw] = K[7];
    q_in[9*bw-1:8*bw] = K[8];
    q_in[10*bw-1:9*bw] = K[9];
    q_in[11*bw-1:10*bw] = K[10];
    q_in[12*bw-1:11*bw] = K[11];
    q_in[13*bw-1:12*bw] = K[12];
    q_in[14*bw-1:13*bw] = K[13];
    q_in[15*bw-1:14*bw] = K[14];
    q_in[16*bw-1:15*bw] = K[15];

    #0.5 clk = 1'b1;  
    #0.5 clk = 1'b0;  
    inst[0] = 0;  
    #0.5 clk = 1'b1;  
///////////////////////////////////////////



  for (q=0; q<2; q=q+1) begin
    #0.5 clk = 1'b0;  
    #0.5 clk = 1'b1;   
  end





$display("##### Qmem writing  #####");


  #0.5 clk = 1'b0;   
  inst[1] = 1;
  #0.5 clk = 1'b1;   

  for (q=0; q<total_cycle+2; q=q+1) begin

    #0.5 clk = 1'b0;  
    
    q_in[1*bw-1:0*bw] = Q[q][0];
    q_in[2*bw-1:1*bw] = Q[q][1];
    q_in[3*bw-1:2*bw] = Q[q][2];
    q_in[4*bw-1:3*bw] = Q[q][3];
    q_in[5*bw-1:4*bw] = Q[q][4];
    q_in[6*bw-1:5*bw] = Q[q][5];
    q_in[7*bw-1:6*bw] = Q[q][6];
    q_in[8*bw-1:7*bw] = Q[q][7];
    q_in[9*bw-1:8*bw] = Q[q][8];
    q_in[10*bw-1:9*bw] = Q[q][9];
    q_in[11*bw-1:10*bw] = Q[q][10];
    q_in[12*bw-1:11*bw] = Q[q][11];
    q_in[13*bw-1:12*bw] = Q[q][12];
    q_in[14*bw-1:13*bw] = Q[q][13];
    q_in[15*bw-1:14*bw] = Q[q][14];
    q_in[16*bw-1:15*bw] = Q[q][15];

    #0.5 clk = 1'b1;  

    if (q == total_cycle+1)
       inst[1] = 0;
  
    if (q>1)
      $display("Simulated results @ %1d-th cycle %x", q-2, out);

  end

  #0.5 clk = 1'b0;  
  #0.5 clk = 1'b1;  
///////////////////////////////////////////






  #10 $finish;


end

endmodule




