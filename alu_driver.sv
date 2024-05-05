`ifndef	ALU_DRIVER
`define	ALU_DRIVER

`include "alu_transaction.sv"
`include "alu_interface.sv"

class alu_driver;

  //virtual interface 
  virtual alu_interface alu_interface_ins;

  //mailbox 
  mailbox gen2drive;

  // constructor
  function new (virtual alu_interface alu_interface_ins , mailbox gen2drive);

    //connect interface
    this.alu_interface_ins=alu_interface_ins;

    //connect mailbox
    this.gen2drive=gen2drive;

  endfunction

  // this task is used to drive stimulus on the interface
  task drive ();

    //transaction object handler
    alu_transaction alu_transaction_ins;

    forever @(posedge alu_interface_ins.clk) begin 

      //transaction object instantiation
      alu_transaction_ins=new();

      // get transactions
      gen2drive.get(alu_transaction_ins);

      // writing on the interface
      alu_interface_ins.reset	= alu_transaction_ins.reset;
      alu_interface_ins.A		= alu_transaction_ins.A;
      alu_interface_ins.B		= alu_transaction_ins.B;
      alu_interface_ins.Op		= alu_transaction_ins.Op;
    end
  endtask

endclass

`endif