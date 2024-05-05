module ALU(clk,reset,A,B,Op,Result);

  input              reset,clk;
  input       [3:0]  A,B;
  input       [1:0]  Op;
  output reg  [7:0]  Result;

  always@(posedge clk)
    begin

      if(reset)
        Result = 8'b00000000;
      else begin
        case(Op)

          0: Result = A + B;
          1: Result = A - B;
          2: Result = A * B;
          3: Result = A / B;

        endcase

      end

    end

endmodule