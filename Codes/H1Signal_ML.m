%
% Please cite this paper if you use any component of this software:
% S. Soltanian-Zadeh, Y. Gong, and S. Farsiu, "Information -Theoretic Approach
% and Fundamental Limits of Resolving Two Closely-Timed Neuronal Spikes in
% Mouse Brain Calcium Imaging," IEEE TBME, 2018. DOI: 10.1109/TBME.2018.2812078
%
% Released under a GPL v2 license.
%

function  logL  = H1Signal_ML(data,t,params,paramsUnk)

 F = params.F;
 tauD = params.tauD;
 tauOn = params.tauOn;
 tpeak = tauOn*log(1+tauD/tauOn);
 
 a1 = paramsUnk(2);
 a2 = paramsUnk(3);
 d = paramsUnk(1);
  
 d1 = a2./(a1+a2)*d;
 d2 = d-d1;
 
 Peakh = (1-exp(-(tpeak)/tauOn)).*exp(-(tpeak)/tauD);
 
 h1 = (1-exp(-(t-d1)/tauOn)).*exp(-(t-d1)/tauD).*(t >= d1);
 h2 = (1-exp(-(t+d2)/tauOn)).*exp(-(t+d2)/tauD).*(t >= -d2);
 
 Signal = double(a1*F/Peakh*h1+a2*F/Peakh*h2);

 logL = -sum(data.*log(Signal+F)-(Signal));
end

