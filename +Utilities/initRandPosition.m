function randPos = initRandPosition(env)

    % Create a random initial position for the agent, based on a
    % uniform distribution.

    import Utilities.*
    randPixelX = floor(rand * env.numPixelsX);
    randPixelY = floor(rand * env.numPixelsY);
    randPos = [env.posX(randPixelX), env.posY(randPixelY)];
    
    %randPos = [env.posX(1000), env.posY(500)]; % debug

end