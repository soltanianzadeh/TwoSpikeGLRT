# TwoSpikeGLRT
Please cite this paper if you use any component of this software: S. Soltanian-Zadeh, Y. Gong, and S. Farsiu, "Information-Theoretic Approach and Fundamental Limits of Resolving Two Closely-Timed Neuronal Spikes in Mouse Brain Calcium Imaging," IEEE Transactions on Biomedical Engineering, 2018. DOI: 10.1109/TBME.2018.2812078.

Released under a GPL v2 license.

# Notes
• The code was tested in MATLAB 2016b.
• Experimental data used in the original manuscript are from Chen et al., “Simultaneous imaging and loose-seal cell-attached electrical recordings from neurons expressing a variety of genetically encoded calcium indicators,” Nature 2013. The dataset can be downloaded from https://crcns.org/data-sets/methods/cai-1.

• All codes are written with the assumption that the input signal is a portion of the entire recording where we want to apply the hypothesis testing on. 

• Example code for running simulations for calculating the minimum detectable inter-spike-interval (ISI) is given in “demo_script_simulation.m”.

• Example code for running GLRT to decide between one-spike vs two-spike model for a portion of the signal, centered on time zero, is given in “demo_script_DataAnalysis.m”. 

• If simultaneous electrical recording is available, spike times can be used to center the fluorescence signal such that time zeros is in the middle of the two spikes. Otherwise, this can be done by finding the point in which the fluorescence signal has maximum cross-correlation to the typical waveforms of a single spike, using the “dftregistration.m” function (available online at https://www.mathworks.com/matlabcentral/fileexchange/18401-efficient-subpixel-image-registration-by-cross-correlation).

• Detection thresholds calculated from Monte-Carlo simulations completed for the paper are in the folder “Simulation thresholds”. It can be used for GCaMP6f and GCaMP6s expressing neurons with same SNR level as the simulations. 
