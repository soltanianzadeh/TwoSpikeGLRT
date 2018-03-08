%
% Please cite this paper if you use any component of this software:
% S. Soltanian-Zadeh, Y. Gong, and S. Farsiu, "Information -Theoretic Approach
% and Fundamental Limits of Resolving Two Closely-Timed Neuronal Spikes in
% Mouse Brain Calcium Imaging," IEEE TBME, 2018. DOI: 10.1109/TBME.2018.2812078
%
% Released under a GPL v2 license.
%

function [ detectionResult,logL] = DetectHypothesis( data, F, params, thresh )

options = optimoptions(@fminunc,'Algorithm','quasi-newton','Display','off',...
    'StepTolerance',1e-10);

tRise = params.tauO*log(1+params.tauD/params.tauOn);

signal = double(data.signal);
t = data.time;
signal = reshape(signal,size(t));

% shift t to start at t = 0;
t0 = min(t);
t = t - t0;

%determine test origin
if isfield(data,'spikeTimes')
    t_test = sum(data.spikeTimes)/numel(data.spikeTimes) - t0;
else
    t_test = GetTestOrigin(signal,params,t,frameRate);
end

% shift t such that t_test = 0:
t = t - t_test;

% Estimate model parameters 
params.F = double(F);           
dinit = 0.05;
[~,neglogP1] = fminunc(@(Unknowns)H1Signal_ML(signal,t,params,Unknowns),...
                [dinit,params.MU*ones(1,2)],options);


[~,neglogP0] = fminunc(@(Unknowns)H0Signal_ML(signal,t,params,Unknowns),...
            params.MU,options);

% Compare logL with threshold        
logL = (-neglogP1+neglogP0);
detectionResult = logL>thresh;
     

end

