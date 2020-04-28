`include "operation_profile_configurator/opc.v"
`timescale 1ns/100ps

module opc_tb;
    reg clk, sclk, reset, mosi, ss;
    wire miso, br, outr;
    wire [13:0] phase;

    opc #(.M(48), .N(14), .B(8)) U3_opc_tb (
        .clk        (clk),
        .sclk       (sclk),
        .reset      (reset),
        .mosi       (mosi),
        .miso       (miso),
        .ss         (ss),
        .br         (br),
        .outr       (outr),
        .phase      (phase)
    );

    initial begin
        $dumpfile ("operation_profile_configurator/output/opc.vcd");
        
        clk     = 0;
        sclk    = 0;
        reset   = 0;
        mosi    = 0;
        ss      = 1;
        
        $dumpvars;
        $finish;
    end

    always begin
        #0.5 clk = ~clk;
    end

    always begin
        #1 sclk = ~sclk;
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
        //Read from freq
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 0;
        #2 mosi  = 1;
        #2 mosi  = 0;
        #2 mosi  = 1;

        //Sync Byte
        //Reads garbage
        #16

        //Data read
        #96 ;
    end
endmodule