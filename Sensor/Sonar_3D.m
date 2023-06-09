clear; clc; clf; close all;
a = arduino("/dev/tty.usbserial-AQ02T0FB", "Nano3", "Libraries", 'Ultrasonic');
#Creat an arduino object
ultrasonicObj = ultrasonic(a, "D3", "D2");
#Creat an ultrasonic object
#Trig pin is connected to D3 of Aduino Nano and Echo pin is connected to D2

r = [];
r_max = 0.2;
#Distance between the vertical axis of the cylinder and the sensor
vertical_speed = 0.1;
angular_speed = pi/6;
t_max = 10;
for trial = 0 : 0.04 : t_max
            data = readDistance(ultrasonicObj);
            if data > r_max
                        data = 0;
            else
                        data = r_max - data;
            end
            r = [r data];
            pause(0.04)
end

trial = size(0 : 0.04 : t_max);
t = 0 : 0.04 : t_max;
theta = t.*angular_speed;
smoothData = smoothdata(r, "movmean", 50);
x = smoothData.*cos(theta);
y = smoothData.*sin(theta);
z = t.*vertical_speed;
scatter3(x, y, z);

d = ceil(2*pi/angular_speed/0.04);
#Number of data per revolution
X = [x(1:trial-d)
     x(d+1:trial)];
Y = [y(1:trial-d)
     y(d+1:trial)];
Z = [z(1:trial-d)
     z(d+1:trial)];
#Connect points with adjacent z value and theta value
surf(X, Y, Z)
