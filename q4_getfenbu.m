function [f] = q4_getfenbu(port,rs,srcdst,udptcp,hei)
%Q4_GETFENBU Summary of this function goes here
%   Detailed explanation goes here
load('data.mat');
f=zeros(1,hei+1);
heihei=2;
if (rs==1)
for ii=1:1:receive_count
    if ((receive_datagram(ii).dstPort==port&&srcdst==2)...
            ||(srcdst==1&&receive_datagram(ii).srcPort==port))
        if receive_datagram(ii).protocol==udptcp
            f(heihei)=f(heihei-1)+receive_datagram(ii).length;
            heihei=heihei+1;
        end
    end
end
else
for ii=1:1:send_count
    if ((send_datagram(ii).dstPort==port&&srcdst==2)...
            ||(srcdst==1&&send_datagram(ii).srcPort==port))
        if send_datagram(ii).protocol==udptcp
            f(heihei)=f(heihei-1)+send_datagram(ii).length;
            heihei=heihei+1;
        end
    end
end
end
end

