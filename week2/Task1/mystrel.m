function [se] = mystrel(shape,r,n)
%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block2
---------------------------
This function is used to define the structuring element. A strel object  
represents a flat morphological structuring element, which is an essential 
part of morphological dilation and erosion operations.

input: - shape: the kind of structuring element you would like to use
       - r: parameter used to define the radius of the circle SE, the width
            of the rectangle SE or the width and hight of the square SE
       - n: parameter used to define the hight of the rectangle SE
output:- se: the structuring element
---------------------------
%}
switch shape
    case 'rectangle'
        se=ones(r,n);
    case 'square'
        se=ones(r);
    end
end