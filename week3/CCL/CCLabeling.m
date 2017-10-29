function [coords,mask_out] = CCLabeling(mask)
%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block3
---------------------------
% Given a mask, returns a list of bounding boxes detected by Connected 
% Component Labeling
input: - mask_in: the mask to be CC labeling
output:- windowCandidates: a struct contains the starting index, the width
and the hight of B box
       - mask_out:

%}
% to get the connected component
cc = bwconncomp(mask);
mask_cc=labelmatrix(cc);
% to get the properties of the connected component
stats = regionprops(cc,'BoundingBox','FilledArea');
N=size(stats,1);
windowCandidates=[];
coords=zeros(N,6);
for i=1:N
    x=stats(i).BoundingBox(1);
    y=stats(i).BoundingBox(2);
    width=stats(i).BoundingBox(3);
    height=stats(i).BoundingBox(4);
    maskArea=stats(i).FilledArea;
    BbArea=width*height;
    SR=width/height;
    FR=maskArea/BbArea;
    coords(i,:)=[y,x,y+height,x+width,SR,FR];
   % mask_out(:,:,i)=mask_cc==i;
    
end
    mask_out=mask_cc;
end
