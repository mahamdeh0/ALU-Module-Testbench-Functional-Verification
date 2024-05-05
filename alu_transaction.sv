`ifndef	ALU_TRANSACTION
`define	ALU_TRANSACTION

class alu_transaction;

  rand logic 			reset ;
  rand logic 	[3:0] 	A     ;
  rand logic 	[3:0] 	B     ;
  rand logic 	[1:0] 	Op    ;
  logic 		[7:0] 	Result;

  constraint div_on_zero_c {
    if(Op ==3) B > 0 ;
  }
  
endclass
`endif