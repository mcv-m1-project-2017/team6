function [edgesTemplateImg]= EdgesComputedTemplate(I,method,threshold)
%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block4
---------------------------
This function is used to get the edges of the template images by canny or
gradient magnitude.
input:  
I:the orginal image
method: 'canny' - edges computed by canny
        'grad'  - edges computed by gradient magnitude
threshold: the threshold of canny or gradient magnitude

output: 
edgeImg: a binary image of template after edges detection
%}

% input the template images
method_canny='canny';
method_grad='grad';

if strcmp(method,method_canny)==1
    edgesTemplateImg=edge(I,'canny',threshold);
    
elseif strcmp(method,method_grad)==1
    [G,~]=imgradient(I); 
    edgesTemplateImg=G/max(G(:))> threshold;
end

end

