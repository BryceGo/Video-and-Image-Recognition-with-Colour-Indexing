function r = ginput_to_model(x,y,image)
    [height length colour] = size(image);
    %assuming x and y have 3 points
    x = uint32(x);
    y = uint32(y);
    model = ones(y(2) - y(1) + 1, x(2) - x(1) + 1,3);
    
    model_i = 1;
    model_j = 1;
    
    for i = 1:height
        for j = 1:length
            if((j <= x(2) & j >= x(1)))
                if((i <= y(2) & i >= y(1)))
                   for k = 1:3
                        model(model_j,model_i,k) = image(i,j,k); 
                   end
                   
                   if (model_i == (x(2) - x(1) + 1))
                        model_i = 1;
                        model_j = model_j + 1;
                   else
                        model_i = model_i + 1;
                   end
                end
            end
        end
    end
    
    r = uint8(model);
end