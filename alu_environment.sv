`ifndef	ALU_ENVIROMENT
`define	ALU_ENVIROMENT

`include "alu_interface.sv"
`include "alu_driver.sv"
`include "alu_generator.sv"
`include "alu_monetor.sv"
`include "alu_ref_mod.sv"
`include "alu_scoreboard.sv"

class alu_environment;
  
  //objects handler
  alu_driver 		alu_driver_ins;
  alu_generator	    alu_generator_ins;
  alu_monetor		alu_monetor_ins;
  alu_ref_mod		alu_ref_mod_is;
  alu_scoreboard	alu_scoreboard_ins;
  
  //virtual interface
  virtual alu_interface alu_interface_ins;
  
  //mailbox
  mailbox gen2drive;
  mailbox mon2ref;
  mailbox mon2score;
  mailbox ref2score;
  
  function new(virtual alu_interface alu_interface_ins);
    
    //connect virtual interface
    this.alu_interface_ins=alu_interface_ins;
    
    //create nailbox
    gen2drive	=new();
    mon2ref		=new();
    mon2score	=new();
    ref2score	=new();
    
    //objects instantiation
    alu_driver_ins 		    = new (alu_interface_ins , gen2drive             );
    alu_generator_ins 		= new (gen2drive                                 );
    alu_monetor_ins 		= new (alu_interface_ins , mon2ref , mon2score   );
    alu_ref_mod_is 		    = new (mon2ref , ref2score                       );
    alu_scoreboard_ins 	    = new (mon2score , ref2score                     );
    
  endfunction
 
  task run();
    fork 
      begin
        alu_generator_ins.generating();
      end
      
      begin
        alu_driver_ins.drive();
      end
      
      begin
        alu_monetor_ins.input_monetor();
      end
      
      begin
        alu_monetor_ins.output_monetor();
      end
      
      begin
        alu_ref_mod_is.ref_model();
      end
      begin
        
        alu_scoreboard_ins.compare();
      end
      
    join
  endtask

endclass

`endif

