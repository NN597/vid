%% 初始化摄像头
% 获取摄像头信息（可选，用于调试设备参数）

% 创建视频采集对象
vid = videoinput('winvideo', 1, 'YUY2_640x480'); % 参数说明：
% 'winvideo' - Windows系统摄像头驱动
% 1          - 第一个摄像头设备（如果是外接摄像头可能需要改为2）
% 'YUY2_640x480' - 视频格式（如果报错需调整格式，可尝试'MJPG_640x480'等）

% 配置采集参数
vid.ReturnedColorSpace = 'rgb';  % 获取RGB格式图像
triggerconfig(vid, 'manual');    % 手动触发模式
start(vid);                      % 启动摄像头

%% 创建显示窗口
hFig = figure('Name', '摄像头实时画面',...
             'NumberTitle', 'off',...
             'CloseRequestFcn', @closeFigure); % 设置关闭回调函数
%% 实时显示循环
disp('开始实时显示（按Ctrl+C或关闭窗口停止）...');
try
    while ishandle(hFig) % 当窗口存在时持续运行
        % 获取当前帧
        frame = getsnapshot(vid);

        % 显示
        imshowpair(frame, frame, 'montage');
        % 控制显示刷新
        drawnow
    end
catch
    disp('程序被用户中断');
end

%% 清理资源
stop(vid);
delete(vid);
clear vid;
disp('摄像头资源已释放');

%% 窗口关闭回调函数
function closeFigure(~,~)
    closereq; % 关闭窗口
end