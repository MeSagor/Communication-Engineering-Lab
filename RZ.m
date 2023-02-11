clear all;
close all;
clc;

bits = [1 0 1 0 0 1 1 0 1 1];
bit_duration = 2;

fs = 100;
Total_time = length(bits) * bit_duration;   # time needed to send whole data
t = 0: 1/fs: Total_time-(1/fs);

one = [ones(1, (fs/2) * bit_duration).*3, zeros(1, (fs/2) * bit_duration)];
zero = [ones(1, (fs/2) * bit_duration).*-3, zeros(1, (fs/2) * bit_duration)];

# sender end
for i = 1 : length(bits)
  if bits(i) == 0
    rz(((i-1) * bit_duration * fs) + 1 : i * bit_duration * fs) = zero;
  else
    rz(((i-1) * bit_duration * fs) + 1 : i * bit_duration * fs) = one;
  endif
endfor

# ploting
plot(t, rz);
xticks([0: bit_duration: Total_time]);
yticks([-5: 2: 5]);
ylim([-5, 5]);
xlim([0, Total_time]);
grid on;
title("RZ");
xlabel("Time");
ylabel("Amplitude");
line ([0, Total_time], [0 0], "linestyle", "--", "color", "r");


# receiver end
for i = 1 : length(rz)/(bit_duration * fs)
  if rz(((i-1) * bit_duration * fs) + 1 : i * bit_duration * fs) == one
    rcv_data(i) = 1;
  else
    rcv_data(i) = 0;
  endif
endfor

disp(rcv_data);
