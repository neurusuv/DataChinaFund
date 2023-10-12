
clear

f500 = get_fund(161017  ,datenum('2003-01-01','yyyy-mm-dd'),datenum('2020-12-21','yyyy-mm-dd'))
f300 = get_fund(100038  ,datenum('2003-01-01','yyyy-mm-dd'),datenum('2020-12-21','yyyy-mm-dd'))
% 100038 ������������300 
% 161017 ������֤500
% 001548 �����֤50ָ��A
% 160213 ��̩��˹���100
% 002229 ���ľ���ת�͹�Ʊ
% 110008 �׷����Ƚ�����B
% 162411 ������������LOF


price 	=	fund.vs / fund.vs(1);	% �۸��һ
N		=	length(price);			% ���ݳ���

rate	=	price;




rate(2:N) 	=	price(2:N) ./ price(1:N-1);
rate(1)		=   1; 

Times=3;

rateP = rate * Times - Times + 1;
rateN = 2 - rateP;

 


priceP=	price;
priceN=	price; 




for i=2:N
	priceP (i)	=	priceP (i-1)	* rateP(i);
    priceN (i)	=	priceN (i-1)	* rateN(i); 
    
%      ref=priceP(i)/2+priceN(i)/2;
%      diff = abs(priceP(i) - priceN(i));
%      
%      if ref> (1.8*priceP(i))
%         priceP (i) = ref;
%         priceN (i) = ref;
%         
%      end
    
    
end



plot(fund.ds,priceP , 'b' ); hold on;
plot(fund.ds,priceN , 'g' ); hold on; 
plot(fund.ds,priceN/2+priceP/2 , 'y' ); hold on; 
plot(fund.ds,price  , 'r' ); hold off; 


 



