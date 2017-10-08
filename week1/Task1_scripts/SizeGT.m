function [data_w,data_h,width,height] = SizeGT( directory,namelist )
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
mean_w=0;
mean_h=0;
n=size(namelist,1);
for i=1:n
    [~,~,gt,type]=ReadOne(directory,namelist(i,:),'Mask');
    width(i)=gt(4)-gt(2);
    height(i)=gt(3)-gt(1);
    mean_w=mean_w+width(i);
    mean_h=mean_h+height(i);
end
    mean_w=mean_w/n;
    mean_h=mean_h/n;
    for i=1:n
        sd_h=(height(i)-mean_h)^2;
        sd_w=(width(i)-mean_w)^2;
    end
    sd_h=sqrt((1/n)*sd_h);
    sd_w=sqrt((1/n)*sd_w);
    data_h=[mean_h,sd_h];
    data_w=[mean_w,sd_w];
end
