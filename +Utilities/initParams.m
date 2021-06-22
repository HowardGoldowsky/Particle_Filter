function configParams = initParams()

    import Utilities.*

    clear;
    
    % Initialize simulation parameters
    configParams.m = 25;                                            % side length of agent's square reference observation
    configParams.p2uRatio = 50;                                     % pixel to position units ratio for this environment
    imageName = 'BayMap.png';
    configParams.imageName = imageName;
    [imageArray, numPixelsY, numPixelsX] = readImage(imageName);
    configParams.imageArray = imageArray;
    configParams.numPixelsY = numPixelsY;
    configParams.numPixelsX = numPixelsX;
    configParams.figScaleRatio = numPixelsX/numPixelsY;             % natural scaling ratio for image
    configParams.figDefaultSize = 500;                              % default figure size
    configParams.figX = 500;                                        % location of figure on screen
    configParams.figY = 500;
    configParams.agentSpeed = 1;                                    % radius of circle agent moves in one iteration
    configParams.motionModelsigma = 1;                            % variance of noise in the particle filter's motion model
    
    % Particle filter params
    configParams.numParticles = 1000;

end

