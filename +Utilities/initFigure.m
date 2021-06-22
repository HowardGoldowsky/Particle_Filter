function handles = initFigure(configParams, env, drone, PF)

    import Utilities.*
    
    % create and size a figure
    handles.figHandle = figure(1);                        
    figDefaultSize = configParams.figDefaultSize;
    figScaleRatio = configParams.figScaleRatio;   
    set(gcf, 'Position',  [configParams.figX, configParams.figY, round(figDefaultSize*figScaleRatio), round(figDefaultSize/figScaleRatio)]);
    [~,mapName,~] = fileparts(configParams.imageName);
    tmpStr = sprintf('Drone Flying Over %s',mapName);
    title(tmpStr);
    
     % plot image and hold
    image(env.imageArray);  
    title(tmpStr);
    hold on;

    % place agent on image
    radius = drone.m;
    [xLocation,yLocation] = createCircle(drone.pixelIdx(1),drone.pixelIdx(2),radius);
    handles.handleCircle = plot(xLocation,yLocation,'LineWidth',3,'Color','k');
    handles.handleFill = fill(xLocation,yLocation,[1,1,1]);
    tmpStr = sprintf('[%s,%s]',num2str(round(drone.pos(1)),2),num2str(round(drone.pos(2),2)));
    handles.handleAnnotation = text(drone.env.numPixelsX - 400, -50, tmpStr, 'Color', 'k', 'FontWeight', 'bold');
    
    handles.handleParticles = displayParticleCloud(PF,env);
    
    set(gca,'xticklabel',[])
    set(gca,'yticklabel',[])
    
end

