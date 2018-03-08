%
% Please cite this paper if you use any component of this software:
% S. Soltanian-Zadeh, Y. Gong, and S. Farsiu, "Information -Theoretic Approach
% and Fundamental Limits of Resolving Two Closely-Timed Neuronal Spikes in
% Mouse Brain Calcium Imaging," IEEE TBME, 2018. DOI: 10.1109/TBME.2018.2812078
%
% Released under a GPL v2 license.
%

function [ data1, data0 ] = CloseSpikesData( params,t )

 F = params.F;
 tauD = params.tauD;
 tauOn = params.tauOn;
 a1 = params.a1;
 a2 = params.a2;
 d = params.d;
 nSim = params.nSim;

 tpeak = tauOn*log(1+tauD/tauOn);
 A1 = repmat(a1,nSim,numel(t))*F;
 A2 = repmat(a2,nSim,numel(t))*F;

 h1 = (1-exp(-(t)/tauOn)).*exp(-(t)/tauD).*(t >= 0);
 PeakA = (1-exp(-(tpeak)/tauOn)).*exp(-(tpeak)/tauD);

 Signal0 = (A2+A1)/PeakA.*repmat(h1,nSim,1);
 data0 =  poissrnd(Signal0+F);

 d2 = a1/(a1+a2)*d;
 d1 = d-d2; 

 h1 = (1-exp(-(t-d1)/tauOn)).*exp(-(t-d1)/tauD).*(t >= d1); 
 h2 = (1-exp(-(t+d2)/tauOn)).*exp(-(t+d2)/tauD).*(t >= -d2);

 Signal1 = A1/PeakA.*repmat(h1,nSim,1) + A2/PeakA.*repmat(h2,nSim,1);
 data1 = poissrnd(Signal1+F);
 
end

