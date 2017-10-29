function [mask_out]=PasteAMask(source,dest,Pt)
%{
Para dos máscaras dadas: source, dest siento source < dest pega la mascara
source dentro de la máscara dest utilizando un punto Pt (de la mascara dest) dado como
referencia.

La referencia de la mascara source será su centro de masas.
%}
CM=CentroDeMasas(source);
[m,n]=size(source);
[md,nd]=size(dest);
h_i=round(Pt(1)-CM(1));
hmala=0;
if h_i<1
    hmala=1;
    dest=padarray(dest,[abs(h_i),0],0,'pre');
    h_i=1;
end

h_j=round(Pt(2)-CM(2));
if h_j<1
    hmala =2+hmala;
    dest=padarray(dest,[0,abs(h_j)],0,'pre');
    h_j=1;
end
if (h_i+m<md) && (h_j+n<nd )
    dest(h_i:h_i+m-1,h_j:h_j+n-1)=source(:,:);
elseif ~(h_i+m<md) && (h_j+n<nd )
    dest(h_i:md-1,h_j:h_j+n-1)=source(1:md-h_i,:);
elseif (h_i+m<md) && ~(h_j+n<nd )
    
    dest(h_i:h_i+m-1,h_j:nd-1)=source(:,1:nd-h_j);
elseif ~(h_i+m<md) && ~(h_j+n<nd )
    dest(h_i:md-1,h_j:nd-1)=source(1:md-h_i,1:nd-h_j);
end
mask_out=dest;
if hmala == 1
    h_i=round(Pt(1)-CM(1));
   mask_out=mask_out(abs(h_i):abs(h_i)+md-1,:);
end
if hmala == 2
    h_j=round(Pt(2)-CM(2));
   mask_out=mask_out(:,abs(h_j):abs(h_j)+nd-1);
end
if hmala == 3
    h_j=round(Pt(2)-CM(2));
    h_i=round(Pt(1)-CM(1));
   mask_out=mask_out(abs(h_i):abs(h_i)+md-1,abs(h_j):abs(h_j)+nd-1);
end

