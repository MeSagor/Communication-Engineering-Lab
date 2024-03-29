clear all;
close all;
clc;

carrier_amp = 1;
message_amp = 1;
carrier_frq = 15;
message_frq = 1;

% Modulation index, best if 1/2
%modulation_index = message_amp / carrier_amp;
modulation_index = 10;


Total_time = 5;
t = 0 : 0.001: Total_time;

message_signal = message_amp * cos(2 * pi * message_frq * t);
%message_signal = message_amp * sin(2 * pi * message_frq * t) + message_amp * cos(2 * pi * message_frq/2 * t);

carrier_signal = carrier_amp * sin(2 * pi * carrier_frq * t);

modulated_signal = carrier_amp .* sin(2*pi*carrier_frq*t + (modulation_index .* cos(2*pi*message_frq*t)));


function m = pmDemod(s)
      x = diff(s);
      y = abs(x);
      [b, a] = butter(10, 0.056);
      m = filter(b, a, y);
endfunction

%demodulated_signal = pmDemod(modulated_signal);




subplot(411);
plot(t, carrier_signal);
title('Carrier Signal');

subplot(412);
plot(t, message_signal);
title('Message Signal');
line ([0, Total_time], [0 0], "linestyle", "--", "color", "r");

subplot(413);
plot(t, modulated_signal);
title('Phase Modulated Signal');
line ([0, Total_time], [0 0], "linestyle", "--", "color", "r");

%subplot(414);
%plot(t, demodulated_signal);
%title('Demodulated Signal');
%line ([0, Total_time], [0 0], "linestyle", "--", "color", "r");


