module spi(sclk, mosi, miso, ss, wordin, wordout, load, br);
parameter B = 8;

input sclk, mosi, ss, load;
input [B-1:0] wordin;
output miso, br;
output [B-1:0] wordout;

reg [B-1:0] buffer;
reg [$clog2(B)-1:0] counter;

assign br      = !ss ? !counter : 'bz;
assign wordout = !ss ? buffer : 'bz;
assign miso    = !ss ? buffer[0] : 'bz;

always @(posedge sclk, posedge ss) begin
    if (ss) begin
        counter <= 'b0;
    end
    else begin
        if (load && !counter)
            buffer <= wordin;
        else
            buffer <= {mosi, buffer[B-1:1]};
        
        counter <= counter + 1;
    end
end

endmodule