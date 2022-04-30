%% panorama.m

function [proj_imgs, masks, centres, panorama_] = panorama(imgs, tforms)
    maxImageSize = size(zeros(2,2,2));
    for i = 1:numel(tforms)
        [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 size(imgs{i},2)], [1 size(imgs{i},1)]);
        sz = size(imgs{i});
        if sz > maxImageSize
            maxImageSize = sz;
        end
    
    end

    xMin = min([1; xlim(:)]);
    xMax = max([maxImageSize(2); xlim(:)]);
    
    yMin = min([1; ylim(:)]);
    yMax = max([maxImageSize(1); ylim(:)]);

    width  = round(xMax - xMin);
    height = round(yMax - yMin);
    
    panorama_ = zeros([height width 3], 'like', imgs{1});

    blender = vision.AlphaBlender('Operation', 'Binary mask', ...
    'MaskSource', 'Input port');    
    
    xLimits = [xMin xMax];
    yLimits = [yMin yMax];
    panoramaView = imref2d([height width], xLimits, yLimits);

    proj_imgs = [];
    masks = [];
    centres = []; % Ens servirán pel blending
    
    for i = 1:length(imgs)
        [proj_imgs{i},ref] = imwarp(imgs{i}, tforms(i), 'OutputView', panoramaView);
        masks{i} = imwarp(true(size(imgs{i},1),size(imgs{i},2)), tforms(i), 'OutputView', panoramaView);

        panorama_ = step(blender, panorama_, proj_imgs{i}, masks{i});
    end
    
    % Calcul dels centres
    % Amb prova i error he donat amb aquesta solució extranya (?) no
    % la acabo d'entendre pero aprofita que les homografies son semblants
    % respecte rotació i traslació. He provat i dona la posició dels centres 
    % molt ben aproximats amb els dos panorames ... 
    [imaux,ref] = imwarp(imgs{1}, tforms(1), 'OutputView', panoramaView);
    x_ = round(size(imgs{1},1) ./ 2);
    y_ = round(size(imgs{1},2) ./ 2);
    [xw, yw] = tforms(1).transformPointsForward(x_, y_);
    x1 = yw - ref.YWorldLimits(1);
    centres{1} = [round(x1),round(yw)];
    centres{2} = [round(size(panorama_,2) ./ 2),round(size(panorama_,1) ./ 2)];
    centres{3} = [ref.XWorldLimits(1,2) - xw,yw];
end