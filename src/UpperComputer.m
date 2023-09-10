%用于接受stm32采集到的4通道脑电信号

clc;
clear;
close all;
    
delete(instrfindall); %删除串口所有信息，方便下次使用  
s = serial('com3'); %选择串口号  
s.BytesAvailableFcnMode='byte';  % 串口设置
s.InputBufferSize=4096; % 输入缓冲区大小
s.OutputBufferSize=1024;    % 输出缓冲区大小
s.BytesAvailableFcnCount=100;   % 输入缓冲区中必须可用的字节数
s.ReadAsyncMode='continuous';   % 异步读取连续操作
s.Terminator='CR';  %  回车为停止终止符
set(s,'BaudRate',1000000,'StopBits',1,'Parity','none');  % 设置波特率  停止位  校验位  
fopen(s);   % 打开串口
fid=fopen('../data/serial_data.txt','wt');
fwrite(s,100,'uint8');  % 向单片机发送握手信号 

data = [];
ch1 = [];
ch2 = [];
ch3 = [];
ch4 = [];
i = 1;

num_points = 2500;

while i<num_points
    out = fread(s,4,'uint8');   % 一次读出4个字符
    num = typecast(fliplr(uint8([out(4) out(3) out(2) out(1)])), 'uint32');
    data(i) = typecast(fliplr(uint8([out(4) out(3) out(2) out(1)])), 'uint32');
    if bitshift(bitand(data(i), 0x8000),-15)%按位与第16位
        ch1 = [ch1, data(i)-0x8000];
    end
    if bitshift(bitand(data(i), 0x4000),-14)
        ch2 = [ch2, data(i)-0x4000];
    end
    if bitshift(bitand(data(i), 0x2000),-13)
        ch3 = [ch3, data(i)-0x2000];
    end
    if bitshift(bitand(data(i), 0x1000),-12)
        ch4 = [ch4, data(i)-0x1000];
    end
    fprintf(fid,'%g\n',num);
    i = i + 1;
    disp(i);
end