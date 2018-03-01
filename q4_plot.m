function [] = q4_plot(a,b,rs,srcdst,udptcp,ttt,hei)
%Q4_PLOT Summary of this function goes here
%   Detailed explanation goes here
    temp=sort(a,'descend');
    tt=0;
    zhifangtu=zeros(1,65536);
    for ii=1:1:length(a)
        zhifangtu(b(ii))=a(ii);
    end
    bar(zhifangtu);
    %bar(log(a));
    title(char([ttt ' 直方图']));
    %set(gca,'XTickLabel',b);
    saveas(gcf,char(['.\figure\' ttt '直方图' '.jpg']));
    figure;
    for ii=1:1:min(length(temp),10)
        if (ii==5||ii==9) 
            suptitle(ttt);
            saveas(gcf,char(['.\figure\' ttt num2str(ceil(ii/4)-1) '.jpg']));
            figure;tt=tt+4;            
        end
        t=find(a==temp(ii));
        a(t(1))=0;
        fenbu=q4_getfenbu(b(t(1)),rs,srcdst,udptcp,hei(t(1)));
        subplot(2,2,ii-tt);
        plot(fenbu);
        title(char([num2str(ii) 'th port:' num2str(b(t(1)))]));
    end
    suptitle(ttt);
    saveas(gcf,char(['.\figure\' ttt num2str(ceil(ii/4)) '.jpg']));
end

