
function [panorama_] = mean_blending(proj_imgs, masks, panorama_)
    % Mascaras para ver las intersecciones de las imagenes
    diff_LC = and(masks{1}, masks{2});
    diff_CR = and(masks{3}, masks{2});
    % BLENDING1: Promig dels punts superposats amb mascares and
    [rows, columns, chann] = size(panorama_)
    for x = 1:rows
    	for y = 1:columns
            if(diff_LC(x,y) == 1)
    		    for c = 1:chann
                    panorama_(x,y,c) = mean([proj_imgs{1}(x,y,c),proj_imgs{2}(x,y,c)]);
                end
            end
            if(diff_CR(x,y) == 1)
    		    for c = 1:chann
                    panorama_(x,y,c) = mean([proj_imgs{3}(x,y,c),proj_imgs{2}(x,y,c)]);
                end
            end
    	end
    end
end