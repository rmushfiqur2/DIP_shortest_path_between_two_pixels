classdef my_path
    %MY_PATH Summary of this class goes here
    %   Detailed explanation goes here

    properties
        points
        points_new
        img
        W
        H
        p
        q
        track_x
        track_y
        dist
        v
        map  % m-path connection map (constant)
        path % m or 4 or 8
    end

    methods
        function obj = my_path(img,p,q,v,path)
        obj.img = img;
        obj.H = size(img,1);
        obj.W = size(img,2);
        obj.points = p;
        obj.points_new = zeros(0,2);
        obj.p = p;
        obj.q = q;
        %obj.queue = p;
        obj.track_x = zeros(size(img));
        obj.track_y = zeros(size(img));
        obj.dist = Inf(size(img));
        obj.v = v;
        obj.path = path;
        obj.map = [[3,4];[1,4];[2,3];[1,2]];
        if ~(obj.is_valid(p(2),p(1)) && obj.is_valid(q(2),q(1)))
            toc
            error("invalid points (p/q) given")
        end
        end

        function val = is_valid(obj,x,y)
            val = x>0 && y>0 && x<=obj.W && y<=obj.H;
        end

        function neighbors = get_neighbors(obj,x,y)
            if obj.path == "4"
                neighbors = [x+1,y; x,y+1; x-1,y; x,y-1];
            elseif obj.path == "8" || obj.path == "m"
                neighbors = [x+1,y; x,y+1; x-1,y; x,y-1;
                    x-1,y-1; x+1, y-1; x-1, y+1; x+1, y+1];
            else
                toc
                error("only 4/8/m paths are supported")
            end

        end

        function obj = make_connection(obj,y,x,y1,x1)
            if obj.dist(y,x)+1 < obj.dist(y1,x1)
                obj.track_x(y1,x1) = x;
                obj.track_y(y1,x1) = y;
                obj = obj.change_value(x1,y1,obj.dist(y,x)+1);
            end
        end

        function obj = process_adjacents(obj, x,y)
            ngbrs = obj.get_neighbors(x,y);
            %draw_line(1, ngbrs);
            if obj.path ~= "m" 
                for i=1:length(ngbrs)
                    y1 = ngbrs(i,2);
                    x1 = ngbrs(i,1);
                    if obj.is_valid(x1, y1) && any(obj.img(y1,x1)==obj.v)
                        obj = obj.make_connection(y,x,y1,x1); % dfs
                    end
                end
            else
                flag = false(1,4);
                for i=1:4 % right bottom left top
                    y1 = ngbrs(i,2);
                    x1 = ngbrs(i,1);
                    if obj.is_valid(x1, y1) && any(obj.img(y1,x1)==obj.v)
                        obj = obj.make_connection(y,x,y1,x1);
                        flag(i) = true;
                    end
                end
                % 5 6 7 8
                % (left-top, right-top, left-bottom, right-bottom)
                %map = [[3,4];[1,4];[2,3];[1,2]];
                for i=1:4
                    y1 = ngbrs(i+4,2);
                    x1 = ngbrs(i+4,1);
                    if ~any(flag(obj.map(i,:))) && obj.is_valid(x1, y1) &&...
                            any(obj.img(y1,x1)==obj.v)
                        obj = obj.make_connection(y,x,y1,x1);
                    end
                end
            end
        end

        function obj = change_value(obj,x,y,val)
            obj.dist(y,x) = val;
            %disp(obj.dist)
            obj = obj.process_adjacents(x,y);
        end

        function path_xy = get_path(obj, q)
            path_xy = zeros(0,2);
            if obj.dist(q(1),q(2)) < inf
                path_xy = [path_xy; q(2), q(1)];
                current = q;
                while current(1) > 0 && current(2) > 0
                    path_xy = [path_xy; obj.track_x(current(1),current(2)),...
                        obj.track_y(current(1),current(2))];
                    current = flip(path_xy(end,:));
                end
                path_xy = path_xy(1:end-1,:);
            end
        end
    end
end