%====================================================
% Handong global university electronic engineering Bae SH
% DATE : 2020.06.22
% for nose to finger test quantification  

%=====================================================

close all;
clear;

fs = 60;
cutoff=[3 12];
% cutoff=3;
%% good file read

for idx=1:10
    eval(['good' num2str(idx,'%02d') '= ''C:\Users\qotng\Desktop\GPG\매틀랩\기어_TH_0406\good\good(' num2str(idx,'%02d') ').json'';']);
    eval(['fid' num2str(idx,'%02d') '= fopen(good' num2str(idx,'%02d') ',''r'');']);
    eval(['str' num2str(idx,'%02d') '= fread(fid' num2str(idx,'%02d') ',''*char'')'';']);
    eval(['fclose(fid' num2str(idx,'%02d') ');']);
    eval(['J_good' num2str(idx,'%02d') '= jsondecode(str' num2str(idx,'%02d') ');']);
    eval(['good_sum' num2str(idx,'%02d') '= J_good' num2str(idx,'%02d') '.' 'sum'';']);
    % 입력시 초기 20샘플은 날려줘야함
    eval(['good_sum' num2str(idx,'%02d') '= good_sum' num2str(idx,'%02d') '(1,20:end);']);
    %Time - 처음과 마지막의 시간을 2초 정도 빼준다
    eval(['A_good_time' num2str(idx,'%02d') '= J_good' num2str(idx,'%02d') '.' 'time-2'';']);
end

%time setting
for idx=1:10
    eval(['good_time' num2str(idx,'%02d') '=linspace(0,A_good_time' num2str(idx,'%02d') ',length(good_sum' num2str(idx,'%02d') '));']);
end

%% poor file read


for idx=1:10
    eval(['poor' num2str(idx,'%02d') '= ''C:\Users\qotng\Desktop\GPG\매틀랩\기어_TH_0406\poor\poor(' num2str(idx,'%02d') ').json'';']);
    eval(['fid' num2str(idx,'%02d') '= fopen(poor' num2str(idx,'%02d') ',''r'');']);
    eval(['str' num2str(idx,'%02d') '= fread(fid' num2str(idx,'%02d') ',''*char'')'';']);
    eval(['fclose(fid' num2str(idx,'%02d') ');']);
    eval(['J_poor' num2str(idx,'%02d') '= jsondecode(str' num2str(idx,'%02d') ');']);
    eval(['poor_sum' num2str(idx,'%02d') '= J_poor' num2str(idx,'%02d') '.' 'sum'';']);
    % 입력시 초기 20샘플은 날려줘야함
    eval(['poor_sum' num2str(idx,'%02d') '= poor_sum' num2str(idx,'%02d') '(1,20:end);']);
    %Time - 처음과 마지막의 시간을 2초 정도 빼준다
    eval(['B_poor_time' num2str(idx,'%02d') '= J_poor' num2str(idx,'%02d') '.' 'time-2'';']);
end

%time setting
for idx=1:10
    eval(['good_time' num2str(idx,'%02d') '=linspace(0,A_good_time' num2str(idx,'%02d') ',length(good_sum' num2str(idx,'%02d') '));']);
    eval(['poor_time' num2str(idx,'%02d') '=linspace(0,B_poor_time' num2str(idx,'%02d') ',length(poor_sum' num2str(idx,'%02d') '));']);
end

%% Normalize
for idx=1:10
    eval(['good_n_sum' num2str(idx,'%02d') '=normalize(good_sum' num2str(idx,'%02d') ');']);
    eval(['poor_n_sum' num2str(idx,'%02d') '=normalize(poor_sum' num2str(idx,'%02d') ');']);
end

%% TEST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for idx=1:10
    eval(['good_low_n' num2str(idx,'%02d') '=lowpass(good_n_sum' num2str(idx,'%02d') ',6,fs);']);
    eval(['poor_low_n' num2str(idx,'%02d') '=lowpass(poor_n_sum' num2str(idx,'%02d') ',6,fs);']);
