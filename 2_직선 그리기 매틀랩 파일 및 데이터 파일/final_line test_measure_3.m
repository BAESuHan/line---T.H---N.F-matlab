%====================================================
% Handong global university electronic engineering Bae SH
% DATE : 2020.06.22
% for nose to finger test quantification  

%=====================================================


clear;
close all;
%%
%엑셀 데이터 읽기
excel_length2 ='B2:CDX2';
excel_length3 ='B3:CDX3';
excel_length4 ='B4:CDX4';

%% good file read
good_file = 'C:\Users\qotng\Desktop\GPG\캡스톤 논문\매트랩\직선긋기\매틀랩코드\good_exel.xlsx';

for idx=1:10
    eval(['good_time' num2str(idx,'%02d') '= xlsread(good_file,' num2str(idx,'%02d') ',excel_length2);']);
    eval(['good_xp' num2str(idx,'%02d') '= xlsread(good_file,' num2str(idx,'%02d') ',excel_length3);']);
    eval(['good_yp' num2str(idx,'%02d') '= xlsread(good_file,' num2str(idx,'%02d') ',excel_length4);']);
end

good_xp01 = good_xp01(1,1:end-1);
good_xp02 = good_xp02(1,1:end-1);
good_xp03 = good_xp03(1,1:end-1);
good_xp04 = good_xp04(1,1:end-1);
good_xp05 = good_xp05(1,1:end-1);
good_xp06 = good_xp06(1,1:end-1);
good_xp07 = good_xp07(1,1:end-1);
good_xp08 = good_xp08(1,1:end-1);
good_xp09 = good_xp09(1,1:end-1);
good_xp10 = good_xp10(1,1:end-1);

%% moderate file read
moderate_file = 'C:\Users\qotng\Desktop\GPG\캡스톤 논문\매트랩\직선긋기\매틀랩코드\moderate4_exel.xlsx';

for idx=1:10
    eval(['moderate_time' num2str(idx+10,'%02d') '= xlsread(moderate_file,' num2str(idx,'%02d') ',excel_length2);']);
    eval(['moderate_xp' num2str(idx+10,'%02d') '= xlsread(moderate_file,' num2str(idx,'%02d') ',excel_length3);']);
    eval(['moderate_yp' num2str(idx+10,'%02d') '= xlsread(moderate_file,' num2str(idx,'%02d') ',excel_length4);']);
end

 moderate_xp11 = moderate_xp11(1,1:end-1);
moderate_xp12 = moderate_xp12(1,1:end-1);
moderate_xp13 = moderate_xp13(1,1:end-1);
moderate_xp14 = moderate_xp14(1,1:end-1);
moderate_xp15 = moderate_xp15(1,1:end-1);
moderate_xp16 = moderate_xp16(1,1:end-1);
moderate_xp17 = moderate_xp17(1,1:end-1);
moderate_xp18 = moderate_xp18(1,1:end-1);
moderate_xp19 = moderate_xp19(1,1:end-1);
moderate_xp20 = moderate_xp20(1,1:end-1);

%% poor file read
poor_file = 'C:\Users\qotng\Desktop\GPG\캡스톤 논문\매트랩\직선긋기\매틀랩코드\poor5_exel.xlsx';

for idx=1:10
    eval(['poor_time' num2str(idx+20,'%02d') '= xlsread(poor_file,' num2str(idx,'%02d') ',excel_length2);']);
    eval(['poor_xp' num2str(idx+20,'%02d') '= xlsread(poor_file,' num2str(idx,'%02d') ',excel_length3);']);
    eval(['poor_yp' num2str(idx+20,'%02d') '= xlsread(poor_file,' num2str(idx,'%02d') ',excel_length4);']);
end


poor_xp21 = poor_xp21(1,1:end-1);
poor_xp22 = poor_xp22(1,1:end-1);
poor_xp23 = poor_xp23(1,1:end-1);
poor_xp24 = poor_xp24(1,1:end-1);
poor_xp25 = poor_xp25(1,1:end-1);
poor_xp26 = poor_xp26(1,1:end-1);
poor_xp27 = poor_xp27(1,1:end-1);
poor_xp28 = poor_xp28(1,1:end-1);
poor_xp29 = poor_xp29(1,1:end-1);
poor_xp30 = poor_xp30(1,1:end-1);
 
