function [posX, posY] = pixel2pos(numPixelsX, numPixelsY, p2uRatio)
    
    % Converts discrete pixel coordinates of the image to a continuous 
    % position in the agent's reference frame, given a pixel2unit scaling 
    % ratio. The center of the agent's reference frame must be (0,0).
    
    % INPUT: 
    %   numPixelsX: x-dim of image in pixels
    %   numPixelsY: y-dim of image in pixels
    %   p2uRatio:   ratio of pixels to units
    %
    % OUTPUT
    %   pixel2posMap: An array of dimensions [numPixelsX x numPixelsY] that
    %   maps the agent's coordinate system in units to the image's discrete
    %   coordinate system. 
    
    numUnitsX = floor(numPixelsX/p2uRatio);  % account for uneven division by using ceil()
    numUnitsY = floor(numPixelsY/p2uRatio);
    
    posX = -numUnitsX/2 : (numUnitsX/numPixelsX) : numUnitsX/2;
    posY = -numUnitsY/2 : (numUnitsY/numPixelsY) : numUnitsY/2;    
        
end

