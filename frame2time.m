
% frameNum为帧数
% framelen为帧长
% inc为帧移
% fs为频率
function frameTime=frame2time(frameNum,inc,fs)

frameTime=((1:frameNum)-1)*inc/fs;
