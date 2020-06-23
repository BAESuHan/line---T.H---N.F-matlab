function [max_freq,line_fft_result,line_f,limitline] = peak_function(pca_signal)

fs = 60;
[line_fft_result,line_f]=tremor_fft(pca_signal,fs);

m_index = find(line_f>=10 & line_f<=25);

power_mean = mean(line_fft_result(m_index));
power_std = std(line_fft_result(m_index));

label = cell(62,1);

for idx = 1:80
    label{idx} = ones(1,(length(line_f)))*(power_mean + idx*power_std);
end

[~, max_idx] = max(line_fft_result);

limitline=label{40};

if line_fft_result(max_idx) > label{40}
    if abs(line_f(max_idx)) > 3.2
        max_freq = abs(line_f(max_idx));
    else
        max_freq = 0;
    end
else
    max_freq = 0;
end

% %plot part
%  figure()
%  plot(line_f, line_fft_result, line_f, label{20}, line_f, label{40}, line_f,label{60}, line_f,label{70});

