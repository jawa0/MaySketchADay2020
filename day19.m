%% #MaySketchADay - Day 01

WIDTH_PIXELS = 1280;
HEIGHT_PIXELS = 720;

a_img = zeros(HEIGHT_PIXELS, WIDTH_PIXELS, 3);
a_img(100, 100, 1) = 1.0;
a_img(200, 200, 2) = 1.0;
a_img(300, 300, 3) = 1.0;
a_img(400, 400, :) = [1.0 1.0 1.0];

draw_circle(a_img, [500 500], 100, [1 1 1]);

image(a_img)

%% Draw a Circle

function draw_circle(img, cx, cy, r, rgb, a)
    msaa = 4;
    
    top = cy - r;
    bottom = y + r;
    left = cz - r;
    right = cx + r;
    
    px_left = 
end
