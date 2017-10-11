% Task 4 -> EVALUATE THE SEGMENTATION

% In this task it is evaluated the results from task 3.
% This is a trail, not a definitive version. It is not designed for the
% general case, it is designed to work with only one image. What does it
% means? It means that you choose manually which image want to check how
% good it is compared to its mask. Tomorrow, Saturday, I will work on a
% definitive version.

% Note 1: It works with '.png' formats only. Ask any questions. If it looks
% not good, I am traying to do all what I can.
% Note 2: The time per frame will be extracted from task 3, using tic-toc
% commands provably. 

mask = imread('allocation of the mask you want to examinate.png');
mask = logical(mask);
image = imread('allocation of the image after some method from task 3 done.png');
image = logical(image);

[TP, TN, FP, FN, ACC] = get_parameters(mask, image);
[R, P, AO, FD, F1] = get_metrics(TP, TN, FP, FN)

function [TP, TN, FP, FN, ACC] = get_parameters(image, mask)
% Calculate True Positives (TP)
TP = sum(sum(image & mask));
% Calculate True Negatives (TN)
TN = sum(sum((((~ image) & (~ mask)))));
% Calculate False Positives (FP)
FP = sum(sum((~ image) & mask));
% Calculate False Negatives (FN)
FN = sum(sum(image & (~ mask)));
% Calculate Accuracy -> (ACC) : (TP + TN) / total pixels
[m, n] = size(image);
ACC = (TP+TN)/(m*n);
end

function [R, P, AO, FD, F1] = get_metrics(TP, TN, FP, FN)
% Calculate precision: P = TP / P = TP / (TP + FP)
P = TP/(TP+FP);
% Calculate recall: R = TP / T
R = TP/(TP+FN);
% Calculate accepted outliers AO = FP / F = FP / (FP + TN)
AO = FP/(FP+TN);
% Calculate % false detections = FD = FP / P = 1 - precision
FD = 1 - (double(P)/100);
% Calcualte F1 measure  = 2 * ( (P * R) / (P + R) )
if P > 0 & R > 0
    F1 = 2*((P*R)/(P+R));
else
    F1 = 0;
end
end