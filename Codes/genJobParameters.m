%
% Please cite this paper if you use any component of this software:
% S. Soltanian-Zadeh, Y. Gong, and S. Farsiu, "Information -Theoretic Approach
% and Fundamental Limits of Resolving Two Closely-Timed Neuronal Spikes in
% Mouse Brain Calcium Imaging," IEEE TBME, 2018. DOI: 10.1109/TBME.2018.2812078
%
% Released under a GPL v2 license.
%

%% Generate data structure suitable for running on a cluster
function jobID = genJobParameters(a1,a2,d,Dir)

d = reshape(d,numel(d),1);
jobID = [d,repmat(a1,numel(d),1),repmat(a2,numel(d),1)];
save([Dir,'\jobID.mat'],'jobID')

end