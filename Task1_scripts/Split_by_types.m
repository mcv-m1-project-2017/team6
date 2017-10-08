%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block1
---------------------------
For a given folder it creates a character array with the name of files
within and afterwards it split it into F lists, one per signal type. It
only works for the name format used in training dataset, which is:
XX.XXXXXXX.jpg for color images
mask.XX.XXXXXXX.png for masks
gt.XX.XXXXXXX.txt for ground-truth text files
%}


%Reading files in the directory and listing them as a vector
files = ListFilesClear(dataset_dir);
for i=1:size(files,1)
nameList(i,:)=files(i).name;
end

%Spliting by types
counter=ones(1,'F'-'A'+1);

for i=1:size(files,1)
[mask,~,~,type]=ReadOne(dataset_dir,nameList(i,:));
switch type
    case 'A'
        listA(counter(1),1:9)=nameList(i,1:9);
        counter(1)=counter(1)+1;
    case 'B'
        listB(counter('B'-'A'+1),1:9)=nameList(i,1:9);
        counter('B'-'A'+1)=counter('B'-'A'+1)+1;
    case 'C'
        listC(counter('C'-'A'+1),1:9)=nameList(i,1:9);
        counter('C'-'A'+1)=counter('C'-'A'+1)+1;
    case 'D'
        listD(counter('D'-'A'+1),1:9)=nameList(i,1:9);
        counter('D'-'A'+1)=counter('D'-'A'+1)+1;
    case 'E'
        listE(counter('E'-'A'+1),1:9)=nameList(i,1:9);
        counter('E'-'A'+1)=counter('E'-'A'+1)+1;
    case 'F'
        listF(counter('F'-'A'+1),1:9)=nameList(i,1:9);
        counter('F'-'A'+1)=counter('F'-'A'+1)+1;
end
end

