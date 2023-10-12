
clear

f500 = get_fund(161017  ,datenum('2003-01-01','yyyy-mm-dd'),datenum('2020-12-21','yyyy-mm-dd'))
f300 = get_fund(100038  ,datenum('2003-01-01','yyyy-mm-dd'),datenum('2020-12-21','yyyy-mm-dd'))
% 100038 富国量化沪深300 
% 161017 富国中证500
% 001548 天弘上证50指数A
% 160213 国泰纳斯达克100
% 002229 华夏经济转型股票
% 110008 易方达稳健收益B
% 162411 华宝标普油气LOF


price 	=	fund.vs / fund.vs(1);	% 价格归一
N		=	length(price);			% 数据长度

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


 



