`ifndef	ALU_REF_MOD
`define	ALU_REF_MOD

`include "alu_transaction.sv"

class alu_ref_mod;

  //mailbox 
  mailbox mon2ref;
  mailbox ref2score;

  // constructor
  function new (mailbox mon2ref , mailbox ref2score);

    //connect mailboxes
    this.mon2ref	= mon2ref;
    this.ref2score 	= ref2score;
    
  endfunction

  // this task is used to drive stimulus on the interface
  task ref_model ();

    //transaction object handler
    alu_transaction alu_transaction_in_ins;
    alu_transaction alu_transaction_out_ins;

    forever begin 
      
      //transaction object instantiation
      alu_transaction_in_ins=new();   
      alu_transaction_out_ins=new();

      // get transactions from monitor mailbox
      mon2ref.get(alu_transaction_in_ins);

      if (alu_transaction_in_ins.reset)
        alu_transaction_out_ins.Result  = 8'b00000000;
      else 
        begin
          case (alu_transaction_in_ins.Op)
            0 : alu_transaction_out_ins.Result = alu_transaction_in_ins.A + alu_transaction_in_ins.B; 
            1 : alu_transaction_out_ins.Result = alu_transaction_in_ins.A - alu_transaction_in_ins.B;
            2 : alu_transaction_out_ins.Result = alu_transaction_in_ins.A * alu_transaction_in_ins.B; 
            3 : alu_transaction_out_ins.Result = alu_transaction_in_ins.A / alu_transaction_in_ins.B; 
          endcase
        end

      // send transactions to scoreboard usong the mailbox
      ref2score.put(alu_transaction_out_ins);
    end
  endtask

endclass

`endif