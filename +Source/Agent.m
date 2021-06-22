classdef Agent
    
    % Agent class for the drone
    
    properties
        env                 % the environment in which the agent resides
        pos                 % [x, y] position in agent's coordinate system
        deltaPos            % [dx, dy] movement vector in agent's coordinate system
        pixelIdx            % pixel index of agent's position in the image's coordinate system
        m                   % side length of square observation image, z (value from 25 to 100 pixels)
        z                   % [m x m x 3], agent's observation image
        speed               % radius of circle agent moves in one iteration
    end % properties
    
    methods
        
        function obj = Agent(configParams,env)                     % constructor    
            
            import Utilities.*           
            pos = initRandPosition(env);            % create a random initial position      
            obj.m = configParams.m; 
            obj.speed = configParams.agentSpeed;
            obj.env = env;
            obj.pixelIdx = pos2pixel(env.posX, env.posY, pos); 
            obj.pos = pos;
            obj.deltaPos = [0,0];
            
        end
        
        function obj = computeMovement(obj)  
            
            % Computes agent's movement and returns the agent's position
            % property values after movement is completted.
            
            import Utilities.*     

            tempDeltaPos = computeRandDirection(obj.speed);
            
            %tempDeltaPos = [0, 0]; % debug
            
            % Buffer distance to compute a full reference image and to 
            % prevent agent from moving off map.           
            tempPos = verifyPosition(obj,tempDeltaPos);
            
            % Save position and movement params
            obj.pos = tempPos;
            obj.pixelIdx = pos2pixel(obj.env.posX, obj.env.posY, tempPos);
            obj.deltaPos = tempDeltaPos;
            
        end
     
    end % methods
    
end % class

