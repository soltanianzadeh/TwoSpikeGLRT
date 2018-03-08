%% Pipeline for deciding one vs. two spike hypothesis of fluorescence signal
%
%
% Please cite this paper if you use any component of this software:
% S. Soltanian-Zadeh, Y. Gong, and S. Farsiu, "Information -Theoretic Approach
% and Fundamental Limits of Resolving Two Closely-Timed Neuronal Spikes in
% Mouse Brain Calcium Imaging," IEEE TBME,2018. DOI: 10.1109/TBME.2018.2812078
%
% Released under a GPL v2 license.
%

addpath('Codes')

%% Determine parameters
params.frameRate = 60;         % Recording speed [Hz]
params.tauD = 0.2049;          % Calcium indicator decay-time constant [s]
params.tauOn = 0.018;          % Calcium indicator on-time constant [s]
params.MU = 0.19;              % Expected mean df/f value of calcium indicator

% Select threshold based on Pf. Threshold is determined from simulation
% results at specific SNR level and frameRate
Pf = 0.02;                     % Only up to 2 decimals allowed
load('PfThresholds.mat');
ind = find(1e2*Pf == 0:100);   %Pfdata is in steps of 0.01 in 0-1;
temp = [];
for p = 1:size(Pfdata,2)
    temp = [temp,Pfdata(p).thresh(ind)]; 
end
thresh = median(temp);

%% load pre-saved data sections corresponding to peak locations
dataFileName = '';
temp = load(dataFileName);     % 
data.signal = Fsignal;         % fluorescence signal
data.time = t;                 % time vector [s] same size as signal
data.spikeTimes = spikeTimes;  % spike times from simultaneous electrical recording
F0 = F;                        % F0 is baseline fluorescence

%% decide one (H0) vs two-spike (H1). 
% detectionResult ==1 for H1 true, and 0 for H0 true
[detectionResult,~] = DetectHypothesis(data,F0,params,thresh);

