function plot_dif_hist(im_current, dx, dy)
    [orig_mat,neighbour_mat] = get_matx(im_current, dx, dy);
    difference = (orig_mat - neighbour_mat);
    difference = (double(difference)).^2;
    difference_sum = sum(difference,3);
    figure
    histogram(difference_sum(:));
    xlabel('Difference')
    ylabel('Num of pixels')
end