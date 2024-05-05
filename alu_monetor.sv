`ifndef	ALU_MON
`define	ALU_MON

`include "alu_transaction.sv"
`include "alu_interface.sv"

class alu_monetor;

  //virtual interface 
  virtual alu_interface alu_interface_ins;

  //mailbox
  mailbox mon2ref;
  mailbox mon2score;

  // constructor
  function new (virtual alu_interface alu_interface_ins , mailbox mon2ref , mailbox mon2score);
    
    //connect interface
    this.alu_interface_ins	= alu_interface_ins;

    //connect mailboxes
    this.mon2ref	= mon2ref;
    this.mon2score 	= mon2score;
    
  endfunction

  // this task is used to drive stimulus on the interface
  task input_monetor ();

    //transaction object handler
    alu_transaction alu_transaction_in_ins;

    forever @(negedge alu_interface_ins.clk) begin 
      
      //transaction object instantiation
      alu_transaction_in_ins=new();   

      // reading inputs from interface
      alu_transaction_in_ins.reset 	= alu_interface_ins.reset;
      alu_transaction_in_ins.A		= alu_interface_ins.A;
      alu_transaction_in_ins.B		= alu_interface_ins.B;
      alu_transaction_in_ins.Op		= alu_interface_ins.Op;

      // put transactions
      mon2ref.put(alu_transaction_in_ins);            
    end
  endtask

  // this task is used to drive stimulus on the interface
  task output_monetor ();

    //transaction object handler
    alu_transaction alu_transaction_out_ins;

    // To sync between the mailboxes
    @(negedge alu_interface_ins.clk);

    forever @(negedge alu_interface_ins.clk) begin 
      //transaction object instantiation
      alu_transaction_out_ins=new();

      // reading outputs from interface
      alu_transaction_out_ins.Result		= alu_interface_ins.Result;

      // put transactions
      mon2score.put(alu_transaction_out_ins);
    end
  endtask

endclass

`endif