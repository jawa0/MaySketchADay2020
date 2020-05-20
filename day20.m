% #MaySketchADay Day 20
% No attempt at good code quality. The idea of MaySketchADay is to
% combat perfectionism, so, I'm just going to drop some fugly code and try
% to make a pretty picture.
%
% Copyright (c) 2020, Jabavu Adams.

global W; W = 1920;
global H; H = 1080;
global IMG; IMG = zeros(H, W, 3);

section(10, 10)
section(10, 10.1)
section(0, 10)
section(0.1, 10)

area1(-1, 1, 0, 1)
area1(-1, 1, 1, 1)

area_bc(0, 1, 0, 1, 0, 0, 1.5)
area_bc(0, 1, 0, 1, 0, 0, 1)
area_bc(-1, 1, 0, 1, 0, 0, 1)

% imwrite(IMG, "2020-05-20.png");

%% area_bc
% area of the intersection of a general box with a general circle
function a = area_bc(x0, x1, y0, y1, cx, cy, r)
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
        a = area1(x0, x1, y0, r) - area1(x0, x1, y1, r);
    end
end

%%
function drawCircle(cx, cy, r, t, rgb)
    global IMG;
    global W;
    global H;
    
	rSquaredOuter = r^2;
    rSquaredInner = (r-t)^2;
	for y = cy-r:cy+r
		for x = cx-r:cx+r
			if x < 1 || x > W || y < 0 || y > H
				continue
			end

			dSquared = (x - cx)^2 + (y - cy)^2;
			if dSquared < rSquaredOuter && dSquared >= rSquaredInner
				IMG(int16(y + 0.5), int16(x + 0.5), :) = rgb;
			end
		end
	end
end

%%


%%
function fillCircle(cx, cy, r, rgb)
    global IMG;
    global W;
    global H;
    
	rSquared = r*r;
	for y = cy-r:cy+r
		for x = cx-r:cx+r
			if x < 1 || x > W || y < 0 || y > H
				continue
			end

			dSquared = (x - cx)^2 + (y - cy)^2;
			if dSquared <= rSquared
				IMG(int16(y + 0.5), int16(x + 0.5), :) = rgb;
			end
		end
	end
end
