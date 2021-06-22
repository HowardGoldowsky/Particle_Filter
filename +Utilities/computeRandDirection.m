function [deltaPos] = computeRandDirection(distance)

    % Computes a random direction of unit length
    
    dx = 2*distance*rand - distance;        % rand value between -1:1 
    dy = sqrt(distance-dx^2);               % constrain distance travelled to one unit in any direction
    dy = dy*sign(rand - 0.5);               % give dy a random direction
    deltaPos = [dx, dy];
    
end

