function pos = verifyPosition(agent,tempDeltaPos)

    % Verifies that the passed-in position will not go over the pixel
    % border where we can no longer take a snapshot of the image. If the
    % agent moves over the border, then we send it in the opposite
    % direction.
    
    % INPUT
    %   agent       : agent object
    %   tempDeltaPos: proposed change in position
    
    bufferLowX  = agent.env.posX(1)   + 1.5*agent.m / agent.env.p2uRatio;   
    bufferHighX = agent.env.posX(end) - 1.5*agent.m / agent.env.p2uRatio;  
    bufferLowY  = agent.env.posY(1)   + 1.5*agent.m / agent.env.p2uRatio;   
    bufferHighY = agent.env.posY(end) - 1.5*agent.m / agent.env.p2uRatio;   
    
    pos = agent.pos + tempDeltaPos;

    if (pos(1) <= bufferLowX || pos(1) >= bufferHighX...
            || pos(2) <= bufferLowY ||  pos(2) >= bufferHighY)

        tempDeltaPos = -tempDeltaPos;
        pos = agent.pos + tempDeltaPos;

    end
    
end

