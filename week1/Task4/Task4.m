% TASK 4: EVALUATE THE SEGMENTATION
% Team 6, Block 1
% In this task, it is evaluated the differents methods used for duing the
% segmentation of the images.

% Read the images to segment
dataset_valdidir='B:\train\validate\';
 files = ListFilesClear(dataset_valdidir);
 for i=1:size(files,1)
    files1(i,1:9)=files(i).name;
 end
  % Set all the variables to zero
 pixelTP = 0;
  pixelFP = 0;
  pixelFN = 0;
  pixelTN = 0;
  totaltime=0;
    % Extract the parameters from each image: True Positive, False Positive,
  % False Negative and True Negative
 for i=1:size(files1,1)
     tic;
 [mask_teacher,image,~,~]=ReadOne(dataset_valdidir,files1(i,:),'Mask','RealIm');
 Ic=rgb2hsv(image);
 Ic(:,:,3)=histeq(Ic(:,:,3));
 image=hsv2rgb(Ic);
 [mask_ourRED]=ColorSegmentation(image,'red');
 [mask_ourBLUE]=ColorSegmentation(image,'blue');
 mask_our=mask_ourRED | mask_ourBLUE;
  % Once it is defined the mask extracted, it can be compared with its
 % ground truth
  [localPixelTP, localPixelFP, localPixelFN, localPixelTN] = PerformanceAccumulationPixel(mask_our, mask_teacher);
  pixelTP = pixelTP + localPixelTP;
  pixelFP = pixelFP + localPixelFP;
  pixelFN = pixelFN + localPixelFN;
  pixelTN = pixelTN + localPixelTN;
    % extract the time used for each frame:
  timerVal=tic;
  totaltime = totaltime + timerVal;
 end
  %After all the images have been segmented, it is posible to extract some generic 
 %parameters to compare the different methods used
 time_per_frame = totaltime/size(files1,1);
 [pixelPrecision, pixelAccuracy, pixelSpecificity, pixelSensitivity] = PerformanceEvaluationPixel(pixelTP, pixelFP, pixelFN, pixelTN);