%% poor with slow moment file read
slow_file = 'C:\Users\qotng\Desktop\GPG\캡스톤 논문\매트랩\직선긋기\매틀랩코드\slow5_exel.xlsx';

for idx=1:10
    eval(['slow_time' num2str(idx+30,'%02d') '= xlsread(slow_file,' num2str(idx,'%02d') ',excel_length2);']);
    eval(['slow_xp' num2str(idx+30,'%02d') '= xlsread(slow_file,' num2str(idx,'%02d') ',excel_length3);']);
    eval(['slow_yp' num2str(idx+30,'%02d') '= xlsread(slow_file,' num2str(idx,'%02d') ',excel_length4);']);
end

% 간혹가다가 firebase 오류로 데이터가 하나씩 없을 경우를 대비함...
% slow_xp31 = slow_xp31(1,1:end-1);
% slow_xp32 = slow_xp32(1,1:end-1);
% slow_xp33 = slow_xp33(1,1:end-1);
% slow_xp34 = slow_xp34(1,1:end-1);
% slow_xp35 = slow_xp35(1,1:end-1);
% slow_xp36 = slow_xp36(1,1:end-1);
% slow_xp37 = slow_xp37(1,1:end-1);
%slow_xp38 = slow_xp38(1,1:end-1);
%slow_xp39 = slow_xp39(1,1:end-1);
% slow_xp40 = slow_xp40(1,1:end-1);

%% 1.Find TM
%%Find pca(BPF포함)
for idx = 1:10
    eval(['pca_sig' num2str(idx, '%02d') '=pca_function(good_xp' num2str(idx,'%02d') ', good_yp' num2str(idx, '%02d') ');']);
    eval(['A_tm' num2str(idx,'%02d') '=TM_function(pca_sig' num2str(idx,'%02d') ');']);
end

for idx = 11:20
    eval(['pca_sig' num2str(idx, '%02d') '=pca_function(moderate_xp' num2str(idx,'%02d') ', moderate_yp' num2str(idx, '%02d') ');']);
    eval(['A_tm' num2str(idx,'%02d') '=TM_function(pca_sig' num2str(idx,'%02d') ');']);
end

for idx = 21:30
    eval(['pca_sig' num2str(idx, '%02d') '=pca_function(poor_xp' num2str(idx,'%02d') ', poor_yp' num2str(idx, '%02d') ');']);
    eval(['A_tm' num2str(idx,'%02d') '=TM_function(pca_sig' num2str(idx,'%02d') ');']);
end


for idx = 31:40
    eval(['pca_sig' num2str(idx, '%02d') '=pca_function(slow_xp' num2str(idx,'%02d') ', slow_yp' num2str(idx, '%02d') ');']);
    eval(['A_tm' num2str(idx,'%02d') '=TM_function(pca_sig' num2str(idx,'%02d') ');']);
end

%% 2.Find peak of FFT (Hz)
for idx = 1:40
    eval(['[B_peak' num2str(idx,'%02d') ',fft_result' num2str(idx,'%02d') ',fft_freq' num2str(idx,'%02d') ',fft_limitline' num2str(idx,'%02d')  '] =peak_function(pca_sig' num2str(idx,'%02d') ');']);
end



%% 3.Find ED 
for idx = 1:10
    eval(['[C_error_dis' num2str(idx, '%02d') ']' ' =  error_dis_function(good_xp' num2str(idx,'%02d') ' );']);
end

for idx = 11:20
    eval(['[C_error_dis' num2str(idx, '%02d') ']' ' =  error_dis_function(moderate_xp' num2str(idx,'%02d') ' );']);
end

for idx = 21:30
    eval(['[C_error_dis' num2str(idx, '%02d') ']' ' =  error_dis_function(poor_xp' num2str(idx,'%02d') ' );']);
end


for idx = 31:40
    eval(['[C_error_dis' num2str(idx, '%02d') ']' ' =  error_dis_function(slow_xp' num2str(idx,'%02d') ' );']);
