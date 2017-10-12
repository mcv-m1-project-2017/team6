%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block2
---------------------------
run this file to see the results of different kinds of morphological
operator on a mask_image.
---------------------------
%}

% To strat, you have to choose a mask_image to be test
imagepath= 'F:\Study_Master\M1\project\masksWeGot\mask.01.001670.png';
image=imread(imagepath);

% input one kind of morphological operators you would like to use for testing
%  you can input: -'erosion': morphological operators Erosion
%                 -'dilation': morphological operators Dilation
%                 -'opening': morphological operators Opening
%                 -'closing': morphological operators Closing
%                 -'tophat': morphological operators TopHat
%                 -'tophatdual': morphological operators TopHat Dual
% you will get the output: the images after morphological operation

% you need to write down which operation you would like to do
operator=input('input what operation you want to do:\n','s')
if strcmp(operator,'erosion') == 1
    % my erosion
    se = mystrel('square',3);
    [myErodedImg]=myerosion(image,se);
    figure;imshow(myErodedImg);
elseif strcmp(operator,'dilation') == 1
    % my dilation
    se = mystrel('square',3);
    [myDalitedImg]=mydilation(image,se);
    figure;imshow(myDalitedImg);
elseif strcmp(operator,'opening') == 1
    % my opening
    se = mystrel('square',3);
    [myOpeningImg]=myopening(image,se);
    figure;imshow(myOpeningImg);
elseif strcmp(operator,'closing') == 1
    % my closing
    se = mystrel('square',3);
    [myClosingImg]=myclosing(image,se);
    figure;imshow(myClosingImg);
elseif strcmp(operator,'tophat') == 1
    % my tophat
    se = mystrel('square',3);
    [myTophatImg]=mytophat(image,se);
    figure;imshow(myTophatImg);
elseif strcmp(operator,'tophatdual') == 1
    % my tophatDual
    se = mystrel('square',3);
    [myTophatDualImg]=mytophatDual(image,se);
    figure;imshow(myTophatDualImg);
else
    error('Bad input arguments');
end

    



