module dlock (unlock, b_in, clear, clk);
  output unlock;
  reg unlock;
  input b_in,clear,clk;
  parameter S0=0,S1=1,S2=2,S3=3,S4=4,S5=5,S6=6;
  reg [0:2] state;
  
  always@(negedge clk)
    if (!clear)
      unlock=0;
  else
    begin
    case(state)
      S0: begin
        state <= b_in?S1:S0;
      end
      S1: begin
        state <= b_in?S1:S2;
      end
      S2: begin
        state <=b_in?S3:S2;
      end
      S3: begin
        state <=b_in?S4:S3;
      end
      S4: begin
        state <=b_in?S4:S5;
      end
      S5: begin
        state <=b_in?S5:S6;
      end
      S6: begin
        state <=b_in?S0:S6;
      end
      default: state <= S0;
    endcase
    end
  
  always@(state)
    case(state)
    S6: unlock = 1;
  default: unlock =0;
  endcase
endmodule
