function TrafficSignDetection(directory, window_method, decision_method)
    % TrafficSignDetection
    % Perform detection of Traffic signs on images. Detection is performed first at the pixel level
    % using a color segmentation. Then, using the color segmentation as a basis, the most likely window 
    % candidates to contain a traffic sign are selected using basic features (form factor, filling factor). 
    % Finally, a decision is taken on these windows using geometric heuristics (Hough) or template matching.
    %
    %    Parameter name      Value
    %    --------------      -----
    %    'directory'         directory where the test images to analize  (.jpg) reside
    %    'pixel_method'      Name of the color space: 'opp', 'normrgb', 'lab', 'hsv', etc. (Weeks 2-5)
    %    'window_method'     'SegmentationCCL' or 'SlidingWindow' (Weeks 3-5)
    %    'decision_method'   'GeometricHeuristics' or 'TemplateMatching' (Weeks 4-5)

    
    %Read files in the directory and convert it to a matrix of chars
     files = ListFilesClear(directory);
     for i=1:size(files,1)
        files1(i,1:9)=files(i).name;
     end
     
     for i=1:size(files1,1)
         
        %Read color images
        image=imread([directory,files1(i,:),'.jpg']);
        if strcmp(window_method,'SegmentationCCL')
        %Segmentate and filter red channel
        [mask_ourRED]=JFMsegmentation(image,0.48,'red');
        [mask_ourRED]=MorphologicalTransform(mask_ourRED);
        [RS_RED,WCR,suma1]=RecontructedShape(mask_ourRED,image,'red');
        %Segmentate and filter blue channel
        Ic=rgb2hsv(image);
        Ic(:,:,3)=histeq(Ic(:,:,3));
        image=hsv2rgb(Ic);
        [mask_ourBLUE]=ColorSegmentation(image,'blue');
        [mask_ourBLUE]=MorphologicalTransform(mask_ourBLUE);
        [RS_BLUE,WCB,suma2]=RecontructedShape(mask_ourBLUE,image,'blue');
        %Compose final mask as an OR
        sumatorio=suma1+suma2;
        windowCandidates=[WCB;WCR];
             if sumatorio ~=0
                mask_our=RS_BLUE | RS_RED;
                
             else
                mask_our= mask_ourBLUE | mask_ourRED;
             end
        
        
        elseif strcmp(window_method,'SlidingWindow')
        [mask_ourRED]=JFMsegmentation(image,0.48,'red');
        [mask_ourRED]=MorphologicalTransform(mask_ourRED);
        %Segmentate and filter blue channel
        Ic=rgb2hsv(image);
        Ic(:,:,3)=histeq(Ic(:,:,3));
        image=hsv2rgb(Ic);
        [mask_ourBLUE]=ColorSegmentation(image,'blue');
        [mask_ourBLUE]=MorphologicalTransform(mask_ourBLUE);
        mask_our= mask_ourBLUE | mask_ourRED;
            [windowCandidates,mask_our]=AutoSlidingW(mask_our,5,5,[170,170]);
            
        end
        %Save masks and mat files
        SaveMask([directory,'results\mask\'],files1(i,:),mask_our);
        save([directory,'results\matfiles\','mask.',files1(i,:),'.mat'],'windowCandidates');
     end
     