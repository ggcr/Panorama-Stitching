%% puntsControl.m
% Establir els punts de control manuals
% input:      - imgs : w * h * 3 * n de n imatges
% output:     - vectors x, y : 2 * N * n-1 imatges
%               exemple: x(LEFT_IMAGE=1, N_CONTROL_POINT=N, N_IMAGE=n-1)

function [tforms] = puntsControl(imgs, N, impath)
    % Establir N punts de controls per cada parell d'imatges.
    % Es guardarán amb una notació segons el panorama.

    pathparts = strsplit(impath,"/");

    tforms(numel(imgs)) = projective2d(eye(3));

    for n = 1:(length(imgs) - 1)
        t = n;

        figure, imshow(imgs{n})
        figure, imshow(imgs{n+1})
        x1=[]; y1=[];
        x2=[]; y2=[];
        for j=1:N % N punts de control per correlar dues imgs
            zoom on;   
            pause();
            zoom off;
            [x1(j),y1(j)]=ginput(1);
            zoom out;
        
            zoom on;  
            pause();
            zoom off;
            [x2(j),y2(j)]=ginput(1);
            zoom out;
        end

        close all
        save(strcat('pt_prev_',pathparts{2},'_',pathparts{3},'_',num2str(n)),'x1','y1');
        save(strcat('pt_actual_',pathparts{2},'_',pathparts{3},'_',num2str(n)),'x2','y2');

        prev = load(strcat('pt_prev_',pathparts{2},'_',pathparts{3},'_',num2str(n)));
        actual = load(strcat('pt_actual_',pathparts{2},'_',pathparts{3},'_',num2str(n)));

        x1_L = getfield(prev,"x1");
        y1_L = getfield(prev,"y1");
        x1_C = getfield(actual,"x2");
        y1_C = getfield(actual,"y2");

        if(n == 2)
            aux = prev;
            prev = actual;
            actual = aux;
            tforms(t) = eye(3,3);
            t = t + 1;

            x1_L = getfield(prev,"x2");
            y1_L = getfield(prev,"y2");
            x1_C = getfield(actual,"x1");
            y1_C = getfield(actual,"y1");

        end
        
        % Acumulem les transformacions homografies
        tforms(t) = homografia(x1_L,y1_L,x1_C,y1_C,'manual');

    end


end