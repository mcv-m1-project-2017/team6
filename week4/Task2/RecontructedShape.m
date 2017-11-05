function [mask_f,windowCandidates,suma]=RecontructedShape(mask_our,image,color)
%{
Juan Felipe Montesinos
Matlab 2016a
windowCandidates = [windowCandidates;struct('x',double(coords(i,1)),'y',
double(coords(2)),'w',double(coords(3)-coords(1)),'h',double(coords(4)-coords(2))];
%}

%Connected Component Labeling:
%Provides numerated mask, box, filling factor and shape factor SF.
[coords,mask_our] = CCLabeling(mask_our);
%inicialice final mask (output)
mask_f=zeros(size(mask_our));
[p,q]=size(mask_our);
c=0;
windowCandidates=[];
if strcmp(color,'red')
    if size(coords,1)>1
        for i=1:size(coords,1)
            mask=mask_our==i;
            CM(i,1:2)=CentroDeMasas(mask);
        end
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
                [b_i,b_j]=size(mask_s);
                BW=PutACircleInYourLife(zeros(size(mask_s)),min(b_i,b_j)/2,[b_i/2,b_j/2]);
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
        if (coords(i,3)-coords(i,1))>24 && (coords(i,4)-coords(i,2))>24
            if coords(i,5)>0.8 && coords(i,5)<1.27
                [I_i,~]=Inercia(mask,CentroDeMasas(mask));
                I=I_i(1)/I_i(2);
                if I>0.82 && I<1.22
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
                    
                    [edgesImg]= EdgesComputed(image,'r','canny',0.1);
                    B=bwdist(edgesImg(a:b,c:d));
                    % cropped the window candidate of bwdist mask
                    B_cropped=B;
                    [b_i,b_j]=size(B_cropped);
                    % normolization
                    NJFM=sqrt(b_i^2+b_j^2);
                    B_c_n=B_cropped/NJFM;
                    
                    % get the template masks of circles and triangle
                    mask_z=zeros(b_i,b_j);
                    YI=min(b_i,b_j);
                    [template_triangleUp]=PutATriangleInYourLife(YI,'up');
                    [mask_template_triangleUp]=PasteAMask(template_triangleUp,mask_z,[2*b_i/3,b_j/2]);
                    [template_triangleDown]=PutATriangleInYourLife(YI,'down');
                    [mask_template_triangleDown]=PasteAMask(template_triangleDown,mask_z,[b_i/3,b_j/2]);                
                    [template_circle]=PutACircleInYourLife(mask_z,YI/2,[b_i/2,b_j/2]);
                    [edge_triangleUp]= EdgesComputedTemplate(mask_template_triangleUp,'canny',0.1);
                    [edge_triangleDown]= EdgesComputedTemplate(mask_template_triangleDown,'canny',0.1);
                    [edge_circle]= EdgesComputedTemplate(template_circle,'canny',0.1);
                    
                    Sum=[];
                    M_triangleUp=B_c_n.*edge_triangleUp/(b_i*b_j);
                    clear sum;
                    Sum_triangleUp=sum(sum(M_triangleUp,2));

                    M_triangleDown=B_c_n.*edge_triangleDown/(b_i*b_j);
                    clear sum;
                    Sum_triangleDown=sum(sum(M_triangleDown,2));
                    
                    M_circle=B_c_n.*edge_circle/(b_i*b_j);
                    clear sum;
                    Sum_circle=sum(sum(M_circle,2));
                    
                    [minVal,where]=min([Sum_triangleUp,Sum_triangleDown,Sum_circle]);
                    
                    % condition for triangelUp
                    if Sum_triangleUp <= 0.003 && where==1
                        [b_i,b_j]=size(B_cropped);
                        c = [1, b_j, b_j/2];
                        r = [b_i, b_i, b_i-b_i/2*tan(60*pi()/180)];
                        BW = roipoly(b_i,b_j,c,r);
                        mask=PasteAMask(BW,mask,CentroDeMasas(mask));
                        windowCandidates = [windowCandidates;struct('y',double(coords(i,1)),'x',...
                        double(coords(i,2)),'w',double(coords(i,4)-coords(i,2)),'h',double(coords(i,3)-coords(i,1)))];
                        mask_f=mask_f|mask;
                    % condition for triangelDown
                    elseif Sum_triangleDown <= 0.003 where==2
                        [b_i,b_j]=size(B_cropped);
                        c = [1, b_j, b_j/2];
                        r = [1, 1, b_i/2*tan(60*pi()/180)];
                        BW = roipoly(b_i,b_j,c,r);
                        mask=PasteAMask(BW,mask,CentroDeMasas(mask));
                        windowCandidates = [windowCandidates;struct('y',double(coords(i,1)),'x',...
                            double(coords(i,2)),'w',double(coords(i,4)-coords(i,2)),'h',double(coords(i,3)-coords(i,1)))];
                        mask_f=mask_f|mask;
                    % condition for circle
                    elseif Sum_circle <= 0.005 where==3
                        [b_i,b_j]=size(B_cropped);
                        BW=PutACircleInYourLife(zeros(size(B_cropped)),min(b_i,b_j)/2,[b_i/2,b_j/2]);
                        mask=PasteAMask(BW,mask,CentroDeMasas(mask));
                        windowCandidates = [windowCandidates;struct('y',double(coords(i,1)),'x',...
                            double(coords(i,2)),'w',double(coords(i,4)-coords(i,2)),'h',double(coords(i,3)-coords(i,1)))];
                        mask_f=mask_f|mask;
                    end
                end
            end
        end
    end
elseif strcmp(color,'blue')
    [p,q]=size(mask_our);
    for i=1:size(coords,1)
        mask=mask_our==i;
        if (coords(i,3)-coords(i,1))>10 && (coords(i,4)-coords(i,2))>10
            if coords(i,5)>0.6 && coords(i,5)<1.27
                [I_i,~]=Inercia(mask,CentroDeMasas(mask));
                I=I_i(1)/I_i(2);
                if I>0.82 && I<1.22
                    extra=2;
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
                    
                    % get the distance transform mask for image 
                    [edgesImg]= EdgesComputed(image,'b','canny',0.1);
                    B=bwdist(edgesImg(a:b,c:d));   
                    B_cropped=B;
                    [b_i,b_j]=size(B_cropped);
                    % normolization
                    NJFM=sqrt(b_i^2+b_j^2);
                    B_c_n=B_cropped/NJFM;
                    
                    % get the template masks of circles and square
                    mask_z=zeros(b_i,b_j);
                    YI=min(b_i,b_j);
                    [template_circle]=PutACircleInYourLife(mask_z,YI/2,[b_i/2,b_j/2]);
                    [template_square]=ones(b_i,b_j);
                    [edge_circle]= EdgesComputedTemplate(template_circle,'canny',0.1);
                    [edge_square]= EdgesComputedTemplate(template_square,'canny',0.1);
                    
                    Sum=[];
                    M_circle=B_c_n.*edge_circle/(b_i*b_j);
                    clear sum;
                    Sum_circle=sum(sum(M_circle,2));
                    
                    M_square=B_c_n.*edge_circle/(b_i*b_j);
                    clear sum;
                    Sum_square=sum(sum(M_square,2));
                    [minVal,where]=min([Sum_square,Sum_circle]);
                    
                    %condition for squares 
                    if Sum_square <= 0.007 && where==1
                        [b_i,b_j]=size(B_cropped);
                        mask(a:b,c:d,:)=ones(b_i,b_j);
                        windowCandidates = [windowCandidates;struct('y',double(coords(i,1)),'x',...
                        double(coords(i,2)),'w',double(coords(i,4)-coords(i,2)),'h',double(coords(i,3)-coords(i,1)))];
                        %mask_p=zeros(size(image(:,:,1)));
                        %mask_p()=mask;
                        mask_f=mask_f|mask;
                    %condition for circles
                    elseif Sum_circle <= 0.006 && where==2
                        [b_i,b_j]=size(B_cropped);
                        BW=PutACircleInYourLife(zeros(size(mask_s)),min(b_i,b_j)/2,[b_i/2,b_j/2]);
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

    suma= (sum(sum(mask_f)));