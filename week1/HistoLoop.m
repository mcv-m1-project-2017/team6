%{
for j='A':'A'
    
    n=eval('size(nameList,1)');
    
    acum=zeros('F'-'A'+1,360);
    acum2=zeros('F'-'A'+1,100);
    for i=1:n
        [mask,I,~,~]=ReadOne(dataset_dir,eval(['nameList','(i,:)']),'Mask','RealIm');
        Ic=rgb2hsv(I);
        [data]=signalHist(Ic,imbinarize(mask),'H','hsv');
        [data2]=signalHist(Ic,imbinarize(mask),'S','hsv');
        acum(j-'A'+1,:)=acum(j-'A'+1,:)+data;
        acum2(j-'A'+1,:)=acum2(j-'A'+1,:)+data2;
    end
    hist_medio(j-'A'+1,:)=acum(j-'A'+1,:)/n;
    hist_medio2(j-'A'+1,:)=acum2(j-'A'+1,:)/n;
end
%}


%{
for j='A':'F'
    n=eval(['size(list',j,',1)']);
    
    acum=zeros('F'-'A'+1,360);
    acum2=zeros('F'-'A'+1,100);
    acum3=zeros('F'-'A'+1,100);
    for i=1:n
        [mask,I,~,~]=ReadOne(dataset_dir,eval(['list',j,'(i,:)']),'Mask','RealIm');
        %{
        Ic=rgb2hsv(I);
        [data]=signalHist(Ic,imbinarize(mask),'H','hsv');
        [data2]=signalHist(Ic,imbinarize(mask),'S','hsv');
        %}
        [I]=invariableIntensidad(I);
        data=histcount(I(:,:,1),100);
        data2=histcount(I(:,:,2),100);
        data3=histcount(I(:,:,3),100);
        acum(j-'A'+1,:)=acum(j-'A'+1,:)+data;
        acum2(j-'A'+1,:)=acum2(j-'A'+1,:)+data2;
        acum3(j-'A'+1,:)=acum3(j-'A'+1,:)+data3;
    end
    hist_medio(j-'A'+1,:)=acum(j-'A'+1,:)/n;
    hist_medio2(j-'A'+1,:)=acum2(j-'A'+1,:)/n;
    hist_medio2(j-'A'+1,:)=acum2(j-'A'+1,:)/n;
end
%}

for j='A':'F'
    n=eval(['size(list',j,',1)']);
    
    acum=zeros('F'-'A'+1,100);
    acum2=zeros('F'-'A'+1,100);
    acum3=zeros('F'-'A'+1,100);
    for i=1:n
        [mask,I,gt,~]=ReadOne(dataset_dir,eval(['list',j,'(i,:)']),'Mask','RealIm');
        [a,b]=size(mask);
        mask=imbinarize(mask);
        mask_1=mask(round(gt(1)):round(gt(3)),round(gt(2)):round(gt(4)));
        [I]=invariableIntensidad(I);
        for q=1:a
            for t=1:b
              if mask==1
                  I
            end
        end
        f=round(gt(3)-gt(1));
        c=round(gt(4)-gt(2));

        data=histcount(I(:,:,1),100);
        data2=histcount(I(:,:,2),100);
        data3=histcount(I(:,:,3),100);

        Ic=zeros(size(Ic_1));
        Ic(:,:,1)=Ic_1;
        Ic(:,:,2)=Ic_2;
        Ic(:,:,3)=Ic_3;
        mask=zeros(size(mask_1));
        mask(:,:,1)=mask_1;
        acum(j-'A'+1,:)=acum(j-'A'+1,:)+data;
        acum2(j-'A'+1,:)=acum2(j-'A'+1,:)+data2;
        acum3(j-'A'+1,:)=acum3(j-'A'+1,:)+data3;
    end
    hist_medio(j-'A'+1,:)=acum(j-'A'+1,:)/n;
    hist_medio2(j-'A'+1,:)=acum2(j-'A'+1,:)/n;
    hist_medio2(j-'A'+1,:)=acum2(j-'A'+1,:)/n;
end