end
%% 4.Find velocity , 5.Find time
 for idx = 1:10
     eval(['[D_time' num2str(idx, '%02d') ',' 'E_velocity' num2str(idx, '%02d') ']' ' =  time_vel_function(good_xp' num2str(idx,'%02d') ' , good_time' num2str(idx, '%02d') ');' ]);
 end
 
 for idx = 11:20
     eval(['[D_time' num2str(idx, '%02d') ',' 'E_velocity' num2str(idx, '%02d') ']' ' =  time_vel_function(moderate_xp' num2str(idx,'%02d') ' , moderate_time' num2str(idx, '%02d') ');' ]);
 end
 
  for idx = 21:30
     eval(['[D_time' num2str(idx, '%02d') ',' 'E_velocity' num2str(idx, '%02d') ']' ' =  time_vel_function(poor_xp' num2str(idx,'%02d') ' , poor_time' num2str(idx, '%02d') ');' ]);
  end
 
  
  for idx = 31:40
     eval(['[D_time' num2str(idx, '%02d') ',' 'E_velocity' num2str(idx, '%02d') ']' ' =  time_vel_function(slow_xp' num2str(idx,'%02d') ' , slow_time' num2str(idx, '%02d') ');' ]);
 end
%%
 %%3.get means
 %% 3.1 tm means
    sum = 0;
    for idx = 1:10
        eval(['sum = sum + A_tm' num2str(idx,'%02d') ';' ]);
    end
    tm_good_mean = sum / 10;
    
    sum = 0;
    for idx = 11:20
        eval(['sum = sum + A_tm' num2str(idx,'%02d') ';' ]);
    end
    tm_moderate_mean = sum / 10;
    
    sum = 0;
    for idx = 21:30
        eval(['sum = sum + A_tm' num2str(idx,'%02d') ';' ]);
    end
    tm_poor_mean = sum / 10;
    
    
    sum = 0;
    for idx = 31:40
        eval(['sum = sum + A_tm' num2str(idx,'%02d') ';' ]);
    end
    tm_slow_mean = sum / 10;
    
    tm_mean = [tm_good_mean tm_moderate_mean tm_poor_mean];
    tm_mean_v = [tm_poor_mean tm_slow_mean];
 %% 3.2 peak means   
 sum = 0;
    for idx = 1:10
        eval(['sum = sum + B_peak' num2str(idx,'%02d') ';' ]);
    end
    peak_good_mean = sum / 10;
    
    sum = 0;
    for idx = 11:20
       eval(['sum = sum + B_peak' num2str(idx,'%02d') ';' ]);
    end
    
    peak_moderate_mean = sum / 10;
    
    sum = 0;
    for idx = 21:30
        eval(['sum = sum + B_peak' num2str(idx,'%02d') ';' ]);
    end
    peak_poor_mean = sum / 10;
    
    
    sum = 0;
    for idx = 31:40
        eval(['sum = sum + B_peak' num2str(idx,'%02d') ';' ]);
    end
    peak_slow_mean = sum / 10;
    
   peak_mean = [peak_good_mean peak_moderate_mean peak_poor_mean];
   peak_mean_v = [peak_poor_mean peak_slow_mean];
 %% 3.3 error distnace means   
  
 sum = 0;
    for idx = 1:10
        eval(['sum = sum + C_error_dis' num2str(idx,'%02d') ';' ]);
    end
    err_good_mean = sum / 10;
    
    sum = 0;
    for idx = 11:20
        eval(['sum = sum + C_error_dis' num2str(idx,'%02d') ';' ]);
    end
    
    err_moder_mean = sum / 10;
    
    sum = 0;
    for idx = 21:30
        eval(['sum = sum + C_error_dis' num2str(idx,'%02d') ';' ]);
    end
    err_poor_mean = sum / 10; 
    
    sum = 0;
    for idx = 31:40
        eval(['sum = sum + C_error_dis' num2str(idx,'%02d') ';' ]);
    end
    err_slw_mean = sum / 10;
    
    err_dis_mean = [err_good_mean err_moder_mean err_poor_mean];
 %% 3.4 time means   
    sum = 0;
    for idx = 1:10
        eval(['sum = sum + D_time' num2str(idx,'%02d') ';' ]);
    end
    time_good_mean = sum / 10;
    
    sum = 0;
    for idx = 11:20
        eval(['sum = sum + D_time' num2str(idx,'%02d') ';' ]);
    end
    
    time_moderate_mean = sum / 10;
    sum = 0;
    for idx = 21:30
        eval(['sum = sum + D_time' num2str(idx,'%02d') ';' ]);
    end
    time_poor_mean = sum / 10;
    
     sum = 0;
    for idx = 31:40
        eval(['sum = sum + D_time' num2str(idx,'%02d') ';' ]);
    end
    time_slow_mean = sum / 10;
    
    time_mean = [time_good_mean time_moderate_mean time_poor_mean];
    time_mean_v = [time_poor_mean time_slow_mean];
 %% 3.5 velocity means   
    sum = 0;
    for idx = 1:10
        eval(['sum = sum + E_velocity' num2str(idx,'%02d') ';' ]);
    end
    velocity_good_mean = sum / 10;
    
    sum = 0;
    for idx = 11:20
        eval(['sum = sum + E_velocity' num2str(idx,'%02d') ';' ]);
    end
    
    velocity_moderate_mean = sum / 10;
    sum = 0;
    for idx = 21:30
        eval(['sum = sum + E_velocity' num2str(idx,'%02d') ';' ]);
    end
    velocity_poor_mean = sum / 10;
    
    sum = 0;
    for idx = 31:40
        eval(['sum = sum + E_velocity' num2str(idx,'%02d') ';' ]);
    end
    velocity_slow_mean = sum / 10;
    
    velocity_mean = [velocity_good_mean velocity_moderate_mean velocity_poor_mean];
    velocity_mean_v = [velocity_poor_mean velocity_slow_mean];
