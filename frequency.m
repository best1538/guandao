%y_power������
%y_p���߷�����ֵ
%y_ft������һ���Ƶ��
function  [y_ft,y_p,y_power ]=frequency(data)

Fs = 500;            % Sampling frequency
L = length(data);     % Length of signal
y_ft = Fs*(0:(L/2))/L;  %������һ���Ƶ��
Y = fft(double(data));
P2 = abs(Y/L);
y_p = P2(1:L/2+1);
y_p = 2*y_p(2:end-1);%���߷�����ֵ
y_power=y_p.*y_p;
end


