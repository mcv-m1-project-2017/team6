function [mask]=MorphologicalTransform(mask)
sq2=strel('square',2); 
ds2=strel('disk',2); 
sq10=strel('square',6);
dm2=strel('diamond',4); 
dm10=strel('diamond',10); 
 ds20=strel('disk',20);
  ds10=strel('disk',10);
mask=imdilate(mask,sq10);
mask=imfill(mask,'holes');
mask=imerode(mask,sq10);
mask=imerode(mask,dm2);
mask=imerode(mask,dm2);
mask=imdilate(mask,dm2);
mask=imdilate(mask,dm2);
mask=imopen(mask,ds10);

