%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block2
---------------------------
You can use different kinds of the morphological operator to get the result 
images and compare them with the results of using matlab functions
---------------------------
%}

dir_image= 'F:\Study_Master\M1\project\masksWeGot\';
files = ListFilesClear(dir_image);
for i=1:size(files,1)
    files1(i,1:9)=files(i).name;
end

% To strat, you can choose one mask_image to be tested. You can change the
% 'X' value in files1(X,:) to use different test images
image=imread([dir_image,'mask.',files1(1,:),'.png']);

% input one kind of morphological operators you would like to use for testing
%  you can input: -'erosion': morphological operators Erosion
%                 -'dilation': morphological operators Dilation
%                 -'opening': morphological operators Opening
%                 -'closing': morphological operators Closing
%                 -'tophat': morphological operators TopHat
%                 -'tophatdual': morphological operators TopHat Dual
% you will get the output: the images after morphological operation
operator=input('input what operation you want to do:\n','s')
if strcmp(operator,'erosion') == 1
    % my erosion
    se = mystrel('square',3);
    [myErodedImg]=myerosion(image,se);
    figure;imshow(myErodedImg);
    % matlab erosion
    se_matlab=strel('square',3);
    imErodedImg=imerode(image,se_matlab);
    figure;imshow(imErodedImg);
    %comparison
    compare=~imErodedImg&myErodedImg;
    result=sum(sum(compare));
elseif strcmp(operator,'dilation') == 1
    % my dilation
    se = mystrel('square',3);
    [myDalitedImg]=mydilation(image,se);
    figure;imshow(myDalitedImg);
    % matlab dilation
    se_matlab=strel('square',3);
    imDilateImg=imdilate(image,se_matlab);
    figure;imshow(imDilateImg);
    %comparison
    compare=~imDilateImg&myDalitedImg;
    result=sum(sum(compare));
elseif strcmp(operator,'opening') == 1
    % my opening
    se = mystrel('square',3);
    [myOpeningImg]=myopening(image,se);
    figure;imshow(myOpeningImg);
    % matlab opening
    se_matlab=strel('square',3);
    imOpeningImg=imopen(image,se_matlab);
    figure;imshow(imOpeningImg);
    %comparison
    compare=~imOpeningImg&myOpeningImg;
    result=sum(sum(compare));
elseif strcmp(operator,'closing') == 1
    % my closing
    se = mystrel('square',3);
    [myClosingImg]=myclosing(image,se);
    figure;imshow(myClosingImg);
    % matlab closing
    se_matlab=strel('square',3);
    imClosingImg=imclose(image,se_matlab);
    figure;imshow(imClosingImg);
    %comparison
    compare=~imClosingImg&myClosingImg;
    result=sum(sum(compare));
elseif strcmp(operator,'tophat') == 1
    % my tophat
    se = mystrel('square',3);
    [myTophatImg]=mytophat(image,se);
    figure;imshow(myTophatImg);
    % matlab tophat
    se_matlab=strel('square',3);
    imTophatImg=imtophat(image,se_matlab);
    figure;imshow(imTophatImg);
    %comparison
    compare=~imTophatImg&myTophatImg;
    result=sum(sum(compare));
elseif strcmp(operator,'tophatdual') == 1
    % my tophatDual
    se = mystrel('square',3);
    [myTophatDualImg]=mytophatDual(image,se);
    figure;imshow(myTophatDualImg);
else
    error('Bad input arguments');
end

    



