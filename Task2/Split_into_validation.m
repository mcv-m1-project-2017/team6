%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block1
---------------------------
This script allows to split the training dataset in two groups, the
validation group and the training group by spliting the dataset by type
(saved in an array) and taking the last 30% of the array.
%}
%--------------------------
%--------------------------
%--------------------------

%THIS SCRIPT ASSUMES FOLDER TRAIN IS INTO MAIN MATLAB FOLDER
%--------------------------
%--------------------------
%--------------------------
%--------------------------

%B SIGNALS
Split_by_types
mult=round(0.3*size(listB,1));
split_l=listB(size(listB,1)-mult+1:size(listB,1),:)
%Check the folder exists, else create it
doesit=exist('train\validate','dir');
if doesit == 0 mkdir train\validate;  end
doesit=exist('train\validate\gt','dir');
if doesit == 0 mkdir train\validate\gt; end
doesit=exist('train\validate\mask','dir');
if doesit == 0 mkdir train\validate\mask; end

for i=1:mult
    movefile(['train\',split_l(i,:),'.jpg'],'train\validate');
    movefile(['train\mask\mask.',split_l(i,:),'.png'],'train\validate\mask');
    movefile(['train\gt\gt.',split_l(i,:),'.txt'],'train\validate\gt');
end
%--------------------------
%A SIGNALS
mult=round(0.3*size(listA,1));
split_l=listA(size(listA,1)-mult+1:size(listA,1),:)
%Check the folder exists, else create it
doesit=exist('train\validate','dir');
if doesit == 0 mkdir train\validate;  end
doesit=exist('train\validate\gt','dir');
if doesit == 0 mkdir train\validate\mask; end
doesit=exist('train\validate\mask','dir');
if doesit == 0 mkdir train\validate\gt; end

for i=1:mult
    movefile(['train\',split_l(i,:),'.jpg'],'train\validate');
    movefile(['train\mask\mask.',split_l(i,:),'.png'],'train\validate\mask');
    movefile(['train\gt\gt.',split_l(i,:),'.txt'],'train\validate\gt');
end

%--------------------------
%C SIGNALS
mult=round(0.3*size(listC,1));
split_l=listC(size(listC,1)-mult+1:size(listC,1),:)
%Check the folder exists, else create it
doesit=exist('train\validate','dir');
if doesit == 0 mkdir train\validate;  end
doesit=exist('train\validate\gt','dir');
if doesit == 0 mkdir train\validate\mask; end
doesit=exist('train\validate\mask','dir');
if doesit == 0 mkdir train\validate\gt; end

for i=1:mult
    movefile(['train\',split_l(i,:),'.jpg'],'train\validate');
    movefile(['train\mask\mask.',split_l(i,:),'.png'],'train\validate\mask');
    movefile(['train\gt\gt.',split_l(i,:),'.txt'],'train\validate\gt');
end

%--------------------------
%D SIGNALS
mult=round(0.3*size(listD,1));
split_l=listD(size(listD,1)-mult+1:size(listD,1),:)
%Check the folder exists, else create it
doesit=exist('train\validate','dir');
if doesit == 0 mkdir train\validate;  end
doesit=exist('train\validate\gt','dir');
if doesit == 0 mkdir train\validate\mask; end
doesit=exist('train\validate\mask','dir');
if doesit == 0 mkdir train\validate\gt; end

for i=1:mult
    movefile(['train\',split_l(i,:),'.jpg'],'train\validate');
    movefile(['train\mask\mask.',split_l(i,:),'.png'],'train\validate\mask');
    movefile(['train\gt\gt.',split_l(i,:),'.txt'],'train\validate\gt');
end
%--------------------------
%E SIGNALS
mult=round(0.3*size(listE,1));
split_l=listA(size(listE,1)-mult+1:size(listE,1),:)
%Check the folder exists, else create it
doesit=exist('train\validate','dir');
if doesit == 0 mkdir train\validate; end
doesit=exist('train\validate\gt','dir');
if doesit == 0 mkdir train\validate\mask; end
doesit=exist('train\validate\mask','dir');
if doesit == 0 mkdir train\validate\gt; end

for i=1:mult
    movefile(['train\',split_l(i,:),'.jpg'],'train\validate');
    movefile(['train\mask\mask.',split_l(i,:),'.png'],'train\validate\mask');
    movefile(['train\gt\gt.',split_l(i,:),'.txt'],'train\validate\gt');
end
%--------------------------
%F SIGNALS
mult=round(0.3*size(listF,1));
split_l=listF(size(listF,1)-mult+1:size(listF,1),:)
%Check the folder exists, else create it
doesit=exist('train\validate','dir');
if doesit == 0 mkdir train\validate; end
doesit=exist('train\validate\gt','dir');
if doesit == 0 mkdir train\validate\mask; end
doesit=exist('train\validate\mask','dir');
if doesit == 0 mkdir train\validate\gt; end

for i=1:mult
    movefile(['train\',split_l(i,:),'.jpg'],'train\validate');
    movefile(['train\mask\mask.',split_l(i,:),'.png'],'train\validate\mask');
    movefile(['train\gt\gt.',split_l(i,:),'.txt'],'train\validate\gt');
end