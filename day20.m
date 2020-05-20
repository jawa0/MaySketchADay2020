% #MaySketchADay Day 20
% No attempt at good code quality. The idea of MaySketchADay is to
% combat perfectionism, so, I'm just going to drop some fugly code and try
% to make a pretty picture.
%
% Copyright (c) 2020, Jabavu Adams.

global W; W = 1920;
global H; H = 1080;
global IMG; IMG = zeros(H, W, 3);

for i = 1:int32(1000 + 100*randn())
	r = max(0.0, 3 + randn());
	x = W*rand();
	y = H*randn();
	fillCircleAA(x, y, r, [100*rand()/255.0 (190 + 20*randn())/255.0 (255 +  20*randn())/255.0]);
end

imwrite(IMG, "2020-05-20.png");