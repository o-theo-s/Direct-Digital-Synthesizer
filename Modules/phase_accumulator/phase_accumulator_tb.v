`include "phase_accumulator/phase_accumulator.v"
`timescale 1ns/100ps

module phase_accumulator_tb;
    reg clk, reset, fph;
    reg [1:0] mode;
    reg [4:0] temp;

    wire [3:0] phase;
    wire [4:0] word;

    assign word = mode == 2'b10 ? 'bz : temp;

    phase_accumulator #(.M(5), .N(4)) U2_pa_tb (
        .clk    (clk),
        .reset  (reset),
        .mode   (mode),
        .fph    (fph),
        .word   (word),
        .phase  (phase)
    );

    initial begin
        $dumpfile ("phase_accumulator/output/phase_accumulator.vcd");

        clk   = 0;
        reset = 0;
        temp  = 5;
        mode  = 'b0;
        fph   = 0;

        $dumpvars;
        #9 $finish;
    end

    always begin
        #0.5 clk = ~clk;
    end

    initial begin
        #0.6 reset = 1;
        #0.4 reset = 0;

        #0.5 mode  = 2'b11;
             fph   = 1;

        #1   fph   = 0;
             temp  = 2;

        #1   mode  = 2'b10;
             fph   = 1;
             temp  = 'b0;

        #1   mode  = 'b0;
             temp  = 1;

        #2   mode  = 2'b01;

        #1   mode  = 'b0;
    end

endmodule