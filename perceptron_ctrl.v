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
    output     en_out_path,
    output     en_in_path,
    // Flow control
    input      val_i,
    output     rdy_o,
    output reg val_o,
    input      rdy_i
);

reg  val_o_reg;
wire reset_internal;

assign rdy_o = ((rdy_i || (~(val_o && val_o_reg)))) && (reset_internal);

assign en_in_path  = rdy_o;
assign en_out_path = rdy_i || (!val_o);

assign reset_internal = reset && (~|W1W0b_en_i);

always @ (posedge clk)
begin
  if (reset_internal == 0)
  begin
    val_o_reg <= 0;
    val_o     <= 0;
  end else begin
    // First Register
    if (en_in_path == 1) begin
      val_o_reg <= (val_i && rdy_o);
    end
    // Second Register
    if (en_out_path == 1) begin
      val_o <= val_o_reg;
    end
  end
end

endmodule
