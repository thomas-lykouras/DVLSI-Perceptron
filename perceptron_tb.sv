//---------------------------------------------------------
// perceptron_tb.sv
//
// Testbench of Perceptron
//--------------------------------------------------------

module testbench();

    parameter WIDTH = 8;

    // Input signals
    logic                    clk;
    logic                    reset;
    logic                    enable;
    logic  [1:0]             W1W0b_en_i;
    logic                    b_i;
    logic                    W0_i;
    logic                    W1_i;
    logic signed [WIDTH-1:0] X0_i;
    logic signed [WIDTH-1:0] X1_i;
    logic                    Y_o;

    // The device under test
    perceptron_dp dut(
      .clk(clk),
      .reset(reset),
      .enable(enable),
      .W1W0b_en_i(W1W0b_en_i),
      .b_i(b_i),
      .W0_i(W0_i),
      .W1_i(W1_i),
      .X0_i(X0_i),
      .X1_i(X1_i),
      .Y_o(Y_o)
    );

	`include "testfixture.verilog"

endmodule

	`include "perceptron_dp.v"

