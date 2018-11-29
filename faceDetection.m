% Create the face detector object.
faceDetector = vision.CascadeObjectDetector();
% Clear any active camera connections 
clear cam;

% Create the webcam object.
cam = webcam();

% Capture one frame to get its size.
videoFrame = snapshot(cam);
frameSize = size(videoFrame);

% Create the video player object. 
videoPlayer = vision.VideoPlayer('Position', [100 100 [frameSize(2), frameSize(1)]+30]);
run=true;
while run
    % Get the next frame.
    videoFrame = snapshot(cam);
    % get grey scale image of frame
   videoFrameGray = rgb2gray(videoFrame);

     % Detect bounding boxs for face from grey image.
     bbox = faceDetector.step(videoFrameGray);

     % if we detect faces, insert a rectange into frame
     if ~isempty(bbox)
     % insert bounding box around the detected face.
            videoFrame = insertShape(videoFrame, 'Rectangle', bbox, 'LineWidth', 3);
     end
    % Display the annotated video frame using the video player object.
    step(videoPlayer, videoFrame);

     % Check whether the video player window has been closed.
    run = isOpen(videoPlayer);
end

% Clean up.
clear cam;
release(videoPlayer);