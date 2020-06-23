function [pca_signal] = pca_function(inputx, inputy)

% fucntion [pca_signal] = pca_function(inputx, inputy)
%
% inputx :position x
% inputy :position y
% band_xy : after bandpass filter x and y, vercat(bandx, bandy)
% cut_off : cut off frequency
% band_x : x after BPF
% band_y : y after BPF
% fs: smapling rate

cut_off = [3 15];
fs = 60;

band_x = bandpass(inputx, cut_off, fs);
band_y = bandpass(inputy, cut_off, fs);

band_xy = vertcat(band_x, band_y);

Csig = band_xy * band_xy'; %Covariance
[V, ~] = eig(Csig); %eigenvector
W = V(:,end); %weight
pca_signal = W'*band_xy; %projection