% #MaySketchADay Day 20
% No attempt at good code quality. The idea of MaySketchADay is to
% combat perfectionism, so, I'm just going to drop some fugly code and try
% to make a pretty picture.
%
% Copyright (c) 2020, Jabavu Adams.

global W; W = 1920;
global H; H = 1080;
global IMG; IMG = zeros(H, W, 3);


for i = 1:int32(100 + 10*randn())
	r = int32(69 + 40*randn());
	x = W*rand();
	y = H*randn();
	drawCircle(x, y, r, r/10, [100*rand()/255.0 (190 + 20*randn())/255.0 (255 +  20*randn())/255.0]);
end

imwrite(IMG, "2020-05-20.png");

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
