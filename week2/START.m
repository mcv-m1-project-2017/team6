%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block2
---------------------------

Start up file to required paths.
%}
addpath('Color_functions');
addpath('Task1');
addpath('Task2');
addpath('Task3');
addpath('Task4');
addpath(genpath('.'));

%Define directory of training set
%Important not to forget the final \
%The folder where color images .jpg, mask folder and gt mask are save MUST
%be called train
dataset_dir='F:\Study_Master\M1\project\week1\train\';

Split_by_types;