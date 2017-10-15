%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block2
---------------------------

Calculate the histogram backgrond projection for a given image using a
given histogram and threshold as input.
%}
for j='A':'F'
    n=eval(['size(list',j,',1)']);
    
    acum=zeros('F'-'A'+1,100);
    acum2=zeros('F'-'A'+1,100);
    acum3=zeros('F'-'A'+1,100);
    for i=1:n
        c=0;
        [mask,I,gt,~]=ReadOne(dataset_dir,eval(['list',j,'(i,:)']),'Mask','RealIm');
        [a,b]=size(mask);
        mask=imbinarize(mask);
        mask_1=mask(round(gt(1)):round(gt(3)),round(gt(2)):round(gt(4)));
        [I]=rgb2hsv(I);
        f=round(gt(3)-gt(1));
        c=round(gt(4)-gt(2));
        data=histcounts(I(gt(1):gt(3),gt(2):gt(4),1),100,'Normalization','Probability');

        acum(j-'A'+1,:)=acum(j-'A'+1,:)+data;
    end
    hist_medio(j-'A'+1,:)=acum(j-'A'+1,:)/n;

end
h=sum(hist_medio)/6;


