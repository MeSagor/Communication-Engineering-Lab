clear all;
close all;
clc;

bits = [1 0 1 0 0 1 1 0 1 1];
bit_duration = 2;

fs = 100;
Total_time = length(bits) * bit_duration;   # time needed to send whole data
t = 0: 1/fs: Total_time-(1/fs);

one = [ones(1, (fs/2) * bit_duration).*3, ones(1, (fs/2) * bit_duration).*-3];
zero = [ones(1, (fs/2) * bit_duration).*-3, ones(1, (fs/2) * bit_duration).*3];

# sender end
prv_bit = zero;
for i = 1 : length(bits)
  if bits(i) == 0
    diff_manchester(((i-1) * bit_duration * fs) + 1 : i * bit_duration * fs) = prv_bit;
  else
    prv_bit = prv_bit .* -1;
    diff_manchester(((i-1) * bit_duration * fs) + 1 : i * bit_duration * fs) = prv_bit;
  endif
endfor

# ploting
plot(t, diff_manchester);
xticks([0: bit_duration: Total_time]);
yticks([-5: 2: 5]);
ylim([-5, 5]);
xlim([0, Total_time]);
grid on;
title("Differential Manchester");
xlabel("Time");
ylabel("Amplitude");
line ([0, Total_time], [0 0], "linestyle", "--", "color", "r");

% Top axis
ax1=gca;
ax2 = axes('Position', get(ax1, 'Position'), 'Color', 'none');
set(ax2, 'XAxisLocation', 'top');
set(ax2, 'XLim', get(ax1, 'XLim'));
set(ax2, 'YLim', get(ax1, 'YLim'));
set(ax2, 'XTick', [bit_duration/2: bit_duration: Total_time]);
set(ax2, 'YTick', [-5: 2: 5]);
set(ax2, 'XTickLabel', bits);
set(ax2, 'XLabel', 'Data bits');


# receiver end
checker = one;
for i = 1 : length(diff_manchester)/(bit_duration * fs)
  if diff_manchester(((i-1) * bit_duration * fs) + 1 : i * bit_duration * fs) == checker
    rcv_data(i) = 1;
    checker = checker .* -1;
  else
    rcv_data(i) = 0;
  endif
endfor

disp(rcv_data);
