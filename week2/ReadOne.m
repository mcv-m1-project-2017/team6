function [mask,image,gt,type]=ReadOne(directory,name,varargin)
%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block1
---------------------------
Given a name of a file following the form used in training data set this
function opens the ground-truth file text, the mask and the original image
depending on the varargin.
Input:
'Mask': funcion save mask in the output variable mask
'RealIm': function saves the real image in the output variable: image
%}
mmask='Mask';
mimage='RealIm';
    if nargin>4 || nargin<2
    error('Bad arguments')
    end
   
    if nargin == 4
        if strcmp(varargin{1},mmask)==1 || strcmp(varargin{2},mmask)==1
            usemask=1;
        else
            usemask=0;
        end
        if strcmp(varargin{1},mimage)==1 || strcmp(varargin{2},mimage)==1
            useim=1;
        else
            useim=0;
        end   
    elseif nargin == 3
        if strcmp(varargin{1},mmask)==1
             usemask=1;
        else
            usemask=0;
        end
        if strcmp(varargin{1},mimage)==1
            useim=1;
        else
            useim=0;
        end
    elseif nargin == 2
            usemask=0;
            useim = 0;
    end
    
    [x1,y1,x2,y2,type] = textread(strcat(directory,'gt\gt.',name,'.txt'),'%f %f %f %f %c',1);
    gt = [x1,y1,x2,y2];
    if usemask==1
        mask = imread(strcat(directory,'mask\mask.',name,'.png'));
    else
        mask=0;
    end
    if useim == 1
        image = imread(strcat(directory,name,'.jpg'));
    else
        image=0;
    end
    
end

