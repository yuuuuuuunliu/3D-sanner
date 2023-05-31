clear; clc; clf; close all;
a = arduino("COM3", "Nano3", "Libraries", 'Ultrasonic');
ultrasonicObj = ultrasonic(a, "D3", "D2");

distance = [];
t_max = 100;
for trial = 1 : 1 : t_max 
    distance = [distance readDistance(ultrasonicObj)];
    pause (0.04);
end

velocity = 0.1;
x = linspace(0,t_max-1,t_max).*velocity;

plot(x,distance)
xlabel('x/dm') 
ylabel('y/dm') 