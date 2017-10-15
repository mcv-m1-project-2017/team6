function [Ic]=invariableIntensidad(I)
[a,b,~]=size(I);
I=double(I);
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

Ic(:,:,1)= R./(R+G+B);
Ic(:,:,2)= G./(R+G+B);
Ic(:,:,3)= B./(R+G+B);
Ic(isnan(Ic))=0;
