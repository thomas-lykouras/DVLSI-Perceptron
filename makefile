TB_FILE := "perceptron_tb.sv"

all:
	sim-nc $(TB_FILE)

gui:
	sim-ncg $(TB_FILE) &

