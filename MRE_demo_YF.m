%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Demo for brain MRE using electromagnetic actuator. If you find this
% useful please cite:
% Qiu, S., He, Z., Yan, F., Feng, Y., Wang, R., Li, R., & Zhang, A. (2021). 
% An electromagnetic actuator for brain magnetic resonance elastography 
% with high frequency accuracy. NMR in Biomedicine, e4592, 1¨C17. 
% https://doi.org/10.1002/nbm.4592
%
% Input Variables:
% displacement - [col,row,slice,phase offset,encoding direction,vibration
%                 frequency], displacement field from MRE scan (m)
% 
% MU_2d_smoothed - shear modulus estimated based on local frequency
%                   estimation (LFE) (kPa)
% 
% Record of Revisions:
% Jul-23-2021===Suhao Qiu, Yuan Feng===Original code for demo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all
%load processed MRE data
load('MRE_demo_data.mat')
%frequency range
Frequency_range = {'30hz','40hz','50hz','60hz'};
%encoding direction range
EncodingDirection_range = {'x','y','z'};

nslice = 1; %the first slice
direction = 3; %displacement field in z axis

% play the wave propagation movie
for nFre = 1:size(displacement,6)%each frequency
    Disp = squeeze(displacement(:,:,nslice,:,direction,nFre)).*1e6;%(um)

    figure
    for nPhase = 1:size(Disp,3)% each phase offset
        imagesc(Disp(:,:,nPhase)),axis image,axis('off'),colormap('gray'),...
            caxis([-max(displacement(:).*1e6)/4,max(displacement(:).*1e6)/4]),colorbar,title(['Displacement field ', Frequency_range{nFre}]);
        fmat(:,:,nPhase)=getframe;
    end
    movie(fmat,5,4)
end

%show the stiffness map for each frequency
figure
for nFre = 1:size(displacement,6)%each frequency
    subplot(1,size(displacement,6),nFre)
    imagesc(squeeze(MU_2d_smoothed(:,:,nslice,direction,nFre))),axis image,...
        axis('off'),caxis([0,10]),colorbar,title(['Shear stiffness ', Frequency_range{nFre}]);
end
        
        
    
