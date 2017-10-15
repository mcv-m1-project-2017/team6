% TASK 4: EVALUATE THE SEGMENTATION
% Team 6, Block 1
% In this task, it is evaluated the differents methods used for duing the
% segmentation of the images.

% Read the images to segment
dataset_valdidir='C:\Users\JFM\Desktop\test\';
 files = ListFilesClear(dataset_valdidir);
 for i=1:size(files,1)
    files1(i,1:9)=files(i).name;
 end
 for i=1:size(files1,1)
image=imread([dataset_valdidir,files1(i,:),'.jpg']);
 [mask_ourRED]=JFMsegmentation(image,0.5,'red');
  Ic=rgb2hsv(image);
 Ic(:,:,3)=histeq(Ic(:,:,3));
image=hsv2rgb(Ic);
 [mask_ourBLUE]=ColorSegmentation(image,'blue');
 % [mask_ourBLUE]=JFMsegmentation(image,0.45,'blue');
 mask_our=mask_ourRED | mask_ourBLUE;

%[mask_our]=HistBGProjection(image,0.02,h);
[mask_our]=MorphologicalTransform(mask_our);
SaveMask('mask_JFM',files1(i,:),mask_our);
 end