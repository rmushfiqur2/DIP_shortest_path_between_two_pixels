clc; clear; close all;

mat = uint8([3 1 2 1;
      2 2 0 2;
      1 2 1 1;
      1 0 1 2]);
% mat = uint8([ ...
%       3 1 2 1 4 5;
%       2 2 0 1 4 5;
%       1 1 3 3 1 0;
%       1 8 5 3 4 1;
%       1 9 0 2 0 8;
%       1 6 7 1 4 5]);
imshow(mat*100)

%% (a)
v = [0,1];
p = [4,1];
q = [1,4];

tic
% 4- path
fprintf('4- path\n')
myf = my_path(mat,p,q,v,"4");
myf = myf.change_value(p(2),p(1),0);
show_cost_and_path(myf, q, 2)

% 8- path
fprintf('8- path\n')
myf = my_path(mat,p,q,v,"8");
myf = myf.change_value(p(2),p(1),0);
show_cost_and_path(myf, q, 3)

% m- path
fprintf('m- path\n')
myf = my_path(mat,p,q,v,"m");
myf = myf.change_value(p(2),p(1),0);
show_cost_and_path(myf, q, 4)

toc

function show_cost_and_path(myf, q, fig_num)
    disp(myf.dist)
    figure(fig_num)
    %imshow(uint8(myf.dist*-10 + 255))
    imshow(myf.dist)
    hcb = colorbar;
    hcb.Title.String = "Cost value (distance)";
    caxis([0,10])
    if myf.dist(q(1),q(2)) < inf
        draw_line(fig_num,myf.get_path(q))
        fprintf('minimum length = %d\n\n', size(myf.get_path(q),1)-1)
    else
        fprintf('no path exists\n\n')
    end
end