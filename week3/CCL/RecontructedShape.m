function [mask_f,windowCandidates,suma]=RecontructedShape(mask_our,image,color)
%{

Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block3
---------------------------
For a given image and its color segmentation binary mask mask apply Conected Component Labeling 
color: 'red' or 'blue' indicates which channel want to segment
%}

%Connected Component Labeling:
%Provides numerated mask, box, filling factor and shape factor SF. (CCL)
[coords,mask_our] = CCLabeling(mask_our);
%inicialice final mask (output)
mask_f=zeros(size(mask_our));
%Image/mask size
[p,q]=size(mask_our);
%Inicialize window candidates
windowCandidates=[];
%Case of 'red'
if strcmp(color,'red')
if size(coords,1)>1
for i=1:size(coords,1)
    mask=mask_our==i;
    CM(i,1:2)=CentroDeMasas(mask);
end
%Specific algorithm segmentate wrong way trafic signals
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:size(coords,1)
    for j=1:size(coords,1)
        if j>=i+1
            Operativo(i,j,1)=abs(CM(i,2)-CM(j,2));
            Operativo(i,j,2)=sqrt((CM(i,2)-CM(j,2))^2+(CM(i,1)-CM(j,1))^2);
        else
            Operativo(i,j,1)=Inf;
        end

    end
end
tomin=Operativo(:,:,1);
[M,I]=min(tomin(:));
[I_row, I_col] = ind2sub(size(tomin),I);
if Operativo(I_row,I_col,2)<100 && M<10
    mask_prohibido=mask_our==I_row | mask_our== I_col;
    coor_prohibido=[min(coords(I_col,1),coords(I_row,1)),max(coords(I_row,2),coords(I_col,2))...
        min(coords(I_row,3),coords(I_col,3)),max(coords(I_row,4),coords(I_col,4))];
else
    mask_prohibido=zeros(size(mask_our));
end

if sum(sum(mask_prohibido))~=0
                     extra=15;
         a=coor_prohibido(1)-extra;
         if a<1
             a=coor_prohibido(1)-extra+abs(a)+1;
         end
         c=coor_prohibido(2)-extra;
         if c<1
             c=coor_prohibido(2)-extra+abs(c)+1;
         end
         b=coor_prohibido(3)+extra;
         if b>p
         b=coor_prohibido(3)+extra-abs(b-p);
         end
         d=coor_prohibido(4)+extra;
         if d>q
           d=coor_prohibido(4)+extra-abs(d-q);
         end
         
        [mask_s]=JFMsegmentation(image(a:b,c:d,:),0.45,'red');
        mask_s=imfill(mask_s,'holes');
         dm2=strel('diamond',6);
         mask_s=imopen(mask_s,dm2);
         [I_i,I_j]=Inercia(mask_s,CentroDeMasas(mask_s));
         I=I_i(1)/I_i(2);
         Ij=I_j(1)/I_j(2);
         if abs(I-Ij)<0.17
             [m,n]=size(mask_s);
             BW=PutACircleInYourLife(zeros(size(mask_s)),min(m,n)/2,[m/2,n/2]);
             mask=PasteAMask(BW,mask_prohibido,CentroDeMasas(mask_prohibido));
             [~,p,q]=HolographicProjection(mask_s);
             %input=zeros(p(2)-p(1),q(2)-q(1));
         windowCandidates = [windowCandidates;struct('y',double(p(1)),'x',...
            double(q(1)),'w',double(q(2)-q(1)),'h',double(p(2)-p(1)))];
         end
         
         mask_f=mask_f|mask;
