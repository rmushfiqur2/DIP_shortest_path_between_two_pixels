function [orig_mat,neighbour_mat] = get_matx(input_mat,dx,dy)
    orig_mat = input_mat(1:end-abs(dy),1:end-abs(dx),:);
    neighbour_mat = input_mat(1+abs(dy):end,1+abs(dx):end,:);
end