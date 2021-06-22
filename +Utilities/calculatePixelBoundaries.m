function [bound] = calculatePixelBoundaries(imageArray,posX, posY, agentPos, m)

    % Calculates the indexes to the pixels at the boundary of a reference
    % image.
    import Utilities.*
    
    [pixelIdx] = pos2pixel(posX, posY, agentPos);   % center pixel
    bound.pixX1 = pixelIdx(1)-ceil(m/2);                  % X lower boundary
    bound.pixX2 = pixelIdx(1)+ceil(m/2);                  % X upper boundary
    bound.pixY1 = pixelIdx(2)-ceil(m/2);                  % Y lower boundary
    bound.pixY2 = pixelIdx(2)+ceil(m/2);                  % Y upper boundary
    
    [nRow, nCol, ~] = size(imageArray);
    
    if bound.pixX1 <= 0
        bound.pixX1 = bound.pixX1 + 2.5*m;
        bound.pixX2 = bound.pixX2 + 2.5*m;
    end
    if bound.pixX2 >= nRow
        bound.pixX1 = bound.pixX1 - 2.5*m;
        bound.pixX2 = bound.pixX2 - 2.5*m;       
    end
    
    if bound.pixY1 <= 0
        bound.pixY1 = bound.pixY1 + 2.5*m;
        bound.pixY2 = bound.pixY2 + 2.5*m;
    end
    if bound.pixY2 >= nCol
        bound.pixY1 = bound.pixY1 - 2.5*m;
        bound.pixY2 = bound.pixY2 - 2.5*m;     
    end
end

