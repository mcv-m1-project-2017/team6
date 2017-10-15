function [mask]=JFMsegmentation(image,threshold,color)
im_inv=invariableIntensidad(image);
r=im_inv(:,:,1);
b=im_inv(:,:,3);
if strcmp(color,'red')==1
mask=imbinarize(r,threshold);
elseif strcmp(color,'blue')==1
    mask=imbinarize(b,threshold);
elseif strcmp(color,'rab')==1
    mask= imbinarize(r,threshold(1)) | imbinarize(b,threshold(2));
end