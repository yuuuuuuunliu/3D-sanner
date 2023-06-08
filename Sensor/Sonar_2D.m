clear; clc; clf; close all;
a = arduino("/dev/tty.usbserial-AQ02T0FB", "Nano3", "Libraries", 'Ultrasonic');
ultrasonicObj = ultrasonic(a, "D3", "D2");

distance = [];
t_max = 10;
step = 0.04;
for trial = 0 : step: t_max 
    distance = [distance readDistance(ultrasonicObj)];
    pause (step);
end

trial = floor(t_max/step)+1;
velocity = 0.1;
t = 0 : step: step*(trial-1);
x = t.*velocity;

smoothData = smoothdata(distance, "movmedian", 100);
plot(x,smoothData)
xlabel('x/dm') 
ylabel('y/dm') 