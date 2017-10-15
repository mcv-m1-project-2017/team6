function [OUT]=equalize(in,channel)

if strcmp(channel(1),'R')==1 || strcmp(channel(2),'R')==1 || strcmp(channel(3),'R')==1 
    in(:,:,1)=histeq(in(:,:,1));
end
if strcmp(channel(1),'G')==1 || strcmp(channel(2),'G')==1 || strcmp(channel(3),'G')==1 
    in(:,:,2)=histeq(in(:,:,2));
end
if strcmp(channel(1),'B')==1 || strcmp(channel(2),'B')==1 || strcmp(channel(3),'B')==1 
    in(:,:,3)=histeq(in(:,:,3));  
end
OUT=in;