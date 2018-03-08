%
% Please cite this paper if you use any component of this software:
% S. Soltanian-Zadeh, Y. Gong, and S. Farsiu, "Information -Theoretic Approach
% and Fundamental Limits of Resolving Two Closely-Timed Neuronal Spikes in
% Mouse Brain Calcium Imaging," IEEE TBME, 2018. DOI: 10.1109/TBME.2018.2812078
%
% Released under a GPL v2 license.
%

function  logL  = H0Signal_ML(data,t,params,paramsUnk)

 F = params.F;
 tauD = params.tauD;
 tauOn = params.tauOn;
 tpeak = tauOn*log(1+tauD/tauOn);
  
 a1 = paramsUnk(1);
 
 Peakh = (1-exp(-(tpeak)/tauOn)).*exp(-(tpeak)/tauD);
 
 h1 = (1-exp(-(t)/tauOn)).*exp(-(t)/tauD).*(t >= 0);
 Signal = double(a1*F/Peakh*h1);

 logL = -sum(data.*log(Signal+F)-(Signal));
 
end

