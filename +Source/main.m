% Main program for Homework #2, particle filter.

import Utilities.*
import Source.*

configParams = initParams();                        % initialize figure parameters
env = Environment(configParams);                    % create the agent's environment
drone = Agent(configParams, env);                   % create the agent
PF = ParticleFilter(env, drone, configParams);      % create particle filter
handles = initFigure(configParams, env, drone, PF); % draw initial map, agent, and particles

% Run sim

while (1)
    

    PF = PF.motionModel(env, drone);
    PF = PF.Resampling();               
    %PF = PF.lowVarianceResampling(); % stochastic universal resampling
    
    % Delete handles from previous iteration
    delete(handles.handleCircle);
    delete(handles.handleAnnotation);
    delete(handles.handleFill);
    
    handleParticles = handles.handleParticles;
    for j=1:length(handleParticles)
        delete(handleParticles(j));
    end
    
    % Move drone and compute new handles
    radius = drone.m;
    drone = drone.computeMovement;
    [xCircLoc,yCircLoc] = createCircle(drone.pixelIdx(1),drone.pixelIdx(2),radius);
    handles.handleCircle = plot(xCircLoc,yCircLoc,'LineWidth',3,'Color','k');
    handles.handleFill = fill(xCircLoc,yCircLoc,[1,1,1]);
    tmpStr = sprintf('pos = [%s, %s]',num2str(round(drone.pos(1),2)),num2str(round(drone.pos(2),2)));
    handles.handleAnnotation = text(drone.env.numPixelsX - 400, -50, tmpStr, 'Color', 'k', 'FontWeight', 'bold');
    handles.handleParticles = displayParticleCloud(PF,env);
    
    pause(.1);
 %   result = input('Enter to run. CTRL-C to stop.');
    
end
