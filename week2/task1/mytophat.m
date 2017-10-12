function [myTophatImg]=mytophat(image,se)
%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block2
---------------------------
This function is used to achieve the TopHat operation
input: - image: the original image to be used for TopHat
       - se: the structuring element 
output:- myTophatImg: the output image after the TopHat operation
---------------------------
%}

% opening
myOpeningImg=myopening(image,se);
% TopHat
myTophatImg=image-myOpeningImg;
end