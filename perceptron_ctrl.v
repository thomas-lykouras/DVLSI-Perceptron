/*
  perceptron_ctrl.v

  Percetron networks control path

*/

module perceptron_ctrl (
    // Clocking
    input      clk,
    input      reset,
    //
    input  [1:0] W1W0b_en_i,
    // Control from control block
    output     en_egress,
    output     en_ingress,
    // Flow control
    input      val_i,
    output     rdy_o,
    output reg val_o,
    input      rdy_i
);

reg  val_o_reg;
wire reset_internal;

// Assert rdy_o when we are not reset
// and either when the sink is ready, or there is space in the pipeline
assign rdy_o = ((rdy_i || (~(val_o && val_o_reg)))) && (~reset_internal);

assign en_ingress  = rdy_o;
assign en_egress = rdy_i || (!val_o);

// Mask reset with W1W0b_en_i as to not transistion when
// weights and biases are not set.
assign reset_internal = reset || (|W1W0b_en_i);

// Pipeline val_i && rdy_o through to val_o
always @ (posedge clk)
begin
  if (reset_internal == 1)
  begin
    val_o_reg <= 0;
    val_o     <= 0;
  end else begin
    // First Register
    if (en_ingress == 1) begin
      val_o_reg <= (val_i && rdy_o);
    end
    // Second Register
    if (en_egress == 1) begin
      val_o <= val_o_reg;
    end
  end
end

endmodule
