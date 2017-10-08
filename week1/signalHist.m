function [data]=signalHist(image,mask,channel,colorspace)
[r,c,~]=size(image);
counter=0;
if strcmp(channel,'R')==1 || strcmp(channel,'H')==1 || strcmp(channel,'red')==1
Channel=image(:,:,1);
elseif strcmp(channel,'G')==1 || strcmp(channel,'S')==1 || strcmp(channel,'green')==1
    Channel=image(:,:,2);
elseif strcmp(channel,'B')==1 || strcmp(channel,'V')==1 || strcmp(channel,'blue')==1
    Channel=image(:,:,3);
end




if strcmp(colorspace,'rgb')==1
for i=1:r
    for j=1:c
        if mask(i,j)==1 
        counter=counter+1;
        yi(counter)=Channel(i,j);
        end
    end
end
elseif strcmp(colorspace,'hsb')==1 || strcmp(colorspace,'hsv')==1
for i=1:r
    for j=1:c
        if mask(i,j)==1 
        counter=counter+1;
        yi(counter)=100*Channel(i,j);
        end
    end
end
end

if strcmp(channel,'H')==1 
        yi=uint8(3.6*yi);
        data=histcounts(yi,360,'Normalization','probability');
elseif strcmp(channel,'S')==1 
        yi=uint8(yi);
        data=histcounts(yi,100,'Normalization','probability');

elseif strcmp(channel,'V')==1
        yi=uint8(yi);
        data=histcounts(yi,100,'Normalization','probability');
else
         data=histcounts(yi,255,'Normalization','probability');   
end
%data=imhist(yi);