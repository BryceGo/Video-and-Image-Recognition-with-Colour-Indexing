clear

%%Part 1
%{
image=imread('test.bmp'); %database
model = imread('crunchy.bmp');  %Reading the model image
[r locations] = color_index(image,model,0.5,0.9);
figure;
imshow(r);
%}



%%Part 2
%{
frame_number = 10;
load('CMPT412_bluecup.mat');
load('CMPT412_blackcup.mat');
%video = bluecup;
video = blackcup;
stop_image = video(:,:,:,frame_number);

figure;
imshow(stop_image);
[x y] = ginput(2);
model = ginput_to_model(x,y,stop_image);
figure;
imshow(model);

[y x colour duration] = size(video);

for i = 1:duration
   [target(:,:,:,i) locations] = color_index(video(:,:,:,i),model,0.3,0.5,1); 
end
implay(target);
%}

%Part 3
tic 
frame_number = 10;
load('CMPT412_bluecup.mat');
load('CMPT412_blackcup.mat');
video = bluecup;
%video = blackcup;
stop_image = video(:,:,:,frame_number);

figure;
imshow(stop_image);
[x y] = ginput(2);
model = ginput_to_model(x,y,stop_image);
figure;
imshow(model);

[y x colour duration] = size(video);


[target(:,:,:,1) position] = color_index(video(:,:,:,1),model,0.3,0.5,1); 
for i = 2:duration
    old_position = position;
   [target(:,:,:,i), position] = color_index_mean_shift(video(:,:,:,i),model,0.3,0.5,1,position,1);
   if(isempty(position))
      position = old_position; 
   end
end
implay(target);
toc
