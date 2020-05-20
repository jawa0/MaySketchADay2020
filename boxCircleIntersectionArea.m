%% boxCircleIntersectionArea
% area of the intersection of a general box with a general circle
function a = boxCircleIntersectionArea(x0, x1, y0, y1, cx, cy, r)
    x0 = x0 - cx; 
    x1 = x1 - cx;
    y0 = y0 - cy; 
    y1 = y1 - cy;
    
    a = area2(x0, x1, y0, y1, r);
end

%% section
% returns the positive root of intersection of line y = h with circle 
% centered at the origin and radius r.
% From: https://stackoverflow.com/a/32698993/225142

function root = section(h, r)
    assert(r >= 0); % assume r is positive, leads to some simplifications in the formula below (can factor out r from the square root)
    
    % http://www.wolframalpha.com/input/?i=r+*+sin%28acos%28x+%2F+r%29%29+%3D+h
    if h < r
        root = sqrt(r * r - h * h);
    else
        root = 0;
    end
end

%% g
% indefinite integral of circle segment
function integral = g(x, h, r)
    % http://www.wolframalpha.com/input/?i=r+*+sin%28acos%28x+%2F+r%29%29+-+h
    integral =  0.5 * (sqrt(1 - x * x / (r * r)) * x * r + r * r * asin(x / r) - 2 * h * x);
end

%% area
% area of intersection of an infinitely tall box with left edge at x0, 
% right edge at x1, bottom edge at h and top edge at infinity, with circle 
% centered at the origin with radius r

function a = area1(x0, x1, h, r)
    if x0 > x1
        [x1 x0] = deal(x0, x1); % this must be sorted otherwise we get negative area
    end
    s = section(h, r);
    a = g(max(-s, min(s, x1)), h, r) - g(max(-s, min(s, x0)), h, r); % integrate the area
end

%% area
% area of the intersection of a finite box with a circle centered at the origin with radius r
function a = area2(x0, x1, y0, y1, r)
    if y0 > y1
        [y1 y0] = deal(y0, y1); % this will simplify the reasoning
    end
    
    if y0 < 0
        if y1 < 0
            % the box is completely under, just flip it above and try again
            a = area2(x0, x1, -y0, -y1, r);
        else
            % the box is both above and below, divide it to two boxes and go 
            % again
            a = area2(x0, x1, 0, -y0, r) + area2(x0, x1, 0, y1, r);
        end
    else
        % y0 >= 0, which means that y1 >= 0 also (y1 >= y0) because of the 
        % swap at the beginning
        assert(y1 >= 0);
        
        % area of the lower box minus area of the higher box
%         [x0 x1 y0 y1 r]
        a = area1(x0, x1, y0, r) - area1(x0, x1, y1, r);
    end
end

