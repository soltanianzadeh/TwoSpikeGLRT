%
% Please cite this paper if you use any component of this software:
% S. Soltanian-Zadeh, Y. Gong, and S. Farsiu, "Information -Theoretic Approach
% and Fundamental Limits of Resolving Two Closely-Timed Neuronal Spikes in
% Mouse Brain Calcium Imaging," IEEE TBME, 2018. DOI: 10.1109/TBME.2018.2812078
%
% Released under a GPL v2 license.
%

function ISImin = runISImin(pd,pf,pFlag)
%pd and pf are the acceptable values for ISImin

load('jobID.mat');
d = jobID(:,1);

[Pd,Pf,~] = ROCvals;

if pFlag
    figure,
    plot(Pf,Pd,'linewidth',2);
    xlabel('Pf'), ylabel('Pd')
end

for r = 1:numel(d)
    id = find(Pf(:,r)<= pf,1,'first');
    if Pd(id,r) >= pd
        ISImin = d(r);
        break
    end
end
    

end