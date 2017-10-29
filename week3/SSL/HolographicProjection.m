function [N,p,q]=HolographicProjection(mask)
%{
Juan Felipe Montesinos
Matlab 2016a
2017
%}


H=imbinarize(sum(mask));
V=imbinarize(sum(mask,2));
if sum(H)+sum(V) ~=0
c=1;

if H(1) == 0
    
    for i=2:size(H,2)
        if H(i)~=H(i-1) && H(i)==0
            u(c)=i-1;
            c=c+1;
        elseif H(i)~=H(i-1) && H(i)==1
            u(c)=i;
            c=c+1;
        end
    end
    if(H(end))==1
        u(end+1)=size(H,2);
    end
else
    u(1)=1;
    c=2;
    for i=2:size(H,2)
        if H(i)~=H(i-1) && H(i)==0
            u(c)=i-1;
            c=c+1;
        elseif H(i)~=H(i-1) && H(i)==1
            u(c)=i;
            c=c+1;
        end
    end 
    if(H(end))==1
        u(end+1)=size(H,2);
    end
end

c=1;

if V(1) == 0
    
    for i=2:size(V,1)
        if V(i)~=V(i-1) && V(i)==0
            v(c)=i-1;
            c=c+1;
        elseif V(i)~=V(i-1) && V(i)==1
            v(c)=i;
            c=c+1;
        end
    end
    if(V(end))==1
        v(end+1)=size(V,1);
    end
else
    v(1)=1;
    c=2;
    for i=2:size(V,1)
        if V(i)~=V(i-1) && V(i)==0
            v(c)=i-1;
            c=c+1;
        elseif V(i)~=V(i-1) && V(i)==1
            v(c)=i;
            c=c+1;
        end
    end 
    if(V(end))==1
        v(end+1)=size(V,1);
    end
end

n=1;
for i=1:2:length(u)
    for j=1:2:length(v)
        if FRJFM(mask(v(j):v(j+1),u(i):u(i+1)))>0.1
            p(n)=u(i);
            p(n+1)=u(i+1);
            q(n)=v(j);
            q(n+1)=v(j+1);
            n=n+2;
        end
    end
end

N=length(p)/2;
else
    N=0;
    p=0;
    q=0;
end