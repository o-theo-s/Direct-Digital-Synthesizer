`include "phase_to_amplitude_converter/pac.v"
`timescale 1ns/100ps

module pac_tb;
    reg clk, eo;
    reg [13:0] phase;
    wire [11:0] amplitude;

    pac #(.N(14), .P(12)) U4_pac_tb (
        .clk        (clk),
        .eo         (eo),
        .phase      (phase),
        .amplitude  (amplitude)
    );

    initial begin
        $dumpfile ("phase_to_amplitude_converter/output/pac.vcd");
        
        clk     = 0;
        eo      = 0;
        phase   = 0;

        $dumpvars;
        #9 $finish;
    end

    always begin
        #0.5 clk = ~clk;
    end

    initial begin
        #1   eo    = 1;
        
        #1.5 phase = 4096;
        #1   phase = 8192;
        #1   phase = 12288;
        
        repeat (3) begin
            #1 phase = $urandom % (1<<14);
        end
    end

endmodule