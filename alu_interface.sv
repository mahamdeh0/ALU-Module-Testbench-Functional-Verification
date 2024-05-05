`ifndef	ALU_INTERFACE
`define	ALU_INTERFACE

interface alu_interface(input logic clk);

  logic 			reset ;
  logic 	[3:0] 	A     ;
  logic 	[3:0] 	B     ;
  logic 	[1:0] 	Op    ;
  logic 	[7:0] 	Result;
  
endinterface
`endif