end

for idx=1:10
    eval(['good_band_n' num2str(idx,'%02d') '=good_n_sum' num2str(idx,'%02d') '-good_low_n' num2str(idx,'%02d') ';']);
    eval(['poor_band_n' num2str(idx,'%02d') '=poor_n_sum' num2str(idx,'%02d') '-poor_low_n' num2str(idx,'%02d') ';']);
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% BPF 3~25Hz
% for idx=1:10
%     eval(['good_band_n' num2str(idx,'%02d') '=bandpass(good_n_sum' num2str(idx,'%02d') ',cutoff,fs);']);
%     eval(['poor_band_n' num2str(idx,'%02d') '=bandpass(poor_n_sum' num2str(idx,'%02d') ',cutoff,fs);']);
% end
% 



%% FFT & find TF
for idx=1:10
    eval(['[good_fft_band' num2str(idx,'%02d') ',good_freq' num2str(idx,'%02d') ']=tremor_fft(good_band_n' num2str(idx,'%02d') ',fs);']);
    eval(['good_fft_band' num2str(idx,'%02d') ' =smoothdata(good_fft_band' num2str(idx,'%02d') ',''gaussian'',7);']);
    eval(['A_good_TF' num2str(idx,'%02d') '=findfftPeak(good_fft_band' num2str(idx,'%02d') ',good_freq' num2str(idx,'%02d') ');']);
    
    eval(['[poor_fft_band' num2str(idx,'%02d') ',poor_freq' num2str(idx,'%02d') ']=tremor_fft(poor_band_n' num2str(idx,'%02d') ',fs);']);
    eval(['poor_fft_band' num2str(idx,'%02d') ' =smoothdata(poor_fft_band' num2str(idx,'%02d') ',''gaussian'',7);']);
    eval(['B_poor_TF' num2str(idx,'%02d') '=findfftPeak(poor_fft_band' num2str(idx,'%02d') ',poor_freq' num2str(idx,'%02d') ');']);
end

%% TM
for idx=1:10
    eval(['good_envel' num2str(idx,'%02d') '=envelope(good_band_n' num2str(idx,'%02d') ');']);
    eval(['A_good_TM' num2str(idx,'%02d') '=mean(good_envel' num2str(idx,'%02d') ');']);
    
    eval(['poor_envel' num2str(idx,'%02d') '=envelope(poor_band_n' num2str(idx,'%02d') ');']);
    eval(['B_poor_TM' num2str(idx,'%02d') '=mean(poor_envel' num2str(idx,'%02d') ');']);
end

%% Smoothing
for idx=1:10
    %good - 30 sample
    eval(['good_smo' num2str(idx,'%02d') '=smoothdata(good_n_sum' num2str(idx,'%02d') ',''gaussian'',30);']);
    
    %good - 40 sample
    eval(['poor_smo' num2str(idx,'%02d') '=smoothdata(poor_n_sum' num2str(idx,'%02d') ',''gaussian'',40);']);
end


%% Counting
for idx=1:10
    eval(['A_good_CNT' num2str(idx,'%02d') '=findPeakcount(good_smo' num2str(idx,'%02d') ');']);
    
    eval(['B_poor_CNT' num2str(idx,'%02d') '=findPeakcount(poor_smo' num2str(idx,'%02d') ');']);
end

%% Period
for idx=1:10
    eval(['A_good_Period' num2str(idx,'%02d') '=A_good_time' num2str(idx,'%02d') '/A_good_CNT' num2str(idx,'%02d') ';']);
    
    eval(['B_poor_Period' num2str(idx,'%02d') '=B_poor_time' num2str(idx,'%02d') '/B_poor_CNT' num2str(idx,'%02d') ';']);
end

%% findpeak function


