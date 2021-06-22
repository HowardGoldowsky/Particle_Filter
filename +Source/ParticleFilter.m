classdef ParticleFilter
    
    % ParticleFilter class. Implements a motion model and observation model
    % via Monte Carlo Localization. Employs Low Variance Resampling
    
    properties
        X               % particle set: X.pos = [x,y], X.w = weight
        X_bar           % temporary belief sample set after motion model
        numParticles    % number of particles in particle filter
        sigma           % sigma for noise in motion model
    end
    
    methods
        
        function obj = ParticleFilter(env, agent, configParams)  % constructor
            
            numParticles = configParams.numParticles;
                       
            numUnitsX = max(env.posX) - agent.m / env.p2uRatio; % don't let particles get too close to edge of image
            numUnitsY = max(env.posY) - agent.m / env.p2uRatio;
            
            obj = initParticleSets(obj,numUnitsX,numUnitsY,numParticles); 
            obj.numParticles = numParticles;           
            obj.sigma = configParams.motionModelsigma;
            
            
        end
        
        function obj = initParticleSets(obj,numUnitsX,numUnitsY,numParticles)
       
            partPosX = 2*numUnitsX * rand(numParticles,1) - numUnitsX;      % uniform distribution in x
            partPosY = 2*numUnitsY * rand(numParticles,1) - numUnitsY;      % uniform distribution in y
            
            obj.X_bar.pos = [partPosX,partPosY];                            % uniform in [x,y]
            obj.X_bar.w = ones(numParticles,1);                             % init particle weights
            
            obj.X.pos = zeros(size(obj.X_bar.pos));
            obj.X.w = zeros(size(obj.X_bar.w));
           
        end
        
        function obj = motionModel(obj, env, agent)
            
            % Returns a particle filter's temporary sample set after the 
            % motion model but before resampling.
            
            % This is a prediction. Agent will have a Gaussian cloud added 
            % to its actual position. Each particle will represent one 
            % possible location in this Gauassian cloud. Each particle does 
            % not know about the other particles. 
            
            import Utilities.*
            
            J = obj.numParticles;
            
            obj.X_bar.pos = obj.X_bar.pos + agent.deltaPos; % move particles

%             deltaX = obj.sigma * randn;    % add Gaussian sensor noise to observation position
%             deltaY = obj.sigma * randn;           
%             obsPos = verifyPosition(agent,[deltaX,deltaY]);

            obsPos = agent.deltaPos;
%     
            imageArray = env.imageArray;
            
            % Calculate pixel boundaries of the reference image, create
            % reference image, and then resize into a one-dimensional
            % vector (only once) for fast processing.
            
            bounds = calculatePixelBoundaries(imageArray,env.posX, env.posY, obsPos, agent.m);             % use observation position for reference image
            referenceImage = imageArray(bounds.pixY1:bounds.pixY2,bounds.pixX1:bounds.pixX2,:); % [m x m x 3] image around agent's true position
            [nRow, nCol, nZ] = size(referenceImage);
            referenceImage = reshape(referenceImage,nRow * nCol * nZ, 1);
            
            % Compute particles' weights via an observation model 
            for j = 1:J
                posParticle = obj.X_bar.pos(j,:);
                [snapshotBounds] = calculatePixelBoundaries(imageArray, env.posX, env.posY, posParticle, agent.m); 
                snapshot = imageArray(snapshotBounds.pixY1:snapshotBounds.pixY2,snapshotBounds.pixX1:snapshotBounds.pixX2,:); % [m x m x 3] image around particles's position
                snapshot = reshape(snapshot,nRow * nCol * nZ, 1);
                w(j) = similarityMetric(referenceImage,snapshot); %#ok<AGROW>
            end
            
            obj.X_bar.w = w' ./ [obj.sigma * randn(J,1) + obsPos(1),obj.sigma * randn(J,1) + obsPos(2)];          % Importance sampling step         
            
        end
        
        function obj = lowVarianceResampling(obj)
            
            % Function converts set of N particles of different weights at 
            % one distribution of position to an isomorphic set of N 
            % particles of equal weights and a different distribution of 
            % position. Otherwise known as Stochastic Universal Resampling.
            
            w = obj.X_bar.w / sum(obj.X_bar.w);     % normalize weights to between 0:1
            J = obj.numParticles;          
            r = rand*(1/J);                         % draw random number between 0 and 1/J
            c = w(1);
            i = 1;
            
            for j=1:J           
                U = r + (j - 1) / J;  
                while U > c
                    i = i + 1;
                    c = c + w(i);
                end 
                var = 0.01*[randn,randn];
                obj.X.pos(j,:) = obj.X_bar.pos(i,:) + var; % add some Gaussian noise to particle position
            end   
            obj.X_bar = obj.X;
        end
        
        function obj = Resampling(obj)
            
            % Function converts set of N particles of different weights at 
            % one distribution of position to an isomorphic set of N 
            % particles of equal weights and a different distribution of 
            % position. 
            
            w = obj.X_bar.w / sum(obj.X_bar.w);                 % normalize weights to between 0:1
            J = obj.numParticles;   
            cumMF = cumsum(w);                                  % cumulative mass function
            
            for j = 1:J
                idx = find(rand < cumMF, 1, 'first');
                var = [.1*randn,.1*randn];
                obj.X.pos(j,:) = obj.X_bar.pos(idx,:) + var; % add some Gaussian noise to the particle's position
            end
            obj.X_bar = obj.X;
        end
        
    end % methods
end % class

