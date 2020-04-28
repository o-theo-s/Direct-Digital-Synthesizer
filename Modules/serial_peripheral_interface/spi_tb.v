`include "serial_peripheral_interface/spi.v"
`timescale 1ns/100ps

module spi_tb;
    reg sclk, mosi, ss, load;
    reg [7:0] temp;
    wire miso, br;
    wire [7:0] word;

    spi #(.B(8)) U1_spi_tb (
        .sclk       (sclk),
        .mosi       (mosi),
        .miso       (miso),
        .ss         (ss),
        .wordin     (temp),
        .wordout    (word),
        .load       (load),
        .br         (br)
    );

    initial begin
        $dumpfile ("serial_peripheral_interface/output/spi.vcd");

        sclk = 0;
        mosi = 0;
        ss   = 1;
        temp = 0;
        load = 0;

        $dumpvars;
        #36 $finish;
    end

    always begin
        #1 sclk = ~sclk;
    end

    initial begin
        #0.5 ss   = 0;

        #0.5 mosi = 1;
        #2   mosi = 0;
        #2   mosi = 0;
        #2   mosi = 1;
        #2   mosi = 1;
        #2   mosi = 1;
        #2   mosi = 0;
        #2   mosi = 1;

        #2   load = 1;
             temp = 'b10010101;
             mosi = 0;

        #2   load = 0;
             temp = 'b0;
        
        #14   load = 1;
             temp = 'b10000000;

        #2   load = 0;
             temp = 'b0;
    end

endmodule