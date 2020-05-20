% #MaySketchADay Day 19
% No attempt at good code quality. The idea of MaySketchADay is to
% combat perfectionism. #generativeart #proceduralart is already one step
% removed from sketching, and was getting me into an overly deliberative
% headspace. So, I'm just going to drop some fugly code and try to make a
% pretty picture. Jabavu Adams.

W = 1920;
H = 1080;
white = [1 1 1];

img = zeros(H, W, 3);

for i = 1:int32(1000 + 100*randn())
	r = int32(3 + randn());
	x = W*rand();
	y = H*randn();
	img = fillCircle(img, x, y, r, [100*rand()/255.0 (190 + 20*randn())/255.0 (255 +  20*randn())/255.0]);
end

imwrite(img, "2020-05-19.png");

function img = fillCircle(im, cx, cy, r, rgb)
	rSquared = r*r;
	for y = cy-r:cy+r
		for x = cx-r:cx+r
			if x < 1 || x > 1920 || y < 0 || y > 1080
				continue
			end

			dSquared = (x - cx)^2 + (y - cy)^2;
			if dSquared <= rSquared
				im(int16(y + 0.5), int16(x + 0.5), :) = rgb;
			end
		end
	end
	img = im;
end
