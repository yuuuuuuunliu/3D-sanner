clear; clc; clf; close all;
a = arduino("/dev/tty.usbserial-AQ02T0FB", "Nano3", "Libraries", 'Ultrasonic');
ultrasonicObj = ultrasonic(a, "D3", "D2");

distance = [];
t_max = 100;
for trial = 1 : 1 : t_max
    distance = [distance readDistance(ultrasonicObj)];
    pause (0.04);
end
mean(distance)
std(distance)
