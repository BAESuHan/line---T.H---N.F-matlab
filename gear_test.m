close all;
clear;
%%
%read data
filename = 'C:\Users\qotng\Desktop\GPG\매틀랩\기어_TH_0406\gear-transfer-task-export (2).json';

%read json file
fid = fopen(filename, 'r');

str = fread(fid,'*char').';

fclose(fid);

J = jsondecode(str);


% x,y,z 축 raw 값으로 받고싶으면 tizen에서 수정하시면 됩니다
%20.06.22 현재 tizen에서는 sum 값으로 전송하게 뒀습니다.
% yp=J.yp';
% xp=J.xp';
% zp=J.zp';

sum = J.sum';
sum=sum(1,20:end);


% 여러 시나리오를 비교하기 위해서 normalize
n_sum = normalize(sum);


%자바에서 사용한 smoothing - 자바랑 매틀랩이랑 비슷하게 깎으려고 경험적 실험...
java_smooth=J.smoothsum';

%자바에서 사용한 peak 찾기
java_peak_contents = J.cnttask';
java_peak_cnt = nnz(java_peak_contents);

%어플 전체 사용시간인데 , 시작과 끝을 지을때 3초 정도 더 걸린듯해서 임의로 뺐음
A_time = J.time-3;
time=linspace(0,A_time,length(sum));

%sampling rate 은 60으로 고정 
fs = 60;


cutoff_freq=[8 25];
cutoff_high=4;
low_freq= 3;
plot_param = {'Color', [0.6 0.1 0.2],'Linewidth',2};

%%
% xyz 따로 받을때 test 
% lx=lowpass(xp,3,fs);
% ly=lowpass(yp,3,fs);
% lz=lowpass(zp,3,fs);

% sum= xp+yp+zp;
% sum= lx+ly+lp;

% figure();
% plot(time,lx);
% hold on
% plot(time,ly);
% plot(time,lz);
% hold off

% highpass(n_sum,0.1,fs);

% band_sum = bandpass(n_sum,cutoff_freq,fs);


%매틀랩에서 사용하는 필터가 안좋은거 같아서 다른 방법을 사용 
%이론상으로는 HPF한 data = Raw data - LPF한 data 임! 그거를 사용
%실험상 cut off freq.가 6이상이어야했는데 내가 측정을 잘못한거일수도! 다시해보세열
band_sum = highpass(n_sum,6,fs);
low_sum = lowpass(n_sum,6,fs);

test_fil=n_sum-low_sum;

figure();
plot(n_sum-low_sum);
hold on
plot(band_sum);
legend('nor-low ','high');
title('cutoff freq : 4Hz')

% test용으로 둔건데 correlation 계수 한번 뽑아봤어요 비슷한지
A_corr = corrcoef(n_sum-low_sum,band_sum);

%FFT - 외장 함수 확인
[fft_sum,freq]=tremor_fft(band_sum,fs);

% 매틀랩 기본 함수로 주어지는 smoothing
% FFT결과가 너무 잡음이 많은거 같아서 fft 결과에도 7샘플씩 smoothing 
smooth_fft=smoothdata(fft_sum,'gaussian',7);
[max_fft_sum,index_fft_sum]=max(smooth_fft);
A_TremorFreq=freq(index_fft_sum);


envelope_sum=envelope(test_fil);
A_TM_envelope_sum=mean(envelope_sum);

% 표준화 한 데이터 30샘플씩 smooting
smooting = smoothdata(n_sum,'gaussian',30);


%smoothing 데이터  확인용
% figure();
% plot(time,n_sum);
% hold on
% plot(time,smooting);
% legend('normal','smooth');
% title('normalized signal & smoothing')
% xlabel('Time(s)')

gap_cnt = 0;


%islocalmin은 최저값(뒤에서는 min peak라고 부를 예정)을 연속적으로 찾아주는 값임 - 손바닥 뒤집기용
%findpeaks는 최대값을 연속적으로 찾아줌 - 코 - 손가락 가리키기용
LP_cnt=0;
[LP,LP_p] = islocalmin(smooting(1,1:end-20),'MinSeparation',50);
[HP,HP_p]=findpeaks(smooting,'MinPeakDistance',30);

