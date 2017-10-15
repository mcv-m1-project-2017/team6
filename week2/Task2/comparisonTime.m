%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block2
---------------------------
You can run this code to campare and measure the computational efficiency 
of my programed operators (Erosion and Dilation) with the operators in matlab 
---------------------------
%}

% Define the directory of the testing images and imread
dir_image= 'F:\Study_Master\M1\project\masksWeGot\';
files = ListFilesClear(dir_image);
for i=1:size(files,1)
    files1(i,1:9)=files(i).name;
end
% input one kind of morphological operators you would like to use for testing
%  you can input: -'erosion': morphological operators Erosion
%                 -'dilation': morphological operators Dilation
mytotalTime1=0;
MLtotalTime1=0;
mytotalTime2=0;
MLtotalTime2=0;

myerosion_mean=0;
MLerosion_mean=0;
mydilation_mean=0;
MLdilation_mean=0;
operator=input('input the morphological operation you want to do:\n','s');
if strcmp(operator,'erosion') == 1
    for j=1:size(files1,1)
        image=imread([dir_image,'mask.',files1(j,:),'.png']);
        se = mystrel('square',3);
        tic;
        [myErodedImg]=myerosion(image,se);
        myerosionTime=toc;
        mytotalTime1=mytotalTime1+myerosionTime;

        se_matlab=strel('square',3);
        tic;
        imErodedImg=imerode(image,se_matlab);
        MLerosionTime=toc;
        MLtotalTime1=MLtotalTime1+MLerosionTime;
    end
    myerosion_mean=mytotalTime1/size(files1,1);
    MLerosion_mean=MLtotalTime1/size(files1,1);
elseif strcmp(operator,'dilation') == 1
    for j=1:size(files1,1)
        image=imread([dir_image,'mask.',files1(j,:),'.png']);
        se = mystrel('square',3);
        tic;
        [myDalitedImg]=mydilation(image,se);
        mydilationTime=toc;
        mytotalTime2=mytotalTime2+myerosionTime;

        se_matlab=strel('square',3);
        tic;
        imDilateImg=imdilate(image,se_matlab);
        MLdilationTime=toc;
        MLtotalTime2=MLtotalTime2+MLdilationTime;
    end
    mydilation_mean=mytotalTime2/size(files1,1);
    MLdilation_mean=MLtotalTime2/size(files1,1);
else
    error('Bad input arguments');
end