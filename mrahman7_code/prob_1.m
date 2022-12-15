clc; clear; close all;
tic
im_rgb = imread('wolves.png');
im_gray = rgb2gray(im_rgb);
im_hsv = rgb2hsv(im_rgb);
im_lab = rgb2lab(im_rgb);

% make hsv range compatible with opencv
im_hsv(:,:,1) = im_hsv(:,:,1) * 179;
im_hsv(:,:,2) = im_hsv(:,:,2) * 255;
im_hsv(:,:,3) = im_hsv(:,:,3) * 255;

%% RGB

% (x,y) and (x+1,y)
dx = 1;
dy = 0;

plot_dif_hist(im_rgb, dx, dy);
title('RGB (x,y) and (x+1,y)')

% (x,y) and (x,y+1)
dx = 0;
dy = 1;

plot_dif_hist(im_rgb, dx, dy);
title('RGB (x,y) and (x,y+1)')

%% Gray

% (x,y) and (x+1,y)
dx = 1;
dy = 0;

plot_dif_hist(im_gray, dx, dy);
title('Gray (x,y) and (x+1,y)')

% (x,y) and (x,y+1)
dx = 0;
dy = 1;

plot_dif_hist(im_gray, dx, dy);
title('Gray (x,y) and (x,y+1)')

%% HSV

% (x,y) and (x+1,y)
dx = 1;
dy = 0;

plot_dif_hist(im_hsv, dx, dy);
title('HSV (x,y) and (x+1,y)')

% (x,y) and (x,y+1)
dx = 0;
dy = 1;

plot_dif_hist(im_hsv, dx, dy);
title('HSV (x,y) and (x,y+1)')

%% LAB

% (x,y) and (x+1,y)
dx = 1;
dy = 0;

plot_dif_hist(im_lab, dx, dy);
title('LAB (x,y) and (x+1,y)')

% (x,y) and (x,y+1)
dx = 0;
dy = 1;

plot_dif_hist(im_lab, dx, dy);
title('LAB (x,y) and (x,y+1)')
toc

%% Extra 1

% (x,y) and (x+1,y+1)
dx = 1;
dy = 1;

plot_dif_hist(im_gray, dx, dy);
title('Gray (x,y) and (x+1,y+1)')

% Extra 2
% (x,y) and (x-1,y)
dx = -1;
dy = 0;

plot_dif_hist(im_gray, dx, dy);
title('Gray (x,y) and (x-1,y)')
