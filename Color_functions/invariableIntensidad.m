function [Ic]=invariableIntensidad(I)
[a,b,~]=size(I);
I=double(I);
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

for i=1:a
    for j=1:b
        D=R(i,j)+B(i,j)+G(i,j);
        if D==0 
        Ic(i,j,1)=0;
        Ic(i,j,2)=0;
        Ic(i,j,3)=0;
        else    
        Ic(i,j,1)=R(i,j)/D;
        Ic(i,j,2)=G(i,j)/D;
        Ic(i,j,3)=B(i,j)/D;
        end
    end
end