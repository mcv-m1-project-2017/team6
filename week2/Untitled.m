mask_in = imread('F:\Study_Master\M1\project\week1\maskWeGot\mask.01.002168.png');
[op]=MorphologicalTransform(mask_in);
imshow(op);