function [I_i,I_j]=Inercia(mask,C)
%{
Juan Felipe Montesinos
Matlab 2016a
2017

Calculate the inertia for axis i & j, for a given origin of coords and mask.
C -->[Center_i,Center_j];
Inertia is split in 2 terms, one term for each side of the axis, for both
axes. This way it's possible to compare simmetry of mass distribution.


%}
mask=double(mask);
[n,m]=size(mask);
I_i=double([0,0]);
I_j=double([0,0]);

for i=1:n
    for j=1:m
        if mask(i,j) ~=0
            if j<C(2)
            I_i(1)=I_i(1)+mask(i,j)*(j-C(2))^2;
            elseif j>C(2)
                I_i(2)=I_i(2)+mask(i,j)*(j-C(2))^2; 
            end
            if i<C(1)
            I_j(1)=I_j(1)+mask(i,j)*(i-C(1))^2;
            elseif i>C(1)
                I_j(2)=I_j(2)+mask(i,j)*(i-C(1))^2;
            end
        end
   end
end