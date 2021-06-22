function [imageArray, numPixelsY, numPixelsX] = readImage(imageName)

    % Returns a map and its dimensions.

    tmpImage = importdata(imageName);
    [~,fileName,~] = fileparts(imageName);
    
    % different file names have slightly different formats
    switch(fileName)
        
        case 'MarioMap'
              imageArray = tmpImage;
              
        case 'BayMap'
            imageArray = tmpImage.cdata;
            
        case 'CityMap'
            imageArray = tmpImage.cdata;
            
        case 'TestImage'
            imageArray = tmpImage;
            
    end % switch
    
    [numPixelsY, numPixelsX, ~] = size(imageArray);
    
end % function

