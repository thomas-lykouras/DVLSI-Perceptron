/*
  perceptron_top.v

  Top level of percetron block

*/

module perceptron_top #(
    parameter WIDTH = 8
  ) (
    // Clocking
    input clk,
    input reset,
    // Flow control
    input      val_i,
    output     rdy_o,
    output reg val_o,
    input      rdy_i,
    // Weights and bias ports
    input  [1:0] W1W0b_en_i,
    input        b_i,
    input        W0_i,
    input        W1_i,
    // Input vectors
    input signed [WIDTH-1:0] X0_i,
    input signed [WIDTH-1:0] X1_i,
    // Output decision
    output reg Y_o
);

wire en_egress;
wire en_ingress;

    perceptron_ctrl ctrl(
      .clk        (clk),
      .reset      (reset),
      .W1W0b_en_i (W1W0b_en_i),
      .en_egress  (en_egress),
      .en_ingress (en_ingress),
      .val_i      (val_i),
      .rdy_o      (rdy_o),
      .val_o      (val_o),
      .rdy_i      (rdy_i)
    );

    perceptron_dp #(WIDTH) dp(
      .clk        (clk),
      .reset      (reset),
      .en_egress  (en_egress),
      .en_ingress (en_ingress),
      .W1W0b_en_i (W1W0b_en_i),
      .b_i        (b_i),
      .W0_i       (W0_i),
      .W1_i       (W1_i),
      .X0_i       (X0_i),
      .X1_i       (X1_i),
      .Y_o        (Y_o)
    );

endmodule

	`include "perceptron_ctrl.v"
	`include "perceptron_dp.v"
