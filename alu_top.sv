`ifndef	ALU_TOP
`define	ALU_TOP

`include "alu_interface.sv"
`include "alu_environment.sv"

program alu_top (alu_interface alu_interface_ins);

  //virtual interface
  virtual alu_interface alu_interface_ins_h;

  //environment instance
  alu_environment alu_environment_ins;

  initial begin

    //connect virtual interface
    alu_interface_ins_h=alu_interface_ins;

    //objects instantiation
    alu_environment_ins = new (alu_interface_ins_h);   

    alu_environment_ins.run();

  end

endprogram

`endif