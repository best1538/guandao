
% frameNumΪ֡��
% framelenΪ֡��
% incΪ֡��
% fsΪƵ��
function frameTime=frame2time(frameNum,inc,fs)

frameTime=((1:frameNum)-1)*inc/fs;
