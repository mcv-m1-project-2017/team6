
%{
Juan Felipe Montesinos
2017
Matlab 2016a
For a given segmentation mask, save it with the format:
mask.mask_name.png
%}
function SaveMask(directory,list,mask);

 doesit=exist(directory,'dir');
if doesit == 0 
    error('Directorio inexistente')
elseif doesit ~=7 && doesit ~=0
    error('La ruta propocionada no es un directorio')
end

 for i=1:size(list,1)
     if directory(end) == '\'
 imwrite(mask,[directory,'mask.',list(i,:),'.png'],'png');
     else
        imwrite(mask,[directory,'\mask.',list(i,:),'.png'],'png');
     end
 end
