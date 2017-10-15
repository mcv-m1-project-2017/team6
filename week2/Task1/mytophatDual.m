function [myTophatDualImg]=mytophatDual(image,se)
%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block2
---------------------------
This function is used to achieve the TopHat Dual operation
input: - image: the original image to be used for TopHat Dual
       - se: the structuring element 
output:- myTophatImg: the output image after the TopHat Dual operation
---------------------------
%}

% closing
myClosingImg=myclosing(image,se);
% TopHat Dual
myTophatDualImg=myClosingImg-image;
end