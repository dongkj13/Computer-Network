clear;clc;close all;
load('data.mat');
udplength=zeros(1,receive_count+send_count);
tcplength=udplength;
sumlength=udplength;
sumlength=tcplength;
numu=1;numt=1;nums=1;
for ii=1:1:receive_count
    %numt=numt+1;numu=numu+1;
    %udplength(numu)=udplength(numu-1);
    %tcplength(numt)=tcplength(numt-1);
    if (receive_datagram(ii).protocol==6)
        numt=numt+1;        
        tcplength(numt)=tcplength(numt-1)+receive_datagram(ii).length;
    elseif (receive_datagram(ii).protocol==17)
        numu=numu+1;
        udplength(numu)=udplength(numu-1)+receive_datagram(ii).length;
    end
    nums=nums+1;
    sumlength(nums)=sumlength(nums-1)+receive_datagram(ii).length;
end
numsr=nums;numtr=numt;numur=numu;
for ii=1:1:send_count
    %numt=numt+1;numu=numu+1;    
    %udplength(numu)=udplength(numu-1);
    %tcplength(numt)=tcplength(numt-1);
    if (send_datagram(ii).protocol==6)
        numt=numt+1;
        tcplength(numt)=tcplength(numt-1)+send_datagram(ii).length;
    elseif (send_datagram(ii).protocol==17)
        numu=numu+1;
        udplength(numu)=udplength(numu-1)+send_datagram(ii).length;
    end
    nums=nums+1;
    sumlength(nums)=sumlength(nums-1)+send_datagram(ii).length;
end
figure;
%subplot(1,3,1);plot(sumlength);
%title('双方向IP数据报长度');
subplot(1,2,1);plot(sumlength(1:receive_count+1));
title('收方向IP数据报长度');
subplot(1,2,2);plot(sumlength(receive_count+1:length(sumlength))-sumlength(receive_count+1));
title('发方向IP数据报长度');
figure;
%subplot(2,2,1);plot(udplength(1:numu));
%title('双方向udp数据报长度');
%subplot(2,2,2);plot(tcplength(1:numt));
%title('双方向tcp数据报长度');
subplot(2,2,1);plot(udplength(1:numur));
title('收方向udp数据报长度');
subplot(2,2,2);plot(tcplength(1:numtr));
title('收方向tcp数据报长度')
subplot(2,2,3);plot(udplength(numur:numu)-udplength(numur));
title('发方向udp数据报长度');
subplot(2,2,4);plot(tcplength(numtr:numt)-tcplength(numtr));
title('发方向tcp数据报长度')
