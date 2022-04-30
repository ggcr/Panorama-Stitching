%% readImages.m
% Llegir imatges d'un directori i retornar-les com un array de 4d.
% input:      - impath : path de les imatges
% output:     - imgs : w * h * 3 * n de n imatges

function [imgs] = readImages(impath)
    imgs = [];
    files = dir(strcat(impath, '*.jpg'));
    for n = 1:length(files)
        imgs{n} = imread(strcat(impath, sprintf('image%03d.jpg',n)));
    end
end