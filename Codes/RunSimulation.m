%% Run simulation-based GLRT tests
%
% Please cite this paper if you use any component of this software:
% S. Soltanian-Zadeh, Y. Gong, and S. Farsiu, "Information -Theoretic Approach
% and Fundamental Limits of Resolving Two Closely-Timed Neuronal Spikes in
% Mouse Brain Calcium Imaging," IEEE TBME, 2018. DOI: 10.1109/TBME.2018.2812078
%
% Released under a GPL v2 license.
%

function RunSimulation( id )

load('Parameters.mat');
Fb =(SNRsig/MU)^2;
load('jobID.mat')

nSim = 2e3;
DefParams.frameRate = frameRate;
DefParams.tauD = tauD;
DefParams.tauOn = tauOn;
DefParams.F = Fb;

options = optimoptions(@fminunc,'Algorithm','quasi-newton','Display','off','StepTolerance',1e-10);

P = DefParams;
P.a1 = jobID(id,2); P.a2 = jobID(id,3);
P.d = jobID(id,1);
P.nSim = nSim;
%Simulate data. data1: two-spike signals, data0: one-spike signals
[data1, data0] = CloseSpikesData(P,t);

% logL|H1 values stored in frst row, logL|H0 values stored in second row
logL = zeros(2,nSim);

%Run detection on simulated data
d0 = 0.01;
for m = 1:nSim

    [p1,fval1] = fminunc(@(param)H1Signal_ML(data1(m,:),t,DefParams,param),...
        [d0,MU*ones(1,2)],options);
    [~,fval0] = fminunc(@(param)H0Signal_ML(data1(m,:),t,DefParams,param),...
        MU,options);

    logL(1,m) = -fval1 + fval0 ;   
    p1Save(m,:) = p1;

    [ ~,fval1] = fminunc(@(param)H1Signal_ML(data0(m,:),t,DefParams,param),...
        [d0,MU*ones(1,2)],options);
    [ ~,fval0] = fminunc(@(param)H0Signal_ML(data0(m,:),t,DefParams,param),...
        MU,options);

    logL(2,m) = -fval1 + fval0;    

end

save(['LogL_',num2str(id),'.mat'],'logL')
save(['EstParams_',num2str(id),'.mat'],'p1Save')

end

