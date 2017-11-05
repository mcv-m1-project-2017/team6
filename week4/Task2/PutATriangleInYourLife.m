function [BW]=PutATriangleInYourLife(L,orientation)
%{
Juan Felipe Montesinos
Matlab 2016a
Crea un triangulo equilatero de base L paralela al eje j orientado a
eleccion:
orientation: 'up' 
     0     0     0     0     0     0     0     0     0     0
     0     0     0     0     1     0     0     0     0     0
     0     0     0     0     1     1     0     0     0     0
     0     0     0     1     1     1     0     0     0     0
     0     0     0     1     1     1     1     0     0     0
     0     0     1     1     1     1     1     0     0     0
     0     0     1     1     1     1     1     1     0     0
     0     0     1     1     1     1     1     1     0     0
     0     1     1     1     1     1     1     1     1     0
     0     1     1     1     1     1     1     1     1     1

orientation: 'down' 
     0     0     0     0     0     0     0     0     0     0
     0     1     1     1     1     1     1     1     1     0
     0     0     1     1     1     1     1     1     0     0
     0     0     1     1     1     1     1     1     0     0
     0     0     0     1     1     1     1     0     0     0
     0     0     0     1     1     1     0     0     0     0
     0     0     0     0     1     1     0     0     0     0
     0     0     0     0     1     0     0     0     0     0
     0     0     0     0     0     0     0     0     0     0
     0     0     0     0     0     0     0     0     0     0
%}

c = [1, L, L/2];
if strcmp(orientation,'up')
r = [L-1, L-1, L-1-L/2*tan(60*pi()/180)];

elseif strcmp(orientation,'down')
    r = [1, 1, L/2*tan(60*pi()/180)];
end
 BW = roipoly(L,L,c,r);