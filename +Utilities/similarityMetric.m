function similarity = similarityMetric(referenceImage,snapshot)
            
    % Take a snapshot of the map centered around each particle and
    % then compute a similarity score between each snapshot and the 
    % reference image.

    % Take dot product between reference image and [m x m x 3] snapshot at
    % particles location. First resize images to one-dimensional
    % vectors. 
    
%     refVec = referenceImage/norm(referenceImage);
%     snapVec = snapshot/norm(snapshot);
    
    %similarity = dot(double(referenceImage),double(snapshot));
    similarity = 1 / (1 + sum(abs(referenceImage-snapshot)));
    
%     h1 = imhist(rgb2gray(referenceImage));
%     h2 = imhist(rgb2gray(snapshot));
%     similarity = 1/1+sqrt(sum((h2-h1).^2));
    %similarity = sqrt(sum((h2-h1).^2));

end
