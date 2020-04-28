%%%%% NCO LUT Calculation %%%%%
%% Initialization
clear

M = 48;
N = 14;
P = 12;

%% Create discrete values
pac = sinpi( 0.5 * (0 : 2^-(N-2) : 1 - 2^-(N-2)) );
pac = (pac + 1) * (2^P-1) / 2;
pac = round(pac);

figure
plot(0:2^N-1, [pac, pac(end:-1:1), 2^P-1 - pac, 2^P-1 - pac(end:-1:1)]);

%% Convert values to binary
pac = de2bi(pac, 'left-msb');

file = fopen('sine_4_test.txt', 'w');

format_bin = '%d';
for i = 1:P-1
    format_bin = strcat(format_bin, '%d');
end

% Export for Verilog
% format = strcat("%d : data = quadrant[1] ? %d'b", format_bin);
% format = strcat(format, " : %d'b");
% format = strcat(format, format_bin);
% format = strcat(format, ";\n");

% Export of simple values
format = strcat(format_bin, "\n");

for i = 1:2^(N-2)
%   Print Verilog cases
% 	fprintf(file, format, i-1, P, ~pac(i, :), P, pac(i, :));

%   Print simple values
    fprintf(file, format, pac(i, :));
end
fclose(file);

%% Recalculate original values
dac = bi2de(pac, 'left-msb') * 2 / (2^P-1) - 1;

figure
plot(0:2^N-1, [dac; dac(end:-1:1); - dac; - dac(end:-1:1)]);