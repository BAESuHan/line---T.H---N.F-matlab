function [A_line_Error_distance] = error_dis_function(x_position)

fs = 60;

line_low_x=lowpass(x_position,3,fs);

base_l = ones(1,length(line_low_x))*480;

%ED
line_error_d=0;

for i= 1:length(line_low_x)
   line_error_d = line_error_d +sqrt((line_low_x(1,i) - base_l(1,i)).^2) ;
end
A_line_Error_distance = line_error_d/length(line_low_x)/88.18;