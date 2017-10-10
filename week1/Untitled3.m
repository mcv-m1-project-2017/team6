 dataset_dir='B:\debug\train\validate\';
 files = ListFilesClear(dataset_dir);
 for i=1:size(files,1)
    files1(i,1:9)=files(i).name;
 end
  pixelTP = 0;
  pixelFP = 0;
  pixelFN = 0;
  pixelTN = 0;
  timerVal = 0;
  totaltime = 0;
  
 for i=1:size(files1,1)
     tic;
 [mask_teacher,image,~,~]=ReadOne(dataset_dir,files1(i,:),'Mask','RealIm');
 [mask_ourRED]=ColorSegmentation(image,'red');
 [mask_ourBLUE]=ColorSegmentation(image,'blue');
 mask_our=mask_ourRED | mask_ourBLUE;
  [localPixelTP, localPixelFP, localPixelFN, localPixelTN] = PerformanceAccumulationPixel(mask_our, mask_teacher);
  pixelTP = pixelTP + localPixelTP;
  pixelFP = pixelFP + localPixelFP;
  pixelFN = pixelFN + localPixelFN;
  pixelTN = pixelTN + localPixelTN;
  timerVal = tic;
  totaltime = totaltime + timerVal;
 end
 timer_per_frame = totaltime/size(files1,1);
 [pixelPrecision, pixelAccuracy, pixelSpecificity, pixelSensitivity] = PerformanceEvaluationPixel(pixelTP, pixelFP, pixelFN, pixelTN);