clear all; close all; clc;

load data.mat
label = cell(256,1);
for i = 1:256 
    label{i} = {};
end
% ����IPЭ����
label{1+1} = 'ICMP';
label{2+1} = 'IGMP';
label{6+1} = 'TCP';
label{17+1} = 'UDP';
label{41+1} = 'IPv6';

% ��һ��Ϊ��������ͳ�ƣ��ڶ���Ϊ����������ͳ��
send_protocol = zeros(256, 2);
send_fragmentedDG = 0;
send_fragmentedTCP = 0;
send_fragmentedUDP = 0;
for i = 1 : send_count
	protocol = send_datagram(i).protocol;
	send_protocol(protocol + 1, 1) = send_protocol(protocol + 1, 1) + 1;
	send_protocol(protocol + 1, 2) = send_protocol(protocol + 1, 2) + send_datagram(i).length;
	if send_datagram(i).fragmented
		send_fragmentedDG = send_fragmentedDG + 1;
		if protocol == 6
			send_fragmentedTCP = send_fragmentedTCP + 1;
		end
		if protocol == 17
			send_fragmentedUDP = send_fragmentedUDP + 1;
		end
	end
end

figure;
subplot 121;
pie(send_protocol(:,1),label);
title('���ͷ����غ�Э�����');
subplot 122;
pie(send_protocol(:,2),label);
title('�������������غ�Э�����');

fprintf('���ͷ����Ϸֶεķ������� %d \n', send_fragment);
fprintf('���ͷ����ϱ���Ƭ�����ݱ������� %d \n', send_fragmentedDG);
fprintf('���ͷ�����TCP�غɵ����ݱ��б���Ƭ�ı����� %f \n', send_fragmentedTCP / send_protocol(7,1));
fprintf('���ͷ�����UDP�غɵ����ݱ��б���Ƭ�ı����� %f \n', send_fragmentedUDP / send_protocol(18,1));

% ��һ��Ϊ��������ͳ�ƣ��ڶ���Ϊ����������ͳ��
receive_protocol = zeros(256, 2);
receive_fragmentedDG = 0;
receive_fragmentedTCP = 0;
receive_fragmentedUDP = 0;
for i = 1 : receive_count
	protocol = receive_datagram(i).protocol;
	receive_protocol(protocol + 1, 1) = receive_protocol(protocol + 1, 1) + 1;
	receive_protocol(protocol + 1, 2) = receive_protocol(protocol + 1, 2) + receive_datagram(i).length;
	if receive_datagram(i).fragmented
		receive_fragmentedDG = receive_fragmentedDG + 1;
		if protocol == 6
			receive_fragmentedTCP = receive_fragmentedTCP + 1;
		end
		if protocol == 17
			receive_fragmentedUDP = receive_fragmentedUDP + 1;
		end
	end
end

figure;
subplot 121;
pie(receive_protocol(:,1),label);
title('���շ����غ�Э�����');
subplot 122;
pie(receive_protocol(:,2),label);
title('�������������غ�Э�����');

fprintf('���շ����Ϸֶεķ������� %d \n', receive_fragment);
fprintf('���շ����ϱ���Ƭ�����ݱ������� %d \n', receive_fragmentedDG);
fprintf('���շ�����TCP�غɵ����ݱ��б���Ƭ�ı����� %f \n', receive_fragmentedTCP / receive_protocol(7,1));
fprintf('���շ�����UDP�غɵ����ݱ��б���Ƭ�ı����� %f \n', receive_fragmentedUDP / receive_protocol(18,1));

s = send_protocol([2,7,18,42],:);
r = receive_protocol([2,7,18,42],:);
	