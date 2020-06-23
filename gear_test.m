close all;
clear;
%%
%read data
filename = 'C:\Users\qotng\Desktop\GPG\��Ʋ��\���_TH_0406\gear-transfer-task-export (2).json';

%read json file
fid = fopen(filename, 'r');

str = fread(fid,'*char').';

fclose(fid);

J = jsondecode(str);


% x,y,z �� raw ������ �ް������ tizen���� �����Ͻø� �˴ϴ�
%20.06.22 ���� tizen������ sum ������ �����ϰ� �׽��ϴ�.
% yp=J.yp';
% xp=J.xp';
% zp=J.zp';

sum = J.sum';
sum=sum(1,20:end);


% ���� �ó������� ���ϱ� ���ؼ� normalize
n_sum = normalize(sum);


%�ڹٿ��� ����� smoothing - �ڹٶ� ��Ʋ���̶� ����ϰ� �������� ������ ����...
java_smooth=J.smoothsum';

%�ڹٿ��� ����� peak ã��
java_peak_contents = J.cnttask';
java_peak_cnt = nnz(java_peak_contents);

%���� ��ü ���ð��ε� , ���۰� ���� ������ 3�� ���� �� �ɸ����ؼ� ���Ƿ� ����
A_time = J.time-3;
time=linspace(0,A_time,length(sum));

%sampling rate �� 60���� ���� 
fs = 60;


cutoff_freq=[8 25];
cutoff_high=4;
low_freq= 3;
plot_param = {'Color', [0.6 0.1 0.2],'Linewidth',2};

%%
% xyz ���� ������ test 
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


%��Ʋ������ ����ϴ� ���Ͱ� �������� ���Ƽ� �ٸ� ����� ��� 
%�̷л����δ� HPF�� data = Raw data - LPF�� data ��! �װŸ� ���
%����� cut off freq.�� 6�̻��̾���ߴµ� ���� ������ �߸��Ѱ��ϼ���! �ٽ��غ�����
band_sum = highpass(n_sum,6,fs);
low_sum = lowpass(n_sum,6,fs);

test_fil=n_sum-low_sum;

figure();
plot(n_sum-low_sum);
hold on
plot(band_sum);
legend('nor-low ','high');
title('cutoff freq : 4Hz')

% test������ �аǵ� correlation ��� �ѹ� �̾ƺþ�� �������
A_corr = corrcoef(n_sum-low_sum,band_sum);

%FFT - ���� �Լ� Ȯ��
[fft_sum,freq]=tremor_fft(band_sum,fs);

% ��Ʋ�� �⺻ �Լ��� �־����� smoothing
% FFT����� �ʹ� ������ ������ ���Ƽ� fft ������� 7���þ� smoothing 
smooth_fft=smoothdata(fft_sum,'gaussian',7);
[max_fft_sum,index_fft_sum]=max(smooth_fft);
A_TremorFreq=freq(index_fft_sum);


envelope_sum=envelope(test_fil);
A_TM_envelope_sum=mean(envelope_sum);

% ǥ��ȭ �� ������ 30���þ� smooting
smooting = smoothdata(n_sum,'gaussian',30);


%smoothing ������  Ȯ�ο�
% figure();
% plot(time,n_sum);
% hold on
% plot(time,smooting);
% legend('normal','smooth');
% title('normalized signal & smoothing')
% xlabel('Time(s)')

gap_cnt = 0;


%islocalmin�� ������(�ڿ����� min peak��� �θ� ����)�� ���������� ã���ִ� ���� - �չٴ� �������
%findpeaks�� �ִ밪�� ���������� ã���� - �� - �հ��� ����Ű���
LP_cnt=0;
[LP,LP_p] = islocalmin(smooting(1,1:end-20),'MinSeparation',50);
[HP,HP_p]=findpeaks(smooting,'MinPeakDistance',30);

idx=1;
found_high=0;
found_low=0;
f_n_cnt=0;

%peak�� ����� ã���� - �� - �հ��� ����Ű���
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

% min peak�� ����� �˷��� - �չٴ� �������
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
%�ڹٿ��� ������ ���� ��Ʋ������ ��� ���ϱ����ؼ� 
A_mat_cnt=f_n_cnt;
B_java_cnt=java_peak_cnt;

A_period = A_time/A_mat_cnt; 


%% java�� �� plot��
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

%% �� plot

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


