function [SF,data] = ShapeFactor( directory,namelist )
%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block1
---------------------------
Calculate Shape Factor for traffic signal detector.
SF=width/height
Input: directory and list of ground-truth files
Output: list of SF, its mean and standard desviation (assuming a normal
distribution), maximun and minimun values.

%}
mean=0;
n=size(namelist,1);
for i=1:n
    [mask,image,gt,type]=ReadOne(directory,namelist(i,:),'Mask');
    width=gt(4)-gt(2);
    height=gt(3)-gt(1);
    SF(i)=width/height;
    mean=mean+SF(i);
end
    mean=mean/n;
    for i=1:n
        sd=(SF(i)-mean)^2;
    end
    sd=sqrt((1/n)*sd);
    data=[mean,sd,max(SF),min(SF)];
end