idx=1;
found_high=0;
found_low=0;
f_n_cnt=0;

%peak가 몇개인지 찾아줌 - 코 - 손가락 가리키기용
for i=1:length(LP)
   if((HP_p(1,idx)==i))
       if(smooting(1,i)<=0.5)
          idx=idx+1; 
       else
          found_high=1;
          idx=idx+1;
       end 
       if(idx>length(HP_p))
          idx=length(HP_p); 
       end
   end
    
   if(found_high==1)
       f_n_cnt=f_n_cnt+1;
       found_high=0;
   end
end

% min peak가 몇개인지 알려줌 - 손바닥 뒤집기용
% idx=0;
% for i=1:length(LP)
%    if((LP(1,i)==1))
%        if(filgau_3(1,i)>=0)
%           idx=idx+1; 
%        else
%           found_low=1;
%           idx=idx+1;
%        end 
%        if(idx>nnz(LP))
%           idx=nnz(LP); 
%        end
%    end
%     
%    if(found_low==1)
%        f_n_cnt=f_n_cnt+1;
%        found_low=0;
%    end
% end


%% 
%자바에서 가벼온 값이 매틀랩값과 어떤지 비교하기위해서 
A_mat_cnt=f_n_cnt;
B_java_cnt=java_peak_cnt;

A_period = A_time/A_mat_cnt; 


%% java와 비교 plot용
% figure();
% subplot(2,1,1);
% plot(time,sum);
% % hold on
% % plot(time,java_sum);
% % hold off
% title('rawSum   ')
% xlabel('time(s)');
% ylabel('Amplitude');
% % legend('mat','java')
% 
% subplot(2,1,2);
% plot(time,filgau_3);
% hold on
% plot(time,java_smooth);
% % plot(time,one);
% hold off
% title('smooth - java,mat  ')
% xlabel('time(s)');
% ylabel('Amplitude');
% legend('mat','java')
% 



%% Plot
figure();
subplot(2,1,1);
plot(freq,smooth_fft);
title('FFT of tremor');
xlabel('Hz');

subplot(2,1,2);
plot(time,envelope_sum);
grid();
title('Hilbert Transform of tremor');
xlabel('Time(s)')

%% 논문 plot

% raw data
% figure(); 
% plot(time,sum); title('Raw data');
% ylabel('Amplitude'); xlabel('Time(s)');

% normalize
% figure(); 
% plot(time,n_sum); title('Normalized raw data');
% ylabel('Amplitude'); xlabel('Time(s)');

% %smoothing
% figure(); 
% plot(time,filgau_3); title('Smoothing of normalized data : 30 samples');
% ylabel('Amplitude'); xlabel('Time(s)');


% %find peak 1 
% figure(); 
% plot(time,filgau_3); title('Smoothing of normalized data : 30 samples');
% ylabel('Amplitude'); xlabel('Time(s)');
% hold on 
% plot(time,one,plot_param{:});

% %islocalmin
% figure(); 
% plot(time,filgau_3,time(LP),filgau_3(LP),'rp','MarkerSize',12,'MarkerFaceColor','red'); title('Find minimum peak of Smoothing data');
% ylabel('Amplitude'); xlabel('Time(s)');
% hold on 
% plot(time,one,plot_param{:});

% %HPF
% figure(); 
% plot(time,band_sum);
% title('HPF(cutoff : 3Hz) of normalized data ');
% xlabel('Time(s)');
% ylabel('Amplitude')
% 
% 
% %FFT
% figure(); 
% plot(freq,smooth_fft,freq(index_fft_sum),smooth_fft(index_fft_sum),'rp','MarkerSize',12,'MarkerFaceColor','red');
% title('FFT of tremor');
% xlabel('Hz');
% ylabel('Amplitude')
% ylim([0 0.027])

% xx=abs(hilbert(band_sum));
% 
% %Hilbert
% figure(); 
% plot(time,envelope_sum);
% title('Hilbert Transform of tremor ');
% xlabel('Time(s)');
% ylabel('Amplitude')


