function draw_line(fig_num, points)
    figure(fig_num)
    line(points(:,1), points(:,2))
    hold on
    scatter(points(:,1), points(:,2),50,"filled")
end