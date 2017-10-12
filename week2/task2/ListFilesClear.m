function files = ListFilesClear(directory)
%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block1
---------------------------
Creates a list of files for a directory given. It assumes the format
applied in the data training set:
-Ground-truth text files: gt.name.txt
-Masks: mask.name.png
-Photos: name.jpg

%}
f = dir(directory);
files = [];
for i=1:size(f,1)
    if f(i).isdir==0
        if strcmp(f(i).name(end-2:end),'ppm')==1 || strcmp(f(i).name(end-2:end),'jpg')==1 || strcmp(f(i).name(end-2:end),'png')==1|| strcmp(f(i).name(end-2:end),'txt')==1;
        if strcmp(f(i).name(end-2:end),'jpg')==1
            f(i).name=f(i).name(1:length(f(i).name)-4);
           %f(i).name=extractBefore(f(i).name,'.jpg');
           %avilable for matlab 2016b or above
        elseif strcmp(f(i).name(end-2:end),'png')==1
            f(i).name=f(i).name(6:length(f(i).name)-4);
            %f(i).name=extractBetween(f(i).name,'mask.','.png');
            %avilable for matlab 2016b or above
        elseif strcmp(f(i).name(end-2:end),'txt')==1
            f(i).name=f(i).name(4:length(f(i).name)-4);
            %f(i).name=extractBetween(f(i).name,'gt.','.txt');
            %avilable for matlab 2016b or above
        end
            files = [files ; f(i)];
        end
    end
end