function [pixelIdx] = pos2pixel(posX, posY, pos)

    % Converts a position in the agent's coordinate frame to to a pixel
    % location on the image. Assumes image's top left pixel location is
    % (0,0).
    
    % INPUT
    %   pos: [x, y], position in units
    %   posX: vector of position centers in the x direction
    %   posY: vector of position centers in the y direction
    % 
    % OUTPUT
    %   pixelX: index of pixel in x-direction
    %   pixelY: index of pixel in y-direction
    
    idxPixelX = find(posX >= pos(1), 1, 'first');
    
    if isempty(idxPixelX) % check for being slightly over the last pixel
        idxPixelX = length(posX);
    end
    
    idxPixelY = length(posY) - find(posY >= pos(2), 1, 'first');
    
    if isempty(idxPixelY) % check for being slightly over the last pixel
        idxPixelY = length(posY);
    end
    
    pixelIdx = [idxPixelX,idxPixelY];   
    
end

