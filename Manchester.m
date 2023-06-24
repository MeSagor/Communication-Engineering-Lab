close all; clear all; clc;

bits = [1 0 1 1 1 0 1 0 0 0];
bit_duration = 2;

fs = 100;
total_time = length(bits) * bit_duration;
time = 0: 1/fs : total_time;

amplitude = 3;

# Modulation
ix = 1;
for i = 1 : length(bits)
  if bits(i) == 1
      signal_value(ix) = 1 * amplitude;
      signal_value(ix+1) = -1 * amplitude;
  else
      signal_value(ix) = -1 * amplitude;
      signal_value(ix+1) = 1 * amplitude;
  endif
  ix = ix+2;
endfor

idx = 1;
for i = 1 : length(time)
  modulated_signal(i) = signal_value(idx);
  if time(i)/bit_duration >= idx/2
      idx = idx+1;
  endif
endfor


# Ploting
plot(time, modulated_signal);
xticks([0: bit_duration: total_time]);
yticks([-5: 2: 5]);
ylim([-5, 5]);
xlim([0, total_time]);
grid on;
title('Manchester');
xlabel('Time');
ylabel('Amplitude');
line([0, total_time], [0, 0], 'linestyle', '--', 'color', 'r')

# Top axis
ax1 = gca;
ax2 = axes('position', get(ax1, 'position'), 'color', 'none');
set(ax2, 'xaxislocation', 'top');
set(ax2, 'xlim', get(ax1, 'xlim'));
set(ax2, 'ylim', get(ax1, 'ylim'));
set(ax2, 'xtick', [bit_duration/2: bit_duration: total_time]);
set(ax2, 'ytick', get(ax1, 'ytick'));
set(ax2, 'xticklabel', bits);
set(ax2, 'xlabel', 'Data bits');


# Demodulation
inx = 1;
idx = 1;
for i = 1 : length(time)-1
    if time(i)/bit_duration >= idx/2
      if mod(idx, 2) == 1   # Every mid-point check
        value_first = modulated_signal(i)/amplitude;
        value_second = modulated_signal(i+1)/amplitude;
        if value_first == 1 && value_second == -1
           received(inx) = 1;
           inx = inx + 1;
        elseif value_first == -1 && value_second == 1
           received(inx) = 0;
           inx = inx + 1;
        endif
      endif
      idx = idx + 1;
    endif
endfor

disp('Sender End: ');
disp(bits);
disp('Receiver End: ');
disp(received);











