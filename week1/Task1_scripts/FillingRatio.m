function [FR,data] = FillingRatio( directory,namelist )
%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block1
---------------------------
Calculate Filling Ratio for traffic signal detector.
SF=width/height
Input: directory (as an array of characters) and list (as an array) of 
ground-truth files
Output: array of FR, its mean and standard desviation (assuming a normal
distribution), maximun and minimun values.

%}
mean=0;

n=size(namelist,1);
for i=1:n
    filled=0;
    [mask,~,gt,~]=ReadOne(directory,namelist(i,:),'Mask');
    width=gt(4)-gt(2);
    height=gt(3)-gt(1);
    area=width*height;
    imbinarize(mask);
    for j=round(gt(2)):round(gt(4))
        for z=round(gt(1):round(gt(3)))
            if mask(z,j) == 1
                filled=filled+1;
            end
        end
    end
    FR(i)=filled/area;
    mean=mean+FR(i);
end
    mean=mean/n;
    for i=1:n
        sd=(FR(i)-mean)^2;
    end
    sd=sqrt((1/n)*sd);
    data=[mean,sd,max(FR),min(FR)];
end

