function [r locations]=color_index(image,model,resolution,threshold,max_items)

%tic
%Assume abc is the model image
%ans = histogram(abc,0:32:256)

%resolution = 0.5;
%max_items = 10;
r = 0;
count = 0;
item_count = 100;
pixel_count = 1;
model_histogram = zeros(8,8,8); %Each dimension would signify an RGB colour ... So essentially giving zeroes(R,G,B)
newimage = 0;
%threshold = 0.9;    %This is only the starting threshold, it incrementally gets bigger
%image=imread('test.bmp'); %database
%model = imread('crunchy.bmp');  %Reading the model image
old_image = image;
model = imresize(model,resolution);   %Need to lower the resolution of th emodel image otherwise it would take too much time
image = imresize(image, resolution);
%figure; imshow(image);
%figure; imshow(model);

old_model = model;

for i = 1:3     %Turns the model and image into discrete values between 0-8 instead of 0-255
    model(:,:,i) = discretize(model(:,:,i),0:32:256);
    image(:,:,i) = discretize(image(:,:,i),0:32:256);
end

[height_image length_image colour_image] = size(image);
%Fill the values in of the histogram of the model
[height length colour] = size(model);
for i = 1:height
    for j = 1:length
        if (model(height,length,1) + model(height,length,2) + model(height,length,3) ~= 10) %Ignores the black and almost black pixels
            model_histogram(model(i,j,1),model(i,j,2),model(i,j,3)) = model_histogram(model(i,j,1),model(i,j,2),model(i,j,3)) + 1;
        end
    end
end

for i = 1:height_image
    for j = 1:length_image
        %The getpercent function basically returns the value of the
        %percentage compatibility of the pixel in the actual image with its
        %model histogram.
        newimage(i,j) = getpercent(image,i,j,height,length,model_histogram);
    end
end

%figure;
%imshow(newimage);




while(item_count > max_items | pixel_count > 0.35)
    loc = find(newimage >= threshold);
    [pixel_count a]= size(loc);
    pixel_count = pixel_count/(height_image*length_image);
    
    image = zeros(height_image, length_image);
    image(loc) = 1;
    result = bwmorph(image,'shrink',Inf);
    [y x] = find(result>0);
    [item_count x] = size(y);
    threshold = threshold + 0.001;
end

%figure;
%imshow(image);

result = bwmorph(image,'shrink',Inf);
[y x] = find(result>0);


pixel_count;

%fprintf("Number of Items");
num = size(y);
num(1);

%fprintf("Locations are: ");
[y x];

if(size(y) >= 1)
    for i = 1:size(y)
        r = draw_cross(old_image, floor(y(i)*(1/resolution)), floor(x(i)*(1/resolution)));
    end
else
    r = old_image;
end

locations = [y x];

%figure;
%imshow(r);

%fprintf("Threshold: ");
threshold;

%toc

end