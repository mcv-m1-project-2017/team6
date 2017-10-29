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
  time_per_process=0;
  time_per_frame=0;
    % Extract the parameters from each image: True Positive, False Positive,
  % False Negative and True Negative
 for i=1:size(files1,1)
     tic;
 [mask_teacher,image,~,~]=ReadOne(dataset_valdidir,files1(i,:),'Mask','RealIm');
        [mask_ourRED]=JFMsegmentation(image,0.48,'red');
        [mask_ourRED]=MorphologicalTransform(mask_ourRED);
        %Segmentate and filter blue channel
        Ic=rgb2hsv(image);
        Ic(:,:,3)=histeq(Ic(:,:,3));
        image=hsv2rgb(Ic);
        [mask_ourBLUE]=ColorSegmentation(image,'blue');
        [mask_ourBLUE]=MorphologicalTransform(mask_ourBLUE);
        mask_our= mask_ourBLUE | mask_ourRED;
            [windowCandidates,mask_our]=AutoSlidingW(mask_our,5,5,[170,170]);

  % Once it is defined the mask extracted, it can be compared with its
 % ground truth
  [localPixelTP, localPixelFP, localPixelFN, localPixelTN] = PerformanceAccumulationPixel(mask_our, mask_teacher);
  pixelTP = pixelTP + localPixelTP;
  pixelFP = pixelFP + localPixelFP;
  pixelFN = pixelFN + localPixelFN;
  pixelTN = pixelTN + localPixelTN;
    % extract the time used for each frame:
  time_per_process=toc;
  totaltime = totaltime + time_per_process;
 end
  %After all the images have been segmented, it is posible to extract some generic 
 %parameters to compare the different methods used
 time_per_frame = totaltime/size(files1,1);
 [pixelPrecision, pixelAccuracy, pixelSpecificity, pixelRecall, F1] = PerformanceEvaluationPixel(pixelTP, pixelFP, pixelFN, pixelTN);