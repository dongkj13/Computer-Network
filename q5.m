clear;clc;close all;
load('data.mat');
flagname = ['URG'; 'ACK'; 'PSH'; 'RST'; 'SYN'; 'FIN'];
t=zeros(1,6);
tr=t;
ts=t;
for ii=1:1:receive_count
    if (receive_datagram(ii).protocol==6)
        t=t+receive_datagram(ii).flag;
    end
end
tr=t;
for ii=1:1:send_count
    if (send_datagram(ii).protocol==6)
        t=t+send_datagram(ii).flag;
    end
end
ts=t-tr;
fprintf('收发双方向\n')
for ii=1:1:6
    fprintf(flagname(ii,:));
    fprintf('： %f5%% \n', t(ii)/sum(t)*100);
end
fprintf('收方向\n')
for ii=1:1:6
    fprintf(flagname(ii,:));
    fprintf('： %f5%% \n', tr(ii)/sum(tr)*100);
end
fprintf('发方向\n')
for ii=1:1:6
    fprintf(flagname(ii,:));
    fprintf('： %f5%% \n', ts(ii)/sum(ts)*100);
end