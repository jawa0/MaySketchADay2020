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
