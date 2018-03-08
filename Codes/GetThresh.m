%
% Please cite this paper if you use any component of this software:
% S. Soltanian-Zadeh, Y. Gong, and S. Farsiu, "Information -Theoretic Approach
% and Fundamental Limits of Resolving Two Closely-Timed Neuronal Spikes in
% Mouse Brain Calcium Imaging," IEEE TBME, 2018. DOI: 10.1109/TBME.2018.2812078
%
% Released under a GPL v2 license.
%

function [ Pf_final, thresh_final ] = GetThresh( Pf, thresh )

%discretizing intervals of Pf
Pf_final = 0:0.01:1;
epsPf = 0.005;

for k = 1:numel(Pf_final)
    id = find(abs(Pf-Pf_final(k))<=epsPf);
    if ~isempty(id)
        thresh_final(k) = mean(thresh(id));
    else
        thresh_final(k) = thresh_final(k-1);
    end
end

end

