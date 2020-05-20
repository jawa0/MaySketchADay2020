%% Fill anti-aliased circle. Calculate exact area of intersection of curved
% fragments with each pixel (square) and use the area as the blending alpha

function fillCircleAA(cx, cy, r, rgb)
    global IMG;
    global W;
    global H;
    
    rgb = reshape(rgb, 1, 1, 3);
    
    for y0 = floor(cy-r):ceil(cy+r)
        for x0 = floor(cx-r):ceil(cx+r)
            x1 = x0 + 1.0;
            y1 = y0 + 1.0;
            
            % Get corresponding integer pixel. MATLAB indexes starting at 1
            % not 0. Also converting to int in MATLAB rounds 0 to 0.49 down
            % and 0.5 to 0.99 up
            
            px = int16(0.5 * (x1 + x0));
            py = int16(0.5 * (y1 + y0));

            % Outside image? Skip.
            if px < 1 || px > W || py < 1 || py > H
                continue
            end

            % Clip to image bounds.
            x0 = max(x0, 0.0);
            y0 = max(y0, 0.0);
            x1 = min(x1, W);
            y1 = min(y1, H);
            
            a = max(0.0, boxCircleIntersectionArea(x0, x1, y0, y1, cx, cy, r));
            assert(a >= 0.0 && a <= 1.0001);
            
            src_rgb = IMG(py, px, :);
            IMG(py, px, :) = (1 - a) .* src_rgb + a .* rgb;
        end
    end
end
