function [CM]=CentroDeMasas(mask)
%{
Juan Felipe Montesinos
Matlab 2016a
2017

Calculate the center of mass for a given binary mask respect the origin of
the mask.

0---------->j
|
|
|
|
i

%}
%Size of image
[n,m]=size(mask);
mask=double(mask);
%Total mass M:
M=sum(sum(mask));
%Inicialize values
CM_i=0;
CM_j=0;

for i=1:n
    for j=1:m
        if mask(i,j) ~=0
            CM_i=CM_i+mask(i,j)*j;
            CM_j=CM_j+mask(i,j)*i;
        end
    end
end
CM(2)=CM_i/M;
CM(1)=CM_j/M;