function [f, X_w] = fft_fft(data, fs)
% describe：单边傅里叶变化
% input：
%     data：数据的时域表现
%     fs：采样频率
% output：
%     f：频率的横坐标
%     X_w：频域幅值

clone_data = data;
n = length(clone_data);      %采样个数
if mod(n,2)
    n = n - 1;
    clone_data = clone_data(1:n);
else
    n = n;
end
t = 0:1/fs:(n-1)/fs;
fft_s = fft(clone_data,n);
fft_s_abs = abs(fft_s)*2/n; %单位换算为时域幅度
fft_s_abs(1) = fft_s_abs(1) / 2;
X_w = fft_s_abs(1:n/2);%取单边频谱
f = 0:fs/n:(fs-fs/n)/2;   %横坐标单边频率
end