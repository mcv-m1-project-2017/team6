function [op]=MorphologicalTransform(mask_in)
sq2=strel('square',2); 
ds2=strel('disk',2); 
sq20=strel('square',20);
sq10=strel('square',10);
 ds20=strel('disk',20);
  ds10=strel('disk',10);
sq30=strel('square',30);
 ds30=strel('disk',30);

mask=imfill(mask_in,'holes');
er=imerode(mask,ds2);
er=imerode(er,ds2);

di=imdilate(er,sq2);
di=imdilate(di,sq2);

op=imopen(di,ds10);