%% Raw data plot
% figure(1);
% hold on
% for i = 1:10
%      eval(['plot(good_yp' num2str(i,'%02d') ',good_xp' num2str(i,'%02d') ');']);
% end
%  hold off
%  ylim([0 960])
% 
% 
% figure(2);
% hold on
% for i = 11:20
%      eval(['plot(moderate_yp' num2str(i,'%02d') ',moderate_xp' num2str(i,'%02d') ');']);
% end
%  hold off
%  ylim([0 960])
% 
%  
% figure(3);
% hold on
% for i = 21:30
%      eval(['plot(poor_yp' num2str(i,'%02d') ',poor_xp' num2str(i,'%02d') ');']);
% end
%  hold off
%  ylim([0 960])
% 
%  figure(4);
% hold on
% for i = 31:40
%      eval(['plot(slow_yp' num2str(i,'%02d') ',slow_xp' num2str(i,'%02d') ');']);
% end
%  hold off
%  title('slow moment')
%  ylim([0 960])
%   
 
 %%
 %논문용으로 수정해놓음 (20.06.22)
good_co = [0    0.4471    0.7412];
 mod_co = [0.3569    0.7608    0.2118];
 poor_co = [1.0000    0.4627    0.3804];
 slow_co =  [0.6392    0.3216    0.3216];
 
  label = categorical({'Good','Moderated','Poor'});
 label = reordercats(label,{'Good','Moderated','Poor'});
  label_v = categorical({'Poor','Poor with Slowmotion'});
 label_v = reordercats(label_v,{'Poor','Poor with Slowmotion'});
 
 figure(32)
 subplot(1,3,1);
 hold on
 b= bar(label, tm_mean, 0.3) ;
  b.FaceColor = 'flat'; 
