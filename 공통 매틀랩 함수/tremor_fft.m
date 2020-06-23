function [fft_spectrum, frequency] = tremor_fft(filtered_data,fs)
fft_result=fft(filtered_data);
N=length(filtered_data); 
n=0:N-1;
f=fs*n/N;

cutoff=ceil(N/2);
fft_result=fft_result(1:cutoff);
f=f(1:cutoff); 
fft_spectrum=2*abs(fft_result)/N;
frequency=f;


