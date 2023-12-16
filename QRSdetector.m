%load('Gabor_ECG.mat','ECG');
% ECG = load('16265m.mat');
% ECG=struct2array(ECG);

function [locs_Rmax]=QRSdetector(filename,fs)

load(filename, 'val')
N=3;
flow=5.0;
fhigh=15.0;


% Bandpass filter
[b, a] = butter(N, [flow,fhigh] / (fs / 2), 'bandpass');
ECG_filt=filtfilt(b,a,val);

%Diff
ECG_diff=diff(ECG_filt);

%Squaring
sqrd_ECG=ECG_diff .^2;

%Moving window
win_length = round(0.150*fs);
ECG_integrated = movmean(sqrd_ECG, win_length);

%Adaptive thresholding

threshold = 0.5 * max(ECG_integrated);
threshold_vector = zeros(size(ECG_integrated));
for i = 1:length(ECG_integrated)
    if ECG_integrated(i) > threshold
        threshold_vector(i) = ECG_integrated(i);
    else
        threshold_vector(i) = 0.3 * threshold;
    end
    threshold = 0.15 * ECG_integrated(i) + 0.85 * threshold_vector(i);
end


% Find R-peaks
r_peak_threshold = 0.4 * max(ECG_integrated);
[~, locs_Rwave] = findpeaks(ECG_integrated, 'MinPeakHeight', r_peak_threshold, 'MinPeakDistance', round(0.2*fs));


if locs_Rwave(1)<=50
    locs_Rwave=locs_Rwave(2:end);
end

if locs_Rwave(end)>=numel(val)-50
    locs_Rwave=locs_Rwave(1:end-1);
end    
 
%Find locmax around R-peaks
locs_Rmax = [];
for i = 1 : numel(locs_Rwave)
    prevmax =  locs_Rwave(i);
    for j = 1 : 50
        if val(locs_Rwave(i)+j)>val(prevmax)
            prevmax = locs_Rwave(i)+j;
        end
        if val(locs_Rwave(i)-j)>val(prevmax)
            prevmax=locs_Rwave(i)-j;
        end
    end

    locs_Rmax(i)=prevmax;

end



plot(val);
hold on;


scatter(locs_Rmax,val(locs_Rmax));

end
