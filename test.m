clc;
clear all;
close all;


car_amp=1;
msg_amp=1;
fc=15;
fm=20;
t=0:0.001:1;
msg=msg_amp*cos(2*pi*fm*t);
carrier=car_amp*sin(2*pi*fc*t);
modulation=10;

signal=car_amp.*sin(2*pi*fc*t + (modulation.*sin(2*pi*fm*t)));
%modulated_signal = carrier_amp .* sin(2*pi*carrier_frq*t + (modulation_index .* sin(2*pi*message_frq*t)));

subplot(3,1,2);
plot(t,msg);

subplot(3,1,1);
plot(t,carrier);

subplot(3,1,3);
plot(t,signal);

