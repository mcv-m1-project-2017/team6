% TASK 4: EVALUATE THE SEGMENTATION
% Team 6, Block 3
% Perform region based evaluation in addition to the pixel based evaluation.
% Matlab functions are provided for region based evaluation.
clearvars;
% Read Ground Truth

dataset_valdidir='B:\train\validate\';
 files = ListFilesClear(dataset_valdidir);
 for i=1:size(files,1)
    files1(i,1:9)=files(i).name;
 end

  % Set all the variables to zero
  totaltime=0;
  time_per_process=0;
  time_per_frame=0;
  windowFP=0;
  windowTP=0;
  windowFN=0;

   for j=1:size(files1,1)
     tic;
     name=files1(j,:);
 [mask_teacher,image,gt,~]=ReadOne(dataset_valdidir,name,'Mask','RealIm');
        [mask_ourRED]=JFMsegmentation(image,0.48,'red');
        [mask_ourRED]=MorphologicalTransform(mask_ourRED);
        %Segmentate and filter blue channel
        Ic=rgb2hsv(image);
        Ic(:,:,3)=histeq(Ic(:,:,3));
        image=hsv2rgb(Ic);
        [mask_ourBLUE]=ColorSegmentation(image,'blue');
        [mask_ourBLUE]=MorphologicalTransform(mask_ourBLUE);
        mask_our= mask_ourBLUE | mask_ourRED;
            [windowCandidates,mask_our]=AutoSlidingW(mask_our,5,5,[70,70]);
    
    gt_annotations_name = fullfile(dataset_valdidir, 'gt\', ['gt.' name '.txt']);
    windowAnnotations = LoadAnnotations(gt_annotations_name);
   [TP,FN,FP] = PerformanceAccumulationWindow(windowCandidates, windowAnnotations);
    windowTP=windowTP+TP;
    windowFN=windowFN+FN;
    windowFP=windowFP+FP;
 
    time_per_process=toc;
    totaltime = totaltime + time_per_process;

 end
%After all the images have been segmented, it is posible to extract some generic parameters to compare the different methods used
 time_per_frame = totaltime/size(files,1);
 [windowPrecision, windowSensitivity, windowAccuracy, windowRecall, windowF1] = PerformanceEvaluationWindow(windowTP, windowFN, windowFP);
 