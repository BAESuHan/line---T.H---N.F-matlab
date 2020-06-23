function [TM] = TM_function(pca_signal)

    %function [TM] = TM_function(pca_signal)
    %
    % pca_signal : signal after PCA it should be 1D
    % TM : Tremor Magnitude
    
    sig_env = envelope(pca_signal);
    TM = mean(sig_env)/85.039370079;