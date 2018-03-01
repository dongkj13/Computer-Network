function [hei a b g] = q4_check(heihei,c,d,h,e,f)
%Q4_CHECK Summary of this function goes here
%   Detailed explanation goes here
    if (length(find(c==e))==0)
        a=[c e];
        b=[d f];
        g=[h f];
        hei=[heihei 1];
    else
        a=c;
        b=d;
        g=h;
        hei=heihei;
        hei(find(c==e))=heihei(find(c==e))+1;
        b(find(c==e))=b(find(c==e))+f;
        g(find(c==e))=g(find(c==e))+f;
    end
end

