%% Get threshold values based on different levels of probability of false 
% positive. These threshold values can be used for experimental data
% analysis.
%
% Please cite this paper if you use any component of this software:
% S. Soltanian-Zadeh, Y. Gong, and S. Farsiu, "Information -Theoretic Approach
% and Fundamental Limits of Resolving Two Closely-Timed Neuronal Spikes in
% Mouse Brain Calcium Imaging," IEEE TBME, 2018. DOI: 10.1109/TBME.2018.2812078
%
% Released under a GPL v2 license.
%

function [Pfdata] = RunThreshold
    
[~,Pf,thresh] = ROCvals;
[Pfdata.Pf,Pfdata.thresh] = GetThresh(Pf,thresh);

load('Parameters.mat');
SNRrange = SNRsig;
save('PfThresholds.mat','Pfdata','SNRrange')

end