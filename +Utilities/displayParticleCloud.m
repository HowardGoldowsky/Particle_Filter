function [handleParticles] = displayParticleCloud(PF,env)

    % Displays the particles on the map. Each particle's radius is
    % proportional to its weight.
    
    import Utilities.*
    numParticles = PF.numParticles;
    handleParticles = zeros(numParticles,1);

    for j=1:1:numParticles
        pos = PF.X_bar.pos(j,:);    % [x,y] position of particle
%         w=PF.X_bar.w(j);
        w = 1;
        [pixelIdx] = pos2pixel(env.posX, env.posY, pos);
        [x,y] = createCircle(pixelIdx(1),pixelIdx(2),16*w);
        handleParticles(j) = plot(x,y,'r');
    end
    
end

