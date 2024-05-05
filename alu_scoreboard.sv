`ifndef	ALU_SCOREBOARD
`define	ALU_SCOREBOARD

`include "alu_transaction.sv"

class alu_scoreboard;

  //mailbox 
  mailbox mon2score;
  mailbox ref2score;

  // constructor
  function new (mailbox mon2score , mailbox ref2score);

    //connect mailboxes
    this.mon2score	= mon2score;
    this.ref2score 	= ref2score;
    
  endfunction

  // This task is used to drive stimulus on the interface
  task compare();

    //transaction object handler
    alu_transaction alu_transaction_exp_ins;
    alu_transaction alu_transaction_act_ins;

    forever begin 
      //transaction object instantiation
      alu_transaction_exp_ins=new();   
      alu_transaction_act_ins=new();

      // get transactions from mailboxes
      ref2score.get(alu_transaction_exp_ins);
      mon2score.get(alu_transaction_act_ins);

      //check if exp == act
      if (alu_transaction_exp_ins.Result === alu_transaction_act_ins.Result)
        begin
          $display ("The expected result %d, is equivalent actual result  %d.",alu_transaction_exp_ins.Result,alu_transaction_act_ins.Result);
        end
      else 
        begin
          $display ("The expected result:%d is NOT equal the actual result:%d",alu_transaction_exp_ins.Result,alu_transaction_act_ins.Result);
        end
    end
  endtask

endclass

`endif