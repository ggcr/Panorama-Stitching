%% homografia.m

function [tform] = homografia(x1_L, y1_L, x1_C, y1_C, method)

    if(strcmp(method,'manual'))
        M1 = [];
        for i=1:length(x1_L)
            M1 = [ M1 ;
                x1_C(i) y1_C(i) 1 0 0 0 -x1_L(i)*x1_C(i) -x1_L(i)*y1_C(i) -x1_L(i);
                0 0 0 x1_C(i) y1_C(i) 1 -y1_L(i)*x1_C(i) -y1_L(i)*y1_C(i) -y1_L(i)];
        end
        % resolem dlt
        [u,s,v] = svd( M1 );
        H1 = reshape( v(:,end), 3, 3 )';
        H1 = H1 / H1(3,3); 
        tform = projective2d(inv(H1'));
    end
    
    if(strcmp(method,'auto'))
        tform = estimateGeometricTransform2D(prev, actual,...
            'projective', 'Confidence', 99.9, 'MaxNumTrials', 2000);
    end
end