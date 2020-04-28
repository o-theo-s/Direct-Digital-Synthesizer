`include "serial_peripheral_interface/spi.v"
`include "phase_accumulator/phase_accumulator.v"

module opc(clk, sclk, reset, mosi, miso, ss, br, outr, phase);
    parameter M = 48;
    parameter N = 14;
    parameter B = 8;

    input clk, sclk, reset, mosi, ss;
    output miso, br, outr;
    output [N-1:0] phase;
    
    reg fph;
    reg [1:0] mode;
    reg [M-1:0] buffer;
    reg [$clog2(M/B+2)-1:0] counter;

    wire [B-1:0] word_read;
    wire [M-1:0] pa_word;

    assign pa_word = mode == 2'b10 || counter != 3'b111 ? 'bz : buffer;
    assign outr    = !mode;

    spi #(.B(B)) U1_spi (
        .sclk       (sclk),
        .mosi       (mosi),
        .miso       (miso),
        .ss         (ss),
        .wordin     (buffer[B-1:0]),
        .wordout    (word_read),
        .load       (mode == 2'b10),
        .br         (br)
    );

    phase_accumulator #(.M(M), .N(N)) U2_pa (
        .clk        (clk),
        .reset      (reset),
        .mode       (~(~mode)),
        .fph        (fph),
        .word       (pa_word),
        .phase      (phase)
    );

    always @(posedge sclk, posedge reset) begin
        if (reset) begin
            fph     = 1'b0;
            mode    = 2'b01;
            buffer  =  'b0;
            counter = 3'b111;
        end
        else begin
            if (!ss) begin
                if (br) begin
                    counter = counter + 1;
                    if (counter == 3'b000) begin
                        mode = 2'b01;
                    end
                    else if (counter == 3'b001) begin
                        mode[1] = word_read[7];
                        mode[0] = word_read[7] ? word_read[6] : word_read[4];
                        fph = word_read[5];
                    end
                    else begin
                        if (mode[1]) begin
                            buffer = buffer >> B;
                            if (mode[0]) begin
                                buffer[M-1:M-B] = word_read;
                            end
                        end
                    end
                end

                if (counter == 3'b001 && mode == 2'b10) begin
                    buffer = pa_word;
                end
            end
            else begin
                counter = 3'b111;
            end
        end
    end

endmodule