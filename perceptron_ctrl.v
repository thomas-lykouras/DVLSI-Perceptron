/*
  perceptron_ctrl.v

  Percetron networks control path

*/

module perceptron_ctrl (
    // Clocking
    input clk,
    input reset,
    // Control from control block
    output enable,
    // Flow control
    input  val_i,
    output rdy_o,
    output val_o,
    input  rdy_i,
);

always @ (posedge clk)
begin
  if (reset == 1)
  begin
    rdy_o <= 0;
    val_o <= 0;
  end else begin

  end
end

endmodule
