%y_power是能量
%y_p单边幅度谱值
%y_ft采样的一半的频率
function  [y_ft,y_p,y_power ]=frequency(data)

Fs = 500;            % Sampling frequency
L = length(data);     % Length of signal
y_ft = Fs*(0:(L/2))/L;  %采样的一半的频率
Y = fft(double(data));
P2 = abs(Y/L);
y_p = P2(1:L/2+1);
y_p = 2*y_p(2:end-1);%单边幅度谱值
y_power=y_p.*y_p;
end


