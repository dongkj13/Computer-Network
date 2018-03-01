clear all; close all; clc;

localIP = uint8([101 5 239 240]);	% ���ص�IP��ַ
send_fragment = 0;	% ���ͷ����Ϸֶεķ�����
send_datagram = struct('protocol',0,'length',0,'fragmented',false,'srcPort',0,'dstPort',0,'flag',zeros(1,6));
send_count = 0;

receive_fragment = 0;	% ���շ����Ϸֶεķ�����
receive_datagram = struct('protocol',0,'length',0,'fragmented',false,'srcPort',0,'dstPort',0,'flag',zeros(1,6));
receive_count = 0;
%59, 66, 143, 91
fid = fopen('traffic.101.5.239.240.pac');

%fid = fopen('traffic_wifi_5min.pac');
data = fread(fid,'uint8');
length = size(data, 1);

n = 24;		% ����24���ֽڵ�windump��ʽ�ļ�ͷ
while n < length
	% ���ζ�ȡÿһ֡
	frameLength = data(n + 9 : n + 12)' * power(256, 0:3)';	% ÿ֡�ĳ���
    n = n + 16;	% ����ÿ֡16���ֽڵ�Packetͷ
	frame = data(n + 1 : n + double(frameLength))';	% ȡ��ÿһ֡IP���ݱ���
	% ������·���ͷ
	% ������IPv4Э�飬������
	if ~(all(frame(13 : 14) == [8 0]))
		n = n + frameLength;
		continue;
	end
	% ������ͷ
	IPheader = frame(15 : 15 + 20 - 1);
	version = floor(IPheader(1) / 16);
	IHL = mod(IPheader(1), 16);
	totalLength = IPheader(3:4) * power(256, 1:-1:0)';
	identification = IPheader(5:6) * power(256, 1:-1:0)';
	DF = bitand(IPheader(7), 64) == 64;
	MF = bitand(IPheader(7), 32) == 32;
	fragmentOffset = bitand(IPheader(7:8) * power(256, 1:-1:0)', 2^14 - 1) ;
	TTL = IPheader(9);
	protocol = IPheader(10);
	source = IPheader(13:16);
	destination = IPheader(17:20);
    % ������ͷ
    srcPort = 0; dstPort = 0;
    if protocol == 17 || protocol == 6
        TransportHeader = frame(35 : size(frame,2));
        srcPort = TransportHeader(1:2) * power(256, 1:-1:0)';
        dstPort = TransportHeader(3:4) * power(256, 1:-1:0)';
        if protocol == 6 	% TCPЭ��
            URG = bitand(TransportHeader(14), 32) == 32;
            ACK = bitand(TransportHeader(14), 16) == 16;
            PSH = bitand(TransportHeader(14), 8) == 8;
            RST = bitand(TransportHeader(14), 4) == 4;
            SYN = bitand(TransportHeader(14), 2) == 2;
            FIN = bitand(TransportHeader(14), 1) == 1;
            flag = [URG, ACK, PSH, RST, SYN, FIN];
        else % protocol == 17  UDPЭ��
            flag = zeros(1, 6);
        end
    end

	if ~MF		% Ϊδ��Ƭ�����ݱ����Ƭ���ݱ������һ��
		if all(source == localIP)
			send_count = send_count + 1;
			i = send_count;
			send_datagram(i).id = identification;
			send_datagram(i).protocol = protocol;
			send_datagram(i).length = totalLength - IHL * 4;	% ȥ��IP����ͷ
			if fragmentOffset == 0
				send_datagram(i).fragmented = false;
			else
				send_fragment = send_fragment + 1;
				send_datagram(i).fragmented = true;
			end
			send_datagram(i).srcPort = srcPort;
			send_datagram(i).dstPort = dstPort;
			send_datagram(i).flag = flag;
		end
		if all(destination == localIP)
			receive_count = receive_count + 1;
			i = receive_count;
			receive_datagram(i).id = identification;
			receive_datagram(i).protocol = protocol;
			receive_datagram(i).length = totalLength - IHL * 4;
			if fragmentOffset == 0
				receive_datagram(i).fragmented = false;
			else
				receive_fragment = receive_fragment + 1;
				receive_datagram(i).fragmented = true;
			end
			receive_datagram(i).srcPort = srcPort;
			receive_datagram(i).dstPort = dstPort;
			receive_datagram(i).flag = flag;
		end
	else
		if all(source == localIP)
			send_fragment = send_fragment + 1;
		else
			receive_fragment = receive_fragment + 1;
		end
	end
	n = n + frameLength;
end

save ('data.mat', 'receive_fragment', 'receive_count', 'receive_datagram', 'send_fragment', 'send_count', 'send_datagram');