b.CData(1,:) = good_co;
 b.CData(2,:) = mod_co ;
 b.CData(3,:) = poor_co;

 for i = 1:10
     eval(['plot(label(1),A_tm' num2str(i,'%02d') ',' '''--+k'')']);
 end
  for i = 11:20
     eval(['plot(label(2),A_tm' num2str(i,'%02d') ',' '''--+k'')']);
  end
  for i = 21:30
     eval(['plot(label(3),A_tm' num2str(i,'%02d') ',' '''--+k'')']);
  end 
%   for i = 31:40
%      eval(['plot(label(4),A_tm' num2str(i,'%02d') ',' '''--+r'')']);
%   end 
 ylabel('cm/sec^2');

 hold off
 
 subplot(1,3,2);
 hold on
 b=bar(label, peak_mean, 0.3);
  b.FaceColor = 'flat'; 
b.CData(1,:) = good_co;
 b.CData(2,:) = mod_co ;
 b.CData(3,:) = poor_co;
 for i = 1:10
     eval(['plot(label(1),B_peak' num2str(i,'%02d') ',' '''--+k'')']);
 end
   for i = 11:20
     eval(['plot(label(2),B_peak' num2str(i,'%02d') ',' '''--+k'')']);
  end
  for i = 21:30
     eval(['plot(label(3),B_peak' num2str(i,'%02d') ',' '''--+k'')']);
  end
%   for i = 31:40
%      eval(['plot(label(4),B_peak' num2str(i,'%02d') ',' '''--+r'')']);
%   end
 ylabel('Hz');

 hold off
 
  subplot(1,3,3);
 hold on
 b=bar(label, err_dis_mean, 0.3);
  b.FaceColor = 'flat'; 
b.CData(1,:) = good_co;
 b.CData(2,:) = mod_co ;
 b.CData(3,:) = poor_co;
 for i = 1:10
     eval(['plot(label(1),C_error_dis' num2str(i,'%02d') ',' '''--+k'')']);
 end
   for i = 11:20
     eval(['plot(label(2),C_error_dis' num2str(i,'%02d') ',' '''--+k'')']);
  end
  for i = 21:30
     eval(['plot(label(3),C_error_dis' num2str(i,'%02d') ',' '''--+k'')']);
  end
%   for i = 31:40
%      eval(['plot(label(4),C_error_dis' num2str(i,'%02d') ',' '''--+r'')']);
%   end
 ylabel('cm');
 hold off
 

%  %% slow motion


figure();

subplot(2,2,1);
 hold on
 b=bar(label_v, peak_mean_v, 0.2);
   b.FaceColor = 'flat';
 b.CData(1,:) = poor_co;
 b.CData(2,:) = slow_co;
 
  for i = 21:30
     eval(['plot(label_v(1),B_peak' num2str(i,'%02d') ',' '''--+k '')']);
  end
  for i = 31:40
     eval(['plot(label_v(2),B_peak' num2str(i,'%02d') ',' '''--+k'')']);
  end
 ylabel('Hz');
xticks([]);
 
subplot(2,2,2);
 hold on
 b=bar(label_v, tm_mean_v, 0.2);
   b.FaceColor = 'flat';
 b.CData(1,:) = poor_co;
 b.CData(2,:) = slow_co;

  for i = 21:30
     eval(['plot(label_v(1),A_tm' num2str(i,'%02d') ',' '''--+k'')']);
  end 
  for i = 31:40
     eval(['plot(label_v(2),A_tm' num2str(i,'%02d') ',' '''--+k'')']);
  end 
 ylabel('cm/sec^2');
 xticks([]);
 
subplot(2,2,3);
 hold on
b= bar(label_v, time_mean_v, 0.2);
  b.FaceColor = 'flat';
  b.CData(1,:) = poor_co;
 b.CData(2,:) = slow_co;
 
  for i = 21:30
     eval(['plot(label_v(1),D_time' num2str(i,'%02d') ',' '''--+k'')']);
  end 
  for i = 31:40
     eval(['plot(label_v(2),D_time' num2str(i,'%02d') ',' '''--+k'')']);
  end 
   hold off
 ylabel('sec');
 xticks([]);

  subplot(2,2,4);
 hold on
 b=bar(label_v, velocity_mean_v, 0.2);
   b.FaceColor = 'flat';
 b.CData(1,:) = poor_co;
 b.CData(2,:) = slow_co;
 
  for i = 21:30
     eval(['plot(label_v(1),E_velocity' num2str(i,'%02d') ',' '''--+k'')']);
  end
  for i = 31:40
     eval(['plot(label_v(2),E_velocity' num2str(i,'%02d') ',' '''--+k'')']);
  end
 ylabel('cm/sec');
 xticks([]);
 hold off
 
 
 
 %%
 % 나중에 rank sum(유의확률)을 위해 모아놓는것.
 tm_good = [A_tm01 A_tm02 A_tm03 A_tm04 A_tm05 A_tm06 A_tm07 A_tm08 A_tm09 A_tm10];
 tm_moderate = [A_tm11 A_tm12 A_tm13 A_tm14 A_tm15 A_tm16 A_tm17 A_tm18 A_tm19 A_tm20];
 tm_poor = [A_tm21 A_tm22 A_tm23 A_tm24 A_tm25 A_tm26 A_tm27 A_tm28 A_tm29 A_tm30 ];
 tm_slow = [A_tm31 A_tm32 A_tm33 A_tm34 A_tm35 A_tm36 A_tm37 A_tm38 A_tm39 A_tm40 ];
 

 peak_good = [B_peak01 B_peak02 B_peak03 B_peak04 B_peak05 B_peak06 B_peak07 B_peak08 B_peak09 B_peak10 ];
 peak_moderate = [B_peak11 B_peak12 B_peak13 B_peak14 B_peak15 B_peak16 B_peak17 B_peak18 B_peak19 B_peak20 ];
 peak_poor = [B_peak21 B_peak22 B_peak23 B_peak24 B_peak25 B_peak26 B_peak27 B_peak28 B_peak29 B_peak30 ];
 peak_slow = [B_peak31 B_peak32 B_peak33 B_peak34 B_peak35 B_peak36 B_peak37 B_peak38 B_peak39 B_peak40 ];
 
 
 error_dis_good = [C_error_dis01 C_error_dis02 C_error_dis03 C_error_dis04 C_error_dis05 C_error_dis06 C_error_dis07 C_error_dis08 C_error_dis09 C_error_dis10 ];
 error_dis_moderate = [C_error_dis11 C_error_dis12 C_error_dis13 C_error_dis14 C_error_dis15 C_error_dis16 C_error_dis17 C_error_dis18 C_error_dis19 C_error_dis20];
 error_dis_poor = [C_error_dis21 C_error_dis22 C_error_dis23 C_error_dis24 C_error_dis25 C_error_dis26 C_error_dis27 C_error_dis28 C_error_dis29 C_error_dis30 ];
 error_dis_slow = [C_error_dis31 C_error_dis32 C_error_dis33 C_error_dis34 C_error_dis35 C_error_dis36 C_error_dis37 C_error_dis38 C_error_dis39 C_error_dis40 ];
 
 velocity_good = [E_velocity01 E_velocity02 E_velocity03 E_velocity04 E_velocity05 E_velocity06 E_velocity07 E_velocity08 E_velocity09 E_velocity10 ];
 velocity_moderate = [E_velocity11 E_velocity12 E_velocity13 E_velocity14 E_velocity15 E_velocity16 E_velocity17 E_velocity18 E_velocity19 E_velocity20 ];
 velocity_poor = [E_velocity21 E_velocity22 E_velocity23 E_velocity24 E_velocity25 E_velocity26 E_velocity27 E_velocity28 E_velocity29 E_velocity30 ];
 velocity_slow = [E_velocity31 E_velocity32 E_velocity33 E_velocity34 E_velocity35 E_velocity36 E_velocity37 E_velocity38 E_velocity39 E_velocity40 ];
 
 time_poor = [D_time21 D_time22 D_time23 D_time24 D_time25 D_time26 D_time27 D_time28 D_time29 D_time30];
 time_slow = [D_time31 D_time32 D_time33 D_time34 D_time35 D_time36 D_time37 D_time38 E_velocity39 E_velocity40 ];
 
 
 %%
 % 유의 확률 확인 
 %tm_p1의 값이 0.05이하 이면 괜찮고 이상이면 두 데이터가 비슷하다는 의미임.
 % 대부분 결과가 0.05이하 이므로 0.05이하 라는 뜻은 두 데이터가 의미가 있게 차이가 난다는 것임.
 tm_p1 = ranksum(tm_good, tm_moderate);
 tm_p2 = ranksum(tm_moderate, tm_poor);
 tm_p3 = ranksum(tm_good, tm_poor);
 ZZ_tm_p4 = ranksum(tm_poor, tm_slow);
 
 AA_tm_p = [0,0,0,0];
 if(tm_p1 <=0.05)
    AA_tm_p(1,1) =1;  
 end
 
 if(tm_p2 <=0.05)
    AA_tm_p(1,2) =1;  
 end
 
 if(tm_p3 <=0.05)
    AA_tm_p(1,3) =1;  
 end

 if(ZZ_tm_p4 <=0.05)
    AA_tm_p(1,4) =1;  
 end
 
 peak_p1 = ranksum(peak_good, peak_moderate);
 peak_p2 = ranksum(peak_moderate, peak_poor);
 peak_p3 = ranksum(peak_good, peak_poor);
 ZZ_peak_p4 = ranksum(peak_poor, peak_slow);
 
 AA_peak=[0,0,0,0];
 if(peak_p1 <=0.05)
    AA_peak(1,1) =1;  
 end
 
 if(peak_p2 <=0.05)
    AA_peak(1,2) =1;  
 end
 
 if(peak_p3 <=0.05)
    AA_peak(1,3) =1;  
 end
 
  if(ZZ_peak_p4 <=0.05)
    AA_peak(1,4) =1;  
 end
 
 error_dis_p1 = ranksum(error_dis_good, error_dis_moderate);
 error_dis_p2 = ranksum(error_dis_moderate, error_dis_poor);
 error_dis_p3 = ranksum(error_dis_good, error_dis_poor);
AA_error_dis=[0,0,0];
 if(error_dis_p1 <=0.05)
    AA_error_dis(1,1) =1;  
 end
 
 if(error_dis_p2 <=0.05)
    AA_error_dis(1,2) =1;  
 end
 
 if(error_dis_p3 <=0.05)
    AA_error_dis(1,3) =1;  
 end
 
  velocity_p1 = ranksum(velocity_good, velocity_moderate);
 velocity_p2 = ranksum(velocity_moderate, velocity_poor);
 ZZ_velocity_p3 = ranksum(velocity_poor,velocity_slow);
 
AA_velocity=[0,0,0];
 if(velocity_p1 <=0.05)
    AA_velocity(1,1) =1;  
 end
 
 if(velocity_p2 <=0.05)
    AA_velocity(1,2) =1;  
 end
 
 if(ZZ_velocity_p3 <=0.05)
    AA_velocity(1,3) =1;  
 end
 

ZZ_time_p1 = ranksum(velocity_poor,velocity_slow);
AA_time=0;
 if(ZZ_time_p1 <=0.05)
    AA_time =1;  
 end
 
 
  %% 논문 사진
%  low_x1 = lowpass(, 3, 60);
 base_l = ones(1,length(moderate_yp14)*10)*479;
 base_l(1)

 
 
 figure(5);
 %%%%%%%%%raw
 subplot(5,4,1); 
plot(base_l(1,10:1800),'-k')
axis equal
hold on 
plot(good_yp06,good_xp06,'Color',good_co)
hold off
%  title('Good');
xticks([]);
yticks([]);
% legend('Baseline','Good')


 subplot(5,4,2);
plot(base_l(1,10:1800),'-k')
axis equal
hold on 
plot(moderate_yp16,moderate_xp16,'Color',mod_co)
hold off
% title('Moderate');
xticks([]);
yticks([]);
% legend('Baseline','Moderate')

subplot(5,4,3);
plot(base_l(1,10:1800),'-k')
axis equal
hold on 
plot(poor_yp26,poor_xp26,'Color',poor_co)
hold off
% title('Poor');
xticks([]);
yticks([]);
% legend('Baseline','Poor')

subplot(5,4,4);
plot(base_l(1,10:1800),'-k')
axis equal
hold on 
plot(slow_yp36,slow_xp36,'Color',slow_co)
hold off
% title('Slow Movement');
xticks([]);
yticks([]);
% legend('Baseline','Good')


%%%%%%%raw(time)
 subplot(5,4,5); 
plot(base_l(1,1:511),'-k')
hold on 
plot(good_time06/1000,good_xp06,'Color',good_co)
hold off
% xlabel('time(msec)');
xlim([1 8.4]);
ylim([0 990])
% xticks([]);
yticks([]);
% legend('Baseline','Good')


subplot(5,4,6);
plot(base_l(1,1:end),'-k')
hold on 
plot(moderate_time16/1000,moderate_xp16,'Color',mod_co)
hold off
% xlabel('time(msec)');
xlim([1 4.8]);
ylim([0 990])
% xticks([]);
yticks([]);

% legend('Baseline','Moderate')

subplot(5,4,7);
plot(base_l(1,1:end),'-k')
hold on 
plot(poor_time26/1000,poor_xp26,'Color',poor_co)
hold off
% xlabel('time(msec)');
% xticks([]);
xlim([1 8.7]);
ylim([0 990])
yticks([]);

% legend('Baseline','Poor')

subplot(5,4,8);
plot(base_l(1,1:end),'-k')
hold on 
plot(slow_time36/1000,slow_xp36,'Color', slow_co)
hold off
% xlabel('time(msec)');
xlim([1 35]);
ylim([0 990])
% xticks([]);
yticks([]);
% legend('Baseline','Good'


%%%%%%%%LPF
low1 = lowpass(good_xp06,3,60);
low2 = lowpass(moderate_xp16,3,60);
low3 = lowpass(poor_xp26,3,60);
low4 = lowpass(slow_xp36,3,60);

subplot(5,4,9);
plot(base_l(1,10:end),'-k')
hold on 
% plot(pca_sig06);
plot(good_time06(1,5:end-5)/1000,low1(1,5:end-5),'Color',good_co);
hold off
xlim([1 8.4]);
ylim([0 990])
ylim([-250 1450]);
yticks([]);
xticks([]);
% legend('Baseline','Good')

subplot(5,4,10);
plot(base_l(1,10:end),'-k')
hold on 
% plot(pca_sig16);
plot(moderate_time16(1,5:end-5)/1000,low2(1,5:end-5),'Color',mod_co)
hold off
xlim([1 4.8]);
ylim([0 990])
yticks([]);
xticks([]);
% legend('Baseline','Moderate')

subplot(5,4,11);
plot(base_l(1,10:end),'-k')
hold on 

plot(poor_time26(1,5:end-5)/1000,low3(1,5:end-5),'Color',poor_co)
hold off
ylim([-250 1450]);
yticks([]);
xticks([]);
% legend('Baseline','Poor')
xlim([1 8.7]);
ylim([0 990])
subplot(5,4,12);
plot(base_l(1,10:end),'-k')
hold on 
plot(slow_time36(1,5:end-5)/1000,low4(1,5:end-5),'Color',slow_co)
hold off
xlim([1 35]);
ylim([0 990])
yticks([]);
xticks([]);
% legend('Baseline','Poor')

%%%%%%%%%%% FFT
subplot(5,4,13);
plot(fft_freq06,fft_result06,'Color',good_co);
hold on 
plot(fft_limitline06);
hold off
xlim([1 8]);
ylim([0 6]);
% xticks([]);
% legend('Baseline','Good')

subplot(5,4,14);
plot(fft_freq16,fft_result16,'Color',mod_co);
hold on 
plot(fft_limitline16);
hold off
xlim([1 8]);
ylim([0 6]);
% xticks([]);
% legend('Baseline','Moderate')

subplot(5,4,15);
plot(fft_freq26,fft_result26,'Color',poor_co);
hold on 
plot(fft_limitline26);
hold off
xlim([1 8]);
ylim([0 110]);
% legend('Baseline','Poor')

subplot(5,4,16);
plot(fft_freq34,fft_result34,'Color', slow_co);
hold on 
plot(fft_limitline34);
hold off
xlim([1 8]);
ylim([0 110]);
% xticks([]);
% legend('Baseline','Moderate')


%%%%%%%%%%%%hilbert
subplot(5,4,17);
plot(pca_sig06,'Color',good_co)
hold on 
plot(envelope(pca_sig06),'Color',[0.4940 0.1840 0.5560])
hold off
ylim([-350 350])
xlim([100 300])
xticks([]);
yticks([-350  0  350]);
% legend({'Baseline','Good'},'FontSize',4);

subplot(5,4,18);
plot(pca_sig16,'Color',mod_co)
hold on 
plot(envelope(pca_sig16),'Color',[0.4940 0.1840 0.5560])
hold off
ylim([-350 350])
xlim([100 300])
xticks([]);
yticks([-350  0  350]);
% legend('Baseline','Moderate')

subplot(5,4,19);
plot(pca_sig26,'Color',poor_co)
hold on 
plot(envelope(pca_sig26),'Color',[0.4940 0.1840 0.5560])
hold off
ylim([-350 350])
xlim([100 300])
xticks([]);
yticks([-350  0  350]);
% legend('Baseline','Poor')

subplot(5,4,20);
plot(pca_sig36,'Color',slow_co)
hold on 
plot(envelope(pca_sig36),'Color',[0.4940 0.1840 0.5560])
hold off
ylim([-350 350])
xlim([100 300])
xticks([]);
yticks([-350  0  350]);
% legend('Baseline','Poor')

%% 
%%%%%%%%%%% slow
figure();
subplot(4,1,1);
plot(base_l(1,10:1800))
axis equal
hold on 
plot(slow_yp36,slow_xp36)
hold off
% title('Good');
xticks([]);
% legend('Baseline','Good')

subplot(4,1,2);
plot(base_l(1,10:end))
axis equal
hold on 
plot(slow_time36,slow_xp36)
hold off
% title('Good');
ylim([0 960]);
xticks([]);
% legend('Baseline','Good'

subplot(4,1,3);
plot(fft_freq34,fft_result34);
hold on 
plot(fft_limitline34);
hold off
xlim([1 30]);
ylim([0 70]);
% xticks([]);
% legend('Baseline','Moderate')

subplot(4,1,4);
plot(pca_sig36)
hold on 
plot(envelope(pca_sig36))
hold off
ylim([-500 500])
xlim([100 300])
xticks([]);
yticks([-400 -200  0  200  400]);
% legend('Baseline','Poor')

