function[navdata]=readnavfile
% 读取导航[navdata]=readnavfile文件
navfilepath = '.\cuta1680.16p';
fid      = fopen(navfilepath);%打开导航文件‘1680.14p'
navnum = 0; %导航文件中的卫星总个数
navdata = NaN; %导航文件读取的数据为空
% 跳过头文件
while ~feof(fid)                                                           %feof若未结束返回0值
    line = fgetl(fid);
    if strcmp(line(61:73),'END OF HEADER'),break;end %% 跳过文件头
end
% 逐行读取正文内容
while ~feof(fid) %判断是否读到文件尾时
    line = fgetl(fid);
    if line(1) == 'C' %判断是否是卫星的初始行
         navnum = navnum+1;
% 读取卫星数据第一行
         dataline = sscanf(line(2:end),'%e'); %将第一行按照字符串读取
         navdata.gps(navnum).prn = dataline(1); %读取卫星序号
         utctime = dataline(2:7); %读取公历时间
         gpst = cal2gps(utctime); %将公历GPS时间转换到GPS周和周内的秒
         gpst(2)=gpst(2)-14;   %北斗时
         navdata.gps(navnum).bdst=gpst;
         navdata.gps(navnum).gpst = (gpst(1)*604800+gpst(2)); %卫星发射信号时间转换的UTC时间 (发射时间)
         navdata.gps(navnum).af0 = dataline(8); %偏差svClkBias=af0
         navdata.gps(navnum).af1 = dataline(9); %漂移svClkDrf=af1
         navdata.gps(navnum).af2 = dataline(10); %漂移速度svDrfRate=af2
 % 读取卫星数据第二行
         line = fgetl(fid);
         dataline = sscanf(line,'%e'); %将该行按照字符串读取
         navdata.gps(navnum).idoe = dataline(1); %数据、星历发布时间
         navdata.gps(navnum).Crs = dataline(2); %Crs
         navdata.gps(navnum).deltn =dataline(3); %deltn
         navdata.gps(navnum).Mo = dataline(4);%Mo
% 读取卫星数据第三行
         line = fgetl(fid);
         dataline = sscanf(line,'%e'); %将该行按照字符串读取
         navdata.gps(navnum).Cuc = dataline(1); %Cuc
         navdata.gps(navnum).es = dataline(2); %es
         navdata.gps(navnum).Cus =dataline(3); %Cus
         navdata.gps(navnum).sqrtas = dataline(4); %sqrtas
% 读取卫星数据第四行
         line = fgetl(fid);
         dataline = sscanf(line,'%e'); %将该行按照字符串读取
         navdata.gps(navnum).toe = dataline(1); %星历参考时间toe
         navdata.gps(navnum).Cic = dataline(2); %Cic
         navdata.gps(navnum).OMGAo =dataline(3); %OMGAo
         navdata.gps(navnum).Cis = dataline(4); %Cis
% 读取卫星数据第五行
         line = fgetl(fid);
         dataline = sscanf(line,'%e'); %将该行按照字符串读取
         navdata.gps(navnum).io = dataline(1); %io
         navdata.gps(navnum).Crc = dataline(2); %Crc
         navdata.gps(navnum).w =dataline(3); %w
         navdata.gps(navnum).dtOMGA = dataline(4); %dtOMGA
% 读取卫星数据第六行
         line = fgetl(fid);
         dataline = sscanf(line,'%e'); %将该行按照字符串读取
         navdata.gps(navnum).dti = dataline(1); %dti
         navdata.gps(navnum).L2 = dataline(2); %L2上的码
         navdata.gps(navnum).GPSWeek =dataline(3); %GPS周数
         navdata.gps(navnum).L2P = dataline(4); %L2P数据标志
% 读取卫星数据第七行 
         line = fgetl(fid);
         dataline = sscanf(line,'%e');
         navdata.gps(navnum).SVaccuracy = dataline(1);%卫星精度
         navdata.gps(navnum).SVhealth= dataline(2);%卫星健康状态
         navdata.gps(navnum).TGD = dataline(3); %TGD
         navdata.gps(navnum).IODC= dataline(4);%IODC钟的数据龄期
% 读取卫星数据第八行
         line = fgetl(fid);
         dataline = sscanf(line,'%e');
         navdata.gps(navnum).Ttime = dataline(1);%电文发送时间
         if(navdata.gps(navnum).SVhealth==1)
            navnum=navnum-1;
        end
    end
end
fclose(fid); 
end