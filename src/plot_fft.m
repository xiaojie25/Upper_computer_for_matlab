%本函数用于绘制输入数据的频域图
function plot_fft(time_data, fs)
    figure();clf;
    [f, X_w] = fft_fft(time_data, fs);
    plot(f, X_w);
    
end