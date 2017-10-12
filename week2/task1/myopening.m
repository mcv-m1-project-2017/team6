function [myOpeningImg]=myopening(image,se)
%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block2
---------------------------
This function is used to apply the morphological operators dilation and
erosion to achieve opening operation
input: - image: the original image to be used for opening operation
       - se: the structuring element 
output:- myOpeningImg: the output image after the opening operation
---------------------------
%}

% erosion
myErodedImg=myerosion(image,se);
% dilation
myOpeningImg=mydilation(myErodedImg,se);
end