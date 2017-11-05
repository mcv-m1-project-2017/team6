function [FR]=FRJFM(mask)
[m,n]=size(mask);
%{
Juan Felipe Montesinos
Matlab 2016a
2017

Calculate Filling Ratio for a given binary mask

%}
FR=sum(sum(mask))/(m*n);