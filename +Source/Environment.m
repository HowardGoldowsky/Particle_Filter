classdef Environment
    
    % Describes the agent's environment 
    
    properties
        mapName                 % name of the png image map file
        imageArray              % [numPixelsX x numPixelsY x 3] color image
        p2uRatio                % pixel to position units ratio for this environment
        numPixelsY              % number of pixels in y-dim of image
        numPixelsX              % number of pixels in x-dim of image
        posX                    % [numPixelsX/p2uRatio x 1], x coordinates of units in continuous frame 
        posY                    % [numPixelsX/p2uRatio x 1], y coordinates of units in continuous frame 
    end % properties
    
    methods
        
        function obj = Environment(configParams) % constructor
            
            import Utilities.*
            [obj.posX, obj.posY] = pixel2pos(configParams.numPixelsX, configParams.numPixelsY, configParams.p2uRatio);            
            obj.imageArray = configParams.imageArray;
            obj.numPixelsY = configParams.numPixelsY;
            obj.numPixelsX = configParams.numPixelsX;
            obj.p2uRatio = configParams.p2uRatio;
            
        end
        
    end % methods
    
end % class