end
end
[p,q]=size(mask_our);
for i=1:size(coords,1)
    
    mask=mask_our==i;
    %Size filter
    if (coords(i,3)-coords(i,1))>24 && (coords(i,4)-coords(i,2))>24
        %Shape Factor filter
    if coords(i,5)>0.8 && coords(i,5)<1.27

            [I_i,~]=Inercia(mask,CentroDeMasas(mask));
            I=I_i(1)/I_i(2);
            %Inertia filter
        if I>0.82 && I<1.22
            %Increasing box by 15 pixels each side
                 extra=15;
         a=coords(i,1)-extra;
         if a<1
             a=coords(i,1)-extra+abs(a)+1;
         end
         c=coords(i,2)-extra;
         if c<1
             c=coords(i,2)-extra+abs(c)+1;
         end
         b=coords(i,3)+extra;
         if b>p
         b=coords(i,3)+extra-abs(b-p);
         end
         d=coords(i,4)+extra;
         if d>q
           d=coords(i,4)+extra-abs(d-q);
         end
         %Low threshold segmentation
        [mask_s]=JFMsegmentation(image(a:b,c:d,:),0.45,'red');
        %Hole filling
        mask_s=imfill(mask_s,'holes');
         %Noise erasing
         dm2=strel('diamond',6);
         mask_s=imopen(mask_s,dm2);
         [I_i,I_j]=Inercia(mask_s,CentroDeMasas(mask_s));
         I=I_i(1)/I_i(2);
         Ij=I_j(1)/I_j(2);
         %Inertia filtering
         if I>0.85 && I<1.35
            
             %[N,p,q]=HolographicProjection(mask_s);
             %input=zeros(p(2)-p(1),q(2)-q(1));
        %Perfect shape pasting
         if  Ij>1.2
            [m,n]=size(mask_s);
            c = [1, n, n/2];
            r = [m, m, m-m/2*tan(60*pi()/180)];
            BW = roipoly(m,n,c,r);
            mask=PasteAMask(BW,mask,CentroDeMasas(mask));
            windowCandidates = [windowCandidates;struct('y',double(coords(i,1)),'x',...
            double(coords(i,2)),'w',double(coords(i,4)-coords(i,2)),'h',double(coords(i,3)-coords(i,1)))];
        mask_f=mask_f|mask;
         elseif Ij<0.8
             [m,n]=size(mask_s);
               c = [1, n, n/2];
                r = [1, 1, m/2*tan(60*pi()/180)];
                BW = roipoly(m,n,c,r);
                mask=PasteAMask(BW,mask,CentroDeMasas(mask));
                windowCandidates = [windowCandidates;struct('y',double(coords(i,1)),'x',...
            double(coords(i,2)),'w',double(coords(i,4)-coords(i,2)),'h',double(coords(i,3)-coords(i,1)))];
        mask_f=mask_f|mask;
         elseif abs(I-Ij)<0.17
             [m,n]=size(mask_s);
               BW=PutACircleInYourLife(zeros(size(mask_s)),min(m,n)/2,[m/2,n/2]);
                mask=PasteAMask(BW,mask,CentroDeMasas(mask));
                windowCandidates = [windowCandidates;struct('y',double(coords(i,1)),'x',...
            double(coords(i,2)),'w',double(coords(i,4)-coords(i,2)),'h',double(coords(i,3)-coords(i,1)))];
        mask_f=mask_f|mask;
         end
         

        end
         end 
        end

    end
end


elseif strcmp(color,'blue')
    [p,q]=size(mask_our);
for i=1:size(coords,1)
    
    mask=mask_our==i;
    if (coords(i,3)-coords(i,1))>24 && (coords(i,4)-coords(i,2))>24
    if coords(i,5)>0.6 && coords(i,5)<1.27
            [I_i,~]=Inercia(mask,CentroDeMasas(mask));
            I=I_i(1)/I_i(2);
        if I>0.82 && I<1.22
                 extra=5;
         a=coords(i,1)-extra;
         if a<1
             a=coords(i,1)-extra+abs(a)+1;
         end
         c=coords(i,2)-extra;
         if c<1
             c=coords(i,2)-extra+abs(c)+1;
         end
         b=coords(i,3)+extra;
         if b>p
         b=coords(i,3)+extra-abs(b-p);
         end
         d=coords(i,4)+extra;
         if d>q
           d=coords(i,4)+extra-abs(d-q);
         end
        

        [mask_s]=JFMsegmentation(image(a:b,c:d,:),0.45,'blue');
        mask_s=imfill(mask_s,'holes');

         dm2=strel('diamond',6);
         mask_s=imopen(mask_s,dm2);
         [I_i,I_j]=Inercia(mask_s,CentroDeMasas(mask_s));
         I=I_i(1)/I_i(2);
         Ij=I_j(1)/I_j(2);
         if I>0.85 && I<1.35
             FR=coords(i,6);
             SF=coords(i,5);
             if (FR>0.85 && abs(I-Ij)<0.17) || (SF<0.85 && abs(I-Ij)<0.17)
            [m,n]=size(mask_s);
               mask(a:b,c:d,:)=ones(m,n);
               windowCandidates = [windowCandidates;struct('y',double(coords(i,1)),'x',...
            double(coords(i,2)),'w',double(coords(i,4)-coords(i,2)),'h',double(coords(i,3)-coords(i,1)))];
        mask_f=mask_f|mask;
             elseif abs(I-Ij)<0.17
             [m,n]=size(mask_s);
               BW=PutACircleInYourLife(zeros(size(mask_s)),min(m,n)/2,[m/2,n/2]);
                mask=PasteAMask(BW,mask,CentroDeMasas(mask));
                windowCandidates = [windowCandidates;struct('y',double(coords(i,1)),'x',...
            double(coords(i,2)),'w',double(coords(i,4)-coords(i,2)),'h',double(coords(i,3)-coords(i,1)))];
        mask_f=mask_f|mask;
             end
         
         

        end
         end 
        end

    end
end
end

    suma= (sum(sum(mask_f)));