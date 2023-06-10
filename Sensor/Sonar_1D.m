clear; clc; clf; close all;
a = arduino("/dev/tty.usbserial-AQ02T0FB", "Nano3", "Libraries", 'Ultrasonic');
#Creat an arduino object
ultrasonicObj = ultrasonic(a, "D3", "D2");
#Creat an ultrasonic object
#Trig pin is connected to D3 of Aduino Nano and Echo pin is connected to D2

distance = [];
t_max = 100; #define the maxmimum number of trials
for trial = 1 : 1 : t_max
    distance = [distance readDistance(ultrasonicObj)]; #measure distance and add the measurement to the end of the array
    pause (0.04);
end
mean(distance)
std(distance)
