`ifndef TB_ALU
`define TB_ALU

`include "alu_interface.sv"
`include "alu_top.sv"

module tb_alu;

  // Ports Definition
  // Clk Generation    

  bit clk;

  initial begin  clk = 0;  end 

  always #5 clk = ~clk; 

  // interface
  alu_interface alu_interface_ins (clk);

  // top program
  alu_top alu_top_in (alu_interface_ins);    

  // DUT Instantiation
  ALU ALU_b1_ins (
    .A		(alu_interface_ins.A		),
    .B		(alu_interface_ins.B		),
    .Op		(alu_interface_ins.Op		),
    .Result	(alu_interface_ins.Result	),
    .reset	(alu_interface_ins.reset	),
    .clk	(alu_interface_ins.clk		)
  );

  initial begin #1000; $finish; end
  
  initial begin $dumpfile("dump.vcd"); $dumpvars; end
  
endmodule
`endif