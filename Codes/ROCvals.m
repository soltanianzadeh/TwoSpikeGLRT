%
% Please cite this paper if you use any component of this software:
% S. Soltanian-Zadeh, Y. Gong, and S. Farsiu, "Information -Theoretic Approach
% and Fundamental Limits of Resolving Two Closely-Timed Neuronal Spikes in
% Mouse Brain Calcium Imaging," IEEE TBME, 2018. DOI: 10.1109/TBME.2018.2812078
%
% Released under a GPL v2 license.
%

function [ Pd, Pf, thresh] = ROCvals
%Read LogL files for single "d". Computes the average logL|H1 and logL|H0,
%and the final ROC curve

Files = ls('LogL*.mat');
for k = 1 :size(Files,1)
    load(['LogL_',num2str(k),'.mat']);
    LL = (logL);

    nSim = size(logL,2);
    count = 1;
	thresh(:,k) = linspace(min(LL(:))-2,max(LL(:))+2,5000);
    
    for th = 1:size(thresh,1)
        Pd(count,k) =(squeeze(sum(LL(1,:,:)>=thresh(th,k),2))/nSim)';
        Pf(count,k) = (squeeze(sum(LL(2,:,:)>=thresh(th,k),2))/nSim)';
        count = count +1;
    end
end

end

