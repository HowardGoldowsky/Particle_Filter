function [xLocation,yLocation] = createCircle(xPos,yPos,radius)

% Generates the x- and y-location samples for a cricle at (xPos,yPos) and
% given radius.

    angleDeg = 0:pi/50:2*pi;
    xLocation = radius * cos(angleDeg) + xPos;
    yLocation = radius * sin(angleDeg) + yPos;

end % function

