close all; clear all; clc;

bits = [1 0 1 1 1 0 1 0 0 0 1];
bit_duration = 2;

fs = 100;
total_time = length(bits) * bit_duration;
time = 0: 1/fs : total_time;

amplitude = 3;

# Modulation
prv_nonzero_state = -1;
prv_state = 0;
for i = 1 : length(bits)
  if bits(i) == 1
     if prv_state != 0
        signal_value(i) = 0;
        prv_state = 0;
     else
        signal_value(i) = -prv_nonzero_state;
        prv_nonzero_state = -prv_nonzero_state;
        prv_state = prv_nonzero_state;
     endif
  else
      signal_value(i) = prv_state;
  endif
endfor

idx = 1;
for i = 1 : length(time)
   modulated_signal(i) = signal_value(idx) * amplitude;
   if time(i)/bit_duration >= idx
     idx = idx + 1;
   endif
endfor


# Ploting
plot(time, modulated_signal);
xticks([0: bit_duration: total_time]);
yticks([-5: 2: 5]);
ylim([-5, 5]);
xlim([0, total_time]);
grid on;
title('MLT-3');
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
prv_state = 0;
idx = 1;
for i = 1 : length(time)
    if time(i)/bit_duration >= idx
        value = modulated_signal(i)/amplitude;
        if value == prv_state
          received(idx) = 0;
        else
          received(idx) = 1;
          if value == 1
            prv_state = 1;
          elseif value == -1
            prv_state = -1;
          else
            prv_state = 0;
          endif
        endif
        idx = idx + 1;
    endif
endfor

disp('Sender End: ');
disp(bits);
disp('Receiver End: ');
disp(received);











