%% seams_blending.m
% Consisteix en assignar cada píxel superposat segons el centre més proper
% amb una wighted sum amb una mascara filtrada amb una gaussiana
% mes info: https://courses.grainger.illinois.edu/cs543/sp2017/lectures/Lecture%2013%20-%20Photo%20Stitching%20-%20Vision_Spring2017.pdf

function [final_panorama] = seams_blending(proj_imgs, masks, centres, panorama_)
    % Mascaras
    diff_LC = or(masks{1}, masks{2});
    diff_RC = or(masks{2}, masks{3});
    global_mask = or(masks{1}, masks{2});
    mask_12 = centres{1}(1) + round((centres{2}(1) - centres{1}(1))./2);
    mask_23 = centres{2}(1) + round((centres{3}(1) - centres{2}(1))./2);
    
    [rows, columns, chann] = size(panorama_);
    for x = 1:rows
	    for y = 1:columns
            global_mask(x,y) = 0;
            if(y < mask_12 & y < mask_23)
		        global_mask(x,y) = 1;
            end
            if(y > mask_23 & y > mask_12)
		        global_mask(x,y) = 1;
            end
	    end
    end
    
    smooth_mask = double(imgaussfilt(double(global_mask),200));
    final_panorama = uint8(double(proj_imgs{1}(:,:,:)) .* (smooth_mask) + double(proj_imgs{2}(:,:,:)) .* (1-smooth_mask) + double(proj_imgs{3}(:,:,:)) .* (smooth_mask));
end