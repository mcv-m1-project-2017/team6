function [windowCandidates,mask_o]=AutoSlidingW(mask,step_i,step_j,box)
%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block3
---------------------------
Implement Sliding Window using integral image
mask: original mask
step_i: amount of pixel to move in each iteration (i axis)
step_j: amount of pixel to move in each iteration (j axis)
box: 1 by 2 vector with box size [size_i,size_j]
%}
%Size of the mask
[m,n]=size(mask);
%Inicialize indexes
i=2;
%Size of the SSL box
si=box(1);
sj=box(2);
%Main loop, moves the box all around the mask
c=0;
d=0;
IntegralImg = cumsum(cumsum(double(mask)),2);
    

    while (i+si)<=n
    j=2;
    while (j+sj)<=m
       % [CM]=CentroDeMasas(mask(i:i+si,j:j+sj));
       % [I_i,~]=Inercia(mask(i:i+si,j:j+sj),CM);
       % I=I_i(1)/I_i(2);
       %calculates filling ratio
       FR=(IntegralImg(j+box(1)-1,i+box(2)-1)-IntegralImg(j-1,i+...
           box(2)-1)-IntegralImg(j+box(1)-1,i-1)+IntegralImg(j-1,i-1))/(box(1)*box(2));
        %if FRJFM(mask(i:i+si,j:j+sj))>0.95

            
       % elseif FRJFM(mask(i:i+si,j:j+sj))>0.5 && FRJFM(mask(i:i+si,j:j+sj))<=0.95
          if FR>0.35 && FR<=0.95
            c=c+1;
            box_out(c,1:4)=[i,j,i+si,j+sj];
            
        end
       % if I>0.75 && I<1.25
            
           % d=d+1;
         %   box_out_inercia(d,1:4)=[i,j,i+si,j+sj];
     %   end
      j=j+step_j;  
    end
    i=i+step_i;
    
end
mask_o=zeros(size(mask));
%Store window cantidates
if ~exist('box_out')
        w_pos = [1, 1, 1, 1];
else
        w_pos=box_out;
        [unic, ia] = unique(w_pos(:,1)); % x vector
        w_pos = w_pos(ia,:);
        w_pos = w_pos(1:10:end,:);
end   
    
    CCBoxes(:,1) = struct('y', w_pos(:,2), 'x' , w_pos(:,1), 'w', w_pos(:,3)-w_pos(:,1), 'h', w_pos(:,4)-w_pos(:,2));
%     clear w_pos
    
    j=1;
    while j<=length(CCBoxes.x) % for each windowCanidate
        mask_o(w_pos(j,2):w_pos(j,4),w_pos(j,1):w_pos(j,3))= mask(w_pos(j,2):w_pos(j,4),w_pos(j,1):w_pos(j,3));
        windowCandidates(j,1) = struct('y', CCBoxes.y(j), 'x', CCBoxes.x(j), 'w', CCBoxes.w(j), 'h', CCBoxes.h(j));
        j = j + 1;
    end
    