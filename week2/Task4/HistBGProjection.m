function [mask]=HistBGProjection(image,threshold,prob)
%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block2
---------------------------

Calculate the histogram backgrond projection in HSV colorspace (chanel H) for a given  RGB image using a
given histogram (100 bars) and threshold as input
%}
[a,x,~]=size(image);
im_inv=rgb2hsv(image);
hc=im_inv(:,:,1);
for i=1:a
    for j=1:x
        if round(100*hc(i,j)) == 0
            prob(i,j)=0;
        else
        prob(i,j)=prob(round(100*hc(i,j)));
        end

    end
end

mask=imbinarize(prob,threshold);