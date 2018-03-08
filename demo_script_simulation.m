%% Pipeline for calculating ISImin based on Monte-Carlo simulations.
% This demo performs simulations to find ISImin for the fixed but unknown
% amplitude case.
%
%
% Please cite this paper if you use any component of this software:
% S. Soltanian-Zadeh, Y. Gong, and S. Farsiu, "Information -Theoretic Approach
% and Fundamental Limits of Resolving Two Closely-Timed Neuronal Spikes in
% Mouse Brain Calcium Imaging," IEEE TBME, 2018. DOI: 10.1109/TBME.2018.2812078
%
% Released under a GPL v2 license.
%

addpath('Codes')

%% Create simulation folder based on SNR level
SNRsig = 8;
Folder = ['SNR',num2str(SNRsig)];
mkdir(Folder);

%% Determine simulation parameters

%Fixed parameters
frameRate = 60;         % Recording speed [Hz]
tauD = 0.2049;          % Calcium indicator decay-time constant [s]
tauOn = 0.018;          % Calcium indicator on-time constant [s]
MU = 0.19;              % Expected mean df/f value of calcium indicator
t = -1:1/frameRate:5;   % Time interval for simulations
save([Folder,'\Parameters.mat'],'frameRate','tauD','tauOn','MU','t','SNRsig');

a1 = 0.15;        % df/f amplitude of first and second spikes. This is just 
a2 = 0.23;        % for simulation. In detection part, it's assumed to be 
                  % unknown and is estimated form the signals.

%Variable parameter is ISI
ISI = (50)*1e-3;
Jobs = genJobParameters(a1,a2,ISI,Folder);

%% Run all simulations
Home = pwd;
cd(Folder)
for k = 1:size(Jobs,1)
    RunSimulation(k);
end
cd(Home)

%% Find ISImin
Pd = 0.99;
Pf = 0.017;
plotFlag =0;

cd(Folder)
ISImin = runISImin(Pd,Pf,plotFlag);

%% Get threshold values based on different levels of probability of false 
% positive. These threshold values can be used for experimental data
% analysis.
PFdata = RunThreshold;

cd(Home)
