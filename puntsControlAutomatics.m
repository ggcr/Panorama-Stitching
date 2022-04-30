%% puntsControlAutomatics.m
% Establir els punts de control manuals o automatics
% input:      - imgs : w * h * 3 * n de n imatges
% output:     - vectors x, y : 2 * N * n-1 imatges
%               exemple: x(LEFT_IMAGE=1, N_CONTROL_POINT=N, N_IMAGE=n-1)

function [tforms] = puntsControlAutomatics(imgs,impath)
    % Establir N punts de controls per cada parell d'imatges.
    % Es guardarán amb una notació segons el panorama.

    tforms = projective2d(eye(3,3));
    features = [];
    valid_points = [];

    for n = 1:length(imgs)-1
        gray_im = rgb2gray(imgs{n});
        points = detectSURFFeatures(gray_im);
        [features{n},valid_points{n}] = extractFeatures(gray_im,points);

        gray_im = rgb2gray(imgs{n+1});
        points = detectSURFFeatures(gray_im);
        [features{n+1},valid_points{n+1}] = extractFeatures(gray_im,points);
        indexPairs = matchFeatures(features{n}, features{n+1}, 'Unique', true);
        prevFeatures = (valid_points{n}(indexPairs(:,1), :));
        actualFeatures = valid_points{n+1}(indexPairs(:,2), :);

        % Compute homography and store it in tforms
        tforms(n+1) = homografia(prevFeatures, actualFeatures, 'auto');

        tforms(n+1).T = tforms(n).T * tforms(n+1).T; 
    end

end