%
% Please cite this paper if you use any component of this software:
% S. Soltanian-Zadeh, Y. Gong, and S. Farsiu, "Information -Theoretic Approach
% and Fundamental Limits of Resolving Two Closely-Timed Neuronal Spikes in
% Mouse Brain Calcium Imaging," IEEE TBME, 2018. DOI: 10.1109/TBME.2018.2812078
%
% Released under a GPL v2 license.
%

function t_origin = GetTestOrigin( signal, param, t, frameRate )
%Determine test origin for the signal at hand based on its
% correlation with a template. t should start at t = 0.
% function 'dftregistration.m' is needed (please refer to the README file).

    % Signals might be truncated, thus we create the template based on
    % duration of signal, to tak einto account the incomplete decay. Rest
    % of template is padded with zero to make it the same size as signal
 tEnd = min(round(numel(t)/2),find(t<=param.tauD+param.tauO,1,'last'));
 t1 = t(1:tEnd);
 h = (1-exp(-t1/param.tauO)).*exp(-t1/param.tauD).*(t1>=0);
 h(tEnd+1:numel(signal)) = 0;
 
 h = reshape(h,size(signal));

 % first globally align 
 [r,lags] = xcorr(signal,h);
 [~,id] = max(r);
 t_origin1 = lags(id)/frameRate;
 t = t - t_origin1;

 % refine alignment
 h = (1-exp(-t/param.tauO)).*exp(-t/param.tauD).*(t>=0);
 output = dftregistration(fft(signal),fft(h),5);
 % one of entries in output(3:4) is zero, corresponding to the singular dimention
 t_origin2 = (output(end-1))/frameRate;
 
 t_origin = t_origin1 + t_origin2;

end

