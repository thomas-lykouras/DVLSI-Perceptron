/*
  perceptron_dp.v

  Percetron networks data path

*/

module perceptron_dp #(
    parameter WIDTH = 8
  ) (
    // Clocking
    input clk,
    input reset,
    // Control from control block
    input en_egress,
    input en_ingress,
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

// Variables
reg  signed [WIDTH-1:0]     w0, w1, b; // Parallel weights and biases
reg  signed [WIDTH-1:0]     x0, x1;    // Registered input vectors
wire signed [WIDTH*2+2-1:0] y;         // Unregistered output predictor


// Shift register logic
always @ (posedge clk)
begin

  // Synchronous reset
  if (reset == 1)
  begin
    w0 <= 0;
    w1 <= 0;
    b  <= 0;
  end else begin

    // W1 Shift register
    if (W1W0b_en_i == 2'b11)
    begin
      w1 <= {w1[WIDTH-2:0] , W1_i};
    end

    // W0 Shift register
    if (W1W0b_en_i == 2'b10)
    begin
      w0 <= {w0[WIDTH-2:0] , W0_i};
    end

    // b Shift register
    if (W1W0b_en_i == 2'b01)
    begin
      b <= {b[WIDTH-2:0] , b_i};
    end

  end
end

// Compute y combinatorially
assign y = b + x0*w0 + x1*w1;

// Perceptron computation
always @ (posedge clk)
begin

  // Synchronous Reset
  if (reset == 1)
  begin
    x0  <= 0;
    x1  <= 0;
    Y_o <= 0;
  end else begin

    if (en_ingress == 1)
    begin
      // Register our new inputs
      x0 <= X0_i;
      x1 <= X1_i;
    end

    if (en_egress == 1) begin
      // Compute perceptron by applying a step function
      // and flopping the output
      Y_o <= ~y[WIDTH*2+2-1];
    end

  end
end

endmodule
