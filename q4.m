clear;clc;close all;
load('data.mat');
r_s_t_pname=[];%收到数据包_发送端口_tcp_端口号
r_s_t_pnum=[];
r_s_t_l=[];
r_s_t_hei=[];
r_s_u_pname=[];
r_s_u_pnum=[];
r_s_u_l=[];
r_s_u_hei=[];
r_r_t_pname=[];
r_r_t_pnum=[];
r_r_t_l=[];
r_r_t_hei=[];
r_r_u_pname=[];
r_r_u_pnum=[];
r_r_u_l=[];
r_r_u_hei=[];
s_s_t_pname=[];
s_s_t_pnum=[];
s_s_t_l=[];
s_s_t_hei=[];
s_s_u_pname=[];
s_s_u_pnum=[];
s_s_u_l=[];
s_s_u_hei=[];
s_r_t_pname=[];
s_r_t_pnum=[];
s_r_t_l=[];
s_r_t_hei=[];
s_r_u_pname=[];
s_r_u_pnum=[];
s_r_u_l=[];
s_r_u_hei=[];
for ii=1:1:receive_count
    if (receive_datagram(ii).protocol==6)
        [r_s_t_hei r_s_t_pname r_s_t_pnum r_s_t_l ]=...
            q4_check(r_s_t_hei,r_s_t_pname,r_s_t_pnum,r_s_t_l,...
            receive_datagram(ii).srcPort,receive_datagram(ii).length);
        [r_r_t_hei r_r_t_pname r_r_t_pnum r_r_t_l]=...
            q4_check(r_r_t_hei,r_r_t_pname,r_r_t_pnum,r_r_t_l,...
            receive_datagram(ii).dstPort,receive_datagram(ii).length);
    elseif (receive_datagram(ii).protocol==17)
        [r_s_u_hei r_s_u_pname r_s_u_pnum r_s_u_l]=...
            q4_check(r_s_u_hei,r_s_u_pname,r_s_u_pnum,r_s_u_l,...
            receive_datagram(ii).srcPort,receive_datagram(ii).length);
        [r_r_u_hei r_r_u_pname r_r_u_pnum r_r_u_l]=...
            q4_check(r_r_u_hei,r_r_u_pname,r_r_u_pnum,r_r_u_l,...
            receive_datagram(ii).dstPort,receive_datagram(ii).length);
    end
end
for ii=1:1:send_count
    if (send_datagram(ii).protocol==6)
        [s_s_t_hei s_s_t_pname s_s_t_pnum s_s_t_l]=...
            q4_check(s_s_t_hei,s_s_t_pname,s_s_t_pnum,s_s_t_l,...
            send_datagram(ii).srcPort,send_datagram(ii).length);
        [s_r_t_hei s_r_t_pname s_r_t_pnum s_r_t_l]=...
            q4_check(s_r_t_hei,s_r_t_pname,s_r_t_pnum,s_r_t_l,...
            send_datagram(ii).dstPort,send_datagram(ii).length);
    elseif (send_datagram(ii).protocol==17)
        [s_s_u_hei s_s_u_pname s_s_u_pnum s_s_u_l]=...
            q4_check(s_s_u_hei,s_s_u_pname,s_s_u_pnum,s_s_u_l,...
            send_datagram(ii).srcPort,send_datagram(ii).length);
        [s_r_u_hei s_r_u_pname s_r_u_pnum s_r_u_l]=...
            q4_check(s_r_u_hei,s_r_u_pname,s_r_u_pnum,s_r_u_l,...
            send_datagram(ii).dstPort,send_datagram(ii).length);
    end
end
%rs,srcdst,udptcp)
save q4data; 