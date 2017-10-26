function r=draw_cross(image,y_position, x_position)
    cross_length = 25; %pixels
    [y x colour] = size(image);
    
    
    for y_inc = -cross_length:cross_length
        if ~((y_position + y_inc) > y | (y_position + y_inc) < 1)
            for k = 1:3
                image(y_position + y_inc,x_position,1) = 255;
                image(y_position + y_inc,x_position,2) = 0;
                image(y_position + y_inc,x_position,3) = 0;
            end
        end
    end
    
    for x_inc = -cross_length:cross_length
        if ~((x_position + x_inc) > x | (x_position + x_inc) < 1)
            for k = 1:3
                image(y_position,x_position + x_inc,1) = 255;
                image(y_position,x_position + x_inc,2) = 0;
                image(y_position,x_position + x_inc,3) = 0;
            end
        end
    end
    
    r = image;
end