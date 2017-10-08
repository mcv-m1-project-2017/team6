%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block1
---------------------------

Start up file to required paths.
%}
addpath('Color_functions');
addpath('Task1_scripts');
addpath('Task2');
addpath('Task4');

%Define directory of training set
%Important not to forget the final \
%The folder where color images .jpg, mask folder and gt mask are save MUST
%be called train
dataset_dir='B:\train\';

Split_by_types;