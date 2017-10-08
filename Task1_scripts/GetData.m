%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block1
---------------------------
This script allows to get the whole data asked for in the task 1. It also
calculates the normal distribution for different data (assuming it's a
normal distribution, which is not certain for sure)
%}

%Proportion of each signal (in %)
counter=counter-1;
proportion=counter/size(files,1)*100

%ShapeFactor
[SFA,dataA] = ShapeFactor( dataset_dir,listA );
[SFB,dataB] = ShapeFactor( dataset_dir,listB );
[SFC,dataC] = ShapeFactor( dataset_dir,listC );
[SFD,dataD] = ShapeFactor( dataset_dir,listD );
[SFE,dataE] = ShapeFactor( dataset_dir,listE );
[SFF,dataF] = ShapeFactor( dataset_dir,listF );
%FillingRatio
[FRA,frdataA] = FillingRatio( dataset_dir,listA );
[FRB,frdataB] = FillingRatio( dataset_dir,listB );
[FRC,frdataC] = FillingRatio( dataset_dir,listC );
[FRD,frdataD] = FillingRatio( dataset_dir,listD );
[FRE,frdataE] = FillingRatio( dataset_dir,listE );
[FRF,frdataF] = FillingRatio( dataset_dir,listF );

%Max and min size
[Adata_w,Adata_h,Awidth,Aheight] = SizeGT( dataset_dir,listA );
[Bdata_w,Bdata_h,Bwidth,Bheight] = SizeGT( dataset_dir,listB );
[Cdata_w,Cdata_h,Cwidth,Cheight] = SizeGT( dataset_dir,listC );
[Ddata_w,Ddata_h,Dwidth,Dheight] = SizeGT( dataset_dir,listD );
[Edata_w,Edata_h,Ewidth,Eheight] = SizeGT( dataset_dir,listE );
[Fdata_w,Fdata_h,Fwidth,Fheight] = SizeGT( dataset_dir,listF );