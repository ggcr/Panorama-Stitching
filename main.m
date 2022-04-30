
function main
    % Clear MATLAB envoirnment
    clc; close all; imtool close all; clear; format short g;

    % Llegir imatges
    impath = 'input_imgs/field/';
    % impath = 'input_imgs/landscape/';
    imgs = readImages(impath);

    % Transformades geometriques
    N = 8;
    tforms = puntsControl(imgs, N, impath);
    % tforms = puntsControlAutomatics(imgs,impath);

    [proj_imgs, masks, centres, panorama_] = panorama(imgs, tforms);

    % Mean blending
    panorama_ = mean_blending(proj_imgs, masks, panorama_);
    % Choosing Seams Blending
    panorama_ = seams_blending(proj_imgs, masks, centres, panorama_);

    panorama_ = cropPanorama(panorama_);
    
    pathparts = strsplit(impath,"/");
    imwrite(panorama_, strcat('output_imgs/',pathparts{2},'_',pathparts{3},'.jpg'))
end