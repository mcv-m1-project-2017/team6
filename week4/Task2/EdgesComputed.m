function [edgesImg]= EdgesComputed(I,color,method,threshold)
%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block4
---------------------------
This function is used to get the edges of the original images by canny or
gradient magnitude.
input:  
I:the orginal image
color:  'r' - the color of the signal is red
        'b' - the color of the signal is blue
method: 'canny' - edges computed by canny
        'grad'  - edges computed by gradient magnitude
threshold: the threshold of canny or gradient magnitude

output: 
edgeImg: a binary image after edges detection
%}

% input the orginal images
grayimg=rgb2gray(I);
Ic=invariableIntensidad(I);
Ir=Ic(:,:,1);
Ib=Ic(:,:,3);
color_red='r';
color_blue='b';
method_canny='canny';
method_grad='grad';

if strcmp(color,color_red)==1
    if strcmp(method,method_canny)==1
        edgesImg=edge(Ir,'canny',threshold);
    elseif strcmp(method,method_grad)==1
        [G,~]=imgradient(Ir); 
        edgesImg=G/max(G(:))> threshold;
    end
elseif strcmp(color,color_blue)==1
    if strcmp(method,method_canny)==1
        edgesImg=edge(Ib,'canny',threshold);
    elseif strcmp(method,method_grad)==1
        [G,~]=imgradient(Ib);
        edgesImg=G/max(G(:))> threshold;
    end
end

end

