clear; clc; clf; close all;
a = arduino("COM3", "Nano3", "Libraries", 'Ultrasonic');
ultrasonicObj = ultrasonic(a, "D3", "D2");

%/dev/tty.usbserial-AQ02T0FB

distance = [];
t_max = 100;
for trial = 1 : 1 : t_max 
    distance = [distance readDistance(ultrasonicObj)];
    pause (0.04);
end;

r_max = 1;
vertical_speed = 0.1;
angular_speed = 0.1;
t = linspace(0,t_max-1,t_max);
r = abs(r_max - distance);
theta = t.*angular_speed;
x = r.*cos(theta);
y = r.*sin(theta);
z = t.*vertical_speed;
scatter3(x, y, z)
xlabel("x/dm")
ylabel("y/dm")
zlabel("z/dm")
%d = 2*pi/angular_speed, upper approximation
d = 63;
X = [x(1:t_max-d)
    x(d+1:t_max)];
Y = [y(1:t_max-d)
    y(d+1:t_max)];
Z = [z(1:t_max-d)
    z(d+1:t_max)];
surf(X, Y, Z)
xlabel("x/dm")
ylabel("y/dm")
zlabel("z/dm")