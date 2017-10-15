function [myClosingImg]=myclosing(image,se)
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
erosion to achieve closing operation
input: - image: the original image to be used for closing operation
       - se: the structuring element 
output:- myClosingImg: the output image after the closing operation
---------------------------
%}

% dilation
myDilatedImg=mydilation(image,se);
% erosion
myClosingImg=myerosion(myDilatedImg,se);
end