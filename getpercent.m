function r = getpercent(image, position_column, position_row,column_max_model, row_max_model, model_histogram)
    [column_max_image row_max_image colour_image] = size(image);
    
    max_limit = max(column_max_model,row_max_model);
    
    score = 0;
    image_histogram = zeros(8,8,8);       %Makes the histogram of the small image
    
    for i = (position_column-floor(max_limit/2)):(position_column+ floor(max_limit/2))
        for j = (position_row - floor(max_limit/2)):(position_row+floor(max_limit/2))
            if not((i < 1) | (i > column_max_image) | (j < 1) | (j > row_max_image))
                image_histogram(image(i,j,1),image(i,j,2),image(i,j,3)) = image_histogram(image(i,j,1),image(i,j,2),image(i,j,3)) + 1;
            end
        end       
    end

    min_histogram = min(image_histogram, model_histogram);  %Take the minimum of the bins
    r = min(sum(min_histogram(:)) / sum(model_histogram(:)), 1);    %Take the percentage
end