`include "numerically_controlled_oscillator/nco.v"
`timescale 1ns/100ps

module nco_tb;
    reg clk, sclk, reset, mosi, ss;
    wire miso, br;
    wire [11:0] amplitude;

    nco #(.M(48), .N(14), .P(12), .B(8)) U5_nco_tb (
        .clk        (clk),
        .sclk       (sclk),
        .reset      (reset),
        .mosi       (mosi),
        .miso       (miso),
        .ss         (ss),
        .br         (br),
        .amplitude  (amplitude)
    );

    initial begin
        $dumpfile ("numerically_controlled_oscillator/output/nco.vcd");

        clk     = 1;
        sclk    = 0;
        reset   = 0;
        ss      = 1;
        mosi    = 0;

        fork
            #270 $dumpvars;
            #305 $finish;
        join
    end

    always begin
        #0.5 clk   = !clk;
    end

    always begin
        #1 sclk   = !sclk;
    end

    initial begin
        #0.2 reset  = 1;
        #0.3 reset  = 0;
             ss     = 0;

        //Instruction Byte 1
        //Write to freq
        #0.5 mosi   = 0;
        #2   mosi   = 0;
        #2   mosi   = 0;
        #2   mosi   = 0;
        #2   mosi   = 0;
        #2   mosi   = 1;
        #2   mosi   = 1;
        #2   mosi   = 1;

        //Frequency
        #2 mosi  = 1;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;

        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;

        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;

        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;

        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;

        #2 mosi  = 1;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;

        //Sync Byte
        #2 mosi  = 0;
        #14

        //Instruction Byte 2
        //Write to acc
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 1;
        #2 mosi  = 1;

        //Phase Offset
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 1;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;

        #2 mosi  = 1;
        #2 mosi  = 0;
        #2 mosi  = 1;
        #2 mosi  = 1;
        #2 mosi  = 1;
        #2 mosi  = 1;
        #2 mosi  = 0;
        #2 mosi  = 0;

        #2 mosi  = 0;
        #2 mosi  = 1;
        #2 mosi  = 1;
        #2 mosi  = 1;
        #2 mosi  = 0;
        #2 mosi  = 1;
        #2 mosi  = 0;
        #2 mosi  = 0;

        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;

        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 1;

        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;

        //Sync Byte
        #2 mosi  = 0;
        #14

        //Instruction Byte 3
        //Normal operation
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 1;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;

        #4 ss = 1;

        #10 ss = 0;

        //Instruction Byte 4
        //Halt operation
           mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 1;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;

        #4 ss = 1;
    end

endmodule