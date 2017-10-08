
for i=1:1
    figure(i+1);
    bar(hist_medio(i,:));
    figure(i+6);
    bar(hist_medio2(i,:));
end
%{
[m,n,~]=size(I);
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);
for i=1:m
    for j=1:n
        D=R(i,j)+G(i,j)+B(i,j);
        R(i,j)=R(i,j)/D;
        G(i,j)=G(i,j)/D;
        B(i,j)=B(i,j)/D;
    end
end
I_chroma(:,:,1)=R;
I_chroma(:,:,2)=G;
I_chroma(:,:,3)=B;
%}      
