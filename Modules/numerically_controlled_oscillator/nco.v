`include "operation_profile_configurator/opc.v"
`include "phase_to_amplitude_converter/pac.v"

module nco(clk, sclk, reset, mosi, miso, ss, br, amplitude);
    parameter M = 48;
    parameter N = 14;
    parameter P = 12;
    parameter B = 8;

    input clk, sclk, reset, mosi, ss;
    output miso, br;
    output [P-1:0] amplitude;

    wire outr;
    wire [N-1:0] phase;

    opc #(.M(M), .N(N), .B(B)) U3_opc (
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

    pac #(.N(N), .P(P)) U4_pac (
        .clk        (clk),
        .eo         (!reset && outr),
        .phase      (phase),
        .amplitude  (amplitude)
    );

endmodule