for idx=1:10
    eval(['[good_hp' num2str(idx,'%02d') ',good_hp_idx' num2str(idx,'%02d') ']=islocalmin(good_smo' num2str(idx,'%02d') ',''MinSeparation'',52);']);
    
    eval(['[poor_hp' num2str(idx,'%02d') ',poor_hp_idx' num2str(idx,'%02d') ']=islocalmin(poor_smo' num2str(idx,'%02d') ',''MinSeparation'',52);']);
end


%% TM mean

sum = 0;
for idx = 1:10
     eval(['sum = sum + A_good_TM' num2str(idx,'%02d') ';' ]);
end
tm_good_mean = sum / 10;

sum = 0;
for idx = 1:10
     eval(['sum = sum + B_poor_TM' num2str(idx,'%02d') ';' ]);
end
tm_poor_mean = sum / 10;

tm_mean = [tm_good_mean  tm_poor_mean];
    
%% TF means   
sum = 0;
for idx = 1:10
    eval(['sum = sum + A_good_TF' num2str(idx,'%02d') ';' ]);
end
tf_good_mean = sum / 10;

sum = 0;
for idx = 1:10
    eval(['sum = sum + B_poor_TF' num2str(idx,'%02d') ';' ]);
end
tf_poor_mean = sum / 10;

tf_mean = [tf_good_mean  tf_poor_mean];

%% Count means   
sum = 0;
for idx = 1:10
    eval(['sum = sum + A_good_CNT' num2str(idx,'%02d') ';' ]);
end
cnt_good_mean = sum / 10;
    
sum = 0;
for idx = 1:10
    eval(['sum = sum + B_poor_CNT' num2str(idx,'%02d') ';' ]);
end
cnt_poor_mean = sum / 10;

cnt_mean = [cnt_good_mean  cnt_poor_mean];
%% Time means   
sum = 0;
for idx = 1:10
    eval(['sum = sum + A_good_time' num2str(idx,'%02d') ';' ]);
end
time_good_mean = sum / 10;

sum = 0;
for idx = 1:10
    eval(['sum = sum + B_poor_time' num2str(idx,'%02d') ';' ]);
end
time_poor_mean = sum / 10;
    
time_mean = [time_good_mean  time_poor_mean];
%% Period means   
sum = 0;
for idx = 1:10
    eval(['sum = sum + A_good_Period' num2str(idx,'%02d') ';' ]);
end
Period_good_mean = sum / 10;

sum = 0;
for idx = 1:10
    eval(['sum = sum + B_poor_Period' num2str(idx,'%02d') ';' ]);
end
Period_poor_mean = sum / 10;

Period_mean = [Period_good_mean  Period_poor_mean];

%% rank sum
 tm_good = [A_good_TM01 A_good_TM02 A_good_TM03 A_good_TM04 A_good_TM05 A_good_TM06 A_good_TM07 A_good_TM08 A_good_TM09 A_good_TM10];
 tm_poor = [B_poor_TM01 B_poor_TM02 B_poor_TM03 B_poor_TM04 B_poor_TM05 B_poor_TM06 B_poor_TM07 B_poor_TM08 B_poor_TM09 B_poor_TM10];
 
 
 tf_good = [A_good_TF01 A_good_TF02 A_good_TF03 A_good_TF04 A_good_TF05 A_good_TF06 A_good_TF07 A_good_TF08 A_good_TF09 A_good_TF10];
 tf_poor = [B_poor_TF01 B_poor_TF02 B_poor_TF03 B_poor_TF04 B_poor_TF05 B_poor_TF06 B_poor_TF07 B_poor_TF08 B_poor_TF09 B_poor_TF10];
 
Period_good = [A_good_Period01 A_good_Period02 A_good_Period03 A_good_Period04 A_good_Period05 A_good_Period06 A_good_Period07 A_good_Period08 A_good_Period09 A_good_Period10];
Period_poor = [B_poor_Period01 B_poor_Period02 B_poor_Period03 B_poor_Period04 B_poor_Period05 B_poor_Period06 B_poor_Period07 B_poor_Period08 B_poor_Period09 B_poor_Period10];
 

 tm_p = ranksum(tm_good, tm_poor);
 AA_tm_p = 0;

 if(tm_p <=0.05)
    AA_tm_p =1;  
 end

 
 tf_p = ranksum(tf_good, tf_poor);
 AA_tf_p = 0;

 if(tf_p <=0.05)
    AA_tf_p =1;  
 end

 
  Period_p = ranksum(Period_good, Period_poor);
 AA_Period_p = 0;

 if(Period_p <=0.05)
    AA_Period_p =1;  
 end



%% Raw data plot
figure();
for idx=1:10
    subplot(5,2,idx)
    eval(['plotData(good_time' num2str(idx,'%02d') ', good_sum' num2str(idx,'%02d') ');']);
    eval(['title(''Good ' num2str(idx,'%02d') ' Raw'');']);
end

figure();
for idx=1:10
    subplot(5,2,idx)
    eval(['plotData(poor_time' num2str(idx,'%02d') ', poor_sum' num2str(idx,'%02d') ');']);
    eval(['title(''Poor ' num2str(idx,'%02d') ' Raw'');']);
end

%% BPF data plot
% figure();
% for idx=1:10
%     subplot(5,2,idx)
%     eval(['plotData(good_time' num2str(idx,'%02d') ', good_envel' num2str(idx,'%02d') ');']);
%     eval(['title(''Good ' num2str(idx,'%02d') ' Env'');']);
% end
% 
% figure();
% for idx=1:10
%     subplot(5,2,idx)
%     eval(['plotData(poor_time' num2str(idx,'%02d') ', poor_envel' num2str(idx,'%02d') ');']);
%     eval(['title(''Poor ' num2str(idx,'%02d') ' Env'');']);
% end
% 
% figure();
% for idx=1:10
%     subplot(5,2,idx)
%     eval(['plotData(good_freq' num2str(idx,'%02d') ', good_fft_band' num2str(idx,'%02d') ');']);
%     eval(['title(''Good ' num2str(idx,'%02d') ' FFT'');']);
% end
% 
% figure();
% for idx=1:10
%     subplot(5,2,idx)
%     eval(['plotData(poor_freq' num2str(idx,'%02d') ', poor_fft_band' num2str(idx,'%02d') ');']);
%     eval(['title(''Poor ' num2str(idx,'%02d') ' FFT'');']);
% end

%% mean plot

good_co = [0    0.4471    0.7412];
 poor_co = [1.0000    0.4627    0.3804];


label = categorical({'Good','Poor'});
% label = categorical({'Good'});
figure();
 subplot(1,3,1);
 hold on
 b=bar(label, tm_mean, 0.3);
   b.FaceColor = 'flat'; 
b.CData(1,:) = good_co;
 b.CData(2,:) = poor_co;
 for i = 1:10
     eval(['plot(label(1),A_good_TM' num2str(i,'%02d') ',' '''--+r'')']);
 end
 for i = 1:10
     eval(['plot(label(2),B_poor_TM' num2str(i,'%02d') ',' '''--+r'')']);
 end
 ylabel('cm/sec^2');
%  xlabel('TM');

 hold off
 
 subplot(1,3,2);
 hold on
 b=bar(label, tf_mean, 0.3);
   b.FaceColor = 'flat'; 
b.CData(1,:) = good_co;
 b.CData(2,:) = poor_co;
 
 for i = 1:10
     eval(['plot(label(1),A_good_TF' num2str(i,'%02d') ',' '''--+r'')']);
 end
 for i = 1:10
     eval(['plot(label(2),B_poor_TF' num2str(i,'%02d') ',' '''--+r'')']);
 end
 ylabel('Hz');
%  xlabel('TF');
 hold off

 
 subplot(1,3,3);
 hold on
 b=bar(label, Period_mean, 0.3);
   b.FaceColor = 'flat'; 
b.CData(1,:) = good_co;
 b.CData(2,:) = poor_co;
 
 for i = 1:10
     eval(['plot(label(1),A_good_Period' num2str(i,'%02d') ',' '''--+r'')']);
 end
 for i = 1:10
     eval(['plot(label(2),B_poor_Period' num2str(i,'%02d') ',' '''--+r'')']);
 end
 ylabel('time/peak');
%  xlabel('Period');
 hold off
 
 
  %% 
 figure();
 
  %good
 subplot(5,2,1);
%  plot(good_time03,good_sum03);
plot(good_time03,good_n_sum03,'Color',good_co);
 ylim([-2 2])  
 xticks([]);
%  yticks([]);

 subplot(5,2,5);
 plot(good_time03,good_band_n03,'Color',good_co);
  ylim([-0.5 0.5])
yticks([]);
 subplot(5,2,3);
 plot(good_time03,good_smo03,'Color',good_co);
 hold on
 plot(good_time03(good_hp03),good_smo03(good_hp03),'ok');
 ylim([-1.7 1.5])
 yticks([]);
 
 [pk,MaxFreq] = findpeaks(good_fft_band03,'NPeaks',1,'SortStr','descend');
 
  subplot(5,2,9);
 plot(good_freq03,good_fft_band03,'Color',good_co);
 hold on
 plot(good_freq03(MaxFreq),pk,'ok');
 hold off
 ylim([0 0.04])
%   xlabel('f(Hz)')
 
 subplot(5,2,7);
 plot(good_time03,good_band_n03,'Color',good_co);
 hold on
 plot(good_time03,good_envel03,'Color',[0.4940 0.1840 0.5560]);
 ylim([-0.9 0.9])
 xticks([]);

 
 
 %%%poor
 subplot(5,2,2);
%  plot(poor_time03,poor_sum03);
 plot(poor_time03,poor_n_sum03,'Color',poor_co);
 ylim([-2 2])
 xlim([0 18])
 xticks([]);
 
  subplot(5,2,6);
 plot(poor_time03,poor_band_n03,'Color',poor_co);
   ylim([-0.5 0.5])
   xlim([0 18])
   yticks([]);
   
  subplot(5,2,4);
 plot(poor_time03,poor_smo03,'Color',poor_co);
 hold on
 plot(poor_time03(poor_hp03),poor_smo03(poor_hp03),'ok');
 ylim([-1.5 1.5])
 xlim([0 18])
yticks([]);
 
 [pk,MaxFreq] = findpeaks(poor_fft_band03,'NPeaks',1,'SortStr','descend');
   subplot(5,2,10);
 plot(poor_freq03,poor_fft_band03,'Color',poor_co);
  hold on
 plot(poor_freq03(MaxFreq),pk,'ok');
 hold off
  ylim([0 0.04])
%   xlabel('f(Hz)')

 subplot(5,2,8);
 plot(poor_time03,poor_band_n03,'Color',poor_co);
 hold on
 plot(poor_time03,poor_envel03,'Color',[0.4940 0.1840 0.5560]);
  ylim([-0.9 0.9])
 xlim([0 18])
 xticks([]);
 
 
 
function peak = findfftPeak(fft_sum,freq)
    smooth_fft=smoothdata(fft_sum,'gaussian',7);
    [~,index_fft_sum]=max(smooth_fft);
    peak=freq(index_fft_sum);
end

function cnt = findPeakcount(smooth_data)
    [LP,LP_p] = islocalmin(smooth_data,'MinSeparation',40);
    found_low=0;
    f_n_cnt=0;
    idx=0;
    for i=1:length(LP)
        if((LP(1,i)==1))
            if(smooth_data(1,i)>=0)
                idx=idx+1; 
            else
                found_low=1;
                idx=idx+1;
            end 
            if(idx>nnz(LP))
                idx=nnz(LP); 
            end
        end
    
        if(found_low==1)
            f_n_cnt=f_n_cnt+1;
            found_low=0;
        end
    end
    cnt=f_n_cnt;
end

function plotData(time,data)
    plot(time,data);
end
