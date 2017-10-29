function [mask_out]=PutACircleInYourLife(mask,R,C)
%{
Juan Felipe Montesinos
Matlab 2016a
Crea un circulo en una mascara binaria dada de radio R en el centro(i,j) C
%}

[m,n]=size(mask);
R=R^2;
for i=1:m
    for j=1:n
        Circulo=(i-C(1))^2+(j-C(2))^2;
        if Circulo < R
            mask(i,j)=1;
        end
    end
end
mask_out=mask;