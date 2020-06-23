function [time_s, velocity] = time_vel_function(x_position,time)


% function [time, velocity] = time_vel_function(x_position, y_position)
%
%  x_position
%  y_position

fs = 60;


line_low_x=lowpass(x_position,3,fs);

distance = sum(sqrt(diff(line_low_x).^2))/85.039370079;
time_s = time(1,end)/1000;
velocity = distance /time_s;
