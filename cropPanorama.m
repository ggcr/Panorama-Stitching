function [panorama_] = cropPanorama(panorama_)
    h = size(panorama_, 1);
    w2 = round(size(panorama_, 2)./2);

    marginTop = 1;
    while sum(panorama_(marginTop, w2)) == 0
        marginTop = marginTop + 1;
    end

    marginBottom = h;
    while sum(panorama_(marginBottom, w2)) == 0
        marginBottom = marginBottom - 1;
    end

    xMin = 0;
    xMax = size(panorama_,2);
    panorama_ = imcrop(panorama_,[xMin marginTop xMax-xMin marginBottom-marginTop]);
end