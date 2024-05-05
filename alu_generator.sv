`ifndef	ALU_GENERATOR
`define	ALU_GENERATOR

`include "alu_transaction.sv"

class alu_generator;

  //number of transactions
  rand int num_of_trans;

  //mailbox 
  mailbox gen2drive;

  function new ( mailbox gen2drive );

    this.gen2drive = gen2drive;

  endfunction

  // This task is used to generate stimulus and send it to Driver
  task generating ();

    //transaction object handler

    alu_transaction alu_transaction_ins;

    num_of_trans=$urandom_range(200,400);

    for (int i =0; i< num_of_trans; i++) begin 

      //transaction object instantiation
      alu_transaction_ins=new();

      //transaction object randomization
      alu_transaction_ins.randomize();

      // Write Trans to MailBox
      gen2drive.put(alu_transaction_ins);
    end

  endtask

endclass

`endif