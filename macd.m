
% [date,NAV,ANAV,Buy,Sell,Dvd ] = DataChinaFund('510300'  , '2000-01-01' , '2024-10-11');

load('dataCache.mat');





selData = data.F510300;

date = selData(:,1);

price = selData(:,2);

money = zeros(size(price)); %现金
invst = zeros(size(price)); %每轮已经投资的现金
stock = zeros(size(price)); %基金份额
 
 



 
  EMA12 = movmean(price,	12);
  EMA26 = movmean(price,	26);
  DIF   = EMA12 - EMA26; 
  DEM   = movmean(DIF, 	 19);



 
   EMA12 = iir(price,	1);
   EMA26 = iir(price,	50);
   DIF   = EMA12 - EMA26; 
   DEM   = iir(DIF, 	 9);
 
 
 
 

 
MACD =  DIF - DEM; 


 

buyTime = find( (MACD(2:end) > 0) & (MACD(1:end-1) <=0) )+1;
sellTime = find( (MACD(2:end) <0) & (MACD(1:end-1) >=0) )+1;

gain = price*0;
money=price*0;
share=price*0;
capital=price*0;
money(1)=1;
capital(1)=1;
 



for i = 2: length(price)

	money(i) = money(i-1);
	share(i) = share(i-1);
	gain(i) = gain(i-1);
	capital(i) = share(i)*price(i) + money(i) + gain(i);
	 
	if abs(share(i)*price(i))> abs(money(i)*1.25)
		gain(i) = gain(i) + share(i)*price(i)+money(i);
		share(i) = 0;
		money(i) = 0;
	end 
	
	if DIF(i)<0
		share(i) = share(i) + abs(1  )/price(i) ;
		money(i) = money(i) - abs(1  );
	end 
 
	% disp([i, (capital(1:5)) ; ...
	 % i, (share(1:5)) ; ...
	 % i, (money(1:5)) ]) ;
end 
  
ax1 =subplot(3,1,1);  


plot(date, price , 'k.-'); hold on; 
plot(date(buyTime), price(buyTime) , 'm*'); hold on; 
plot(date(sellTime), price(sellTime) , 'mo'); hold on; 
plot(date, EMA12 , 'b'); hold on; 

plot(date, EMA26 , 'r'); hold on; 
 
 
xlabel('收盘价格 和 12红/26蓝 日均价, *-MACD传统买入点 o-MADC传统卖出点')
 
 
 
datetick('x', 'yyyy','keeplimits');
grid on;
grid minor;
hold off;


ax2 =subplot(3,1,2);  
plot(date, DEM , 'r'); hold on;   
plot(date, DIF , 'b'); hold on;  


xlabel('MACD')
 

MACD = MACD  ;

bar(date(MACD>0), MACD(MACD>0),'r');
bar(date(MACD<0), MACD(MACD<0),'b');

datetick('x', 'yyyy','keeplimits');
grid on;
grid minor;
hold off;








ax3 =subplot(3,1,3); 


plot(date, capital , 'r.-'); hold on; 
 plot(date, money+gain , 'b.-'); hold on; 



xlabel('红线总资产, 蓝线现金')

datetick('x', 'yyyy','keeplimits');
grid on;
grid minor;
hold off;



 
linkaxes([ax1, ax2,ax3], 'x'); 


daily=mean(capital(3:end)./ capital(2:end-1));

realdailyly = daily^( N / (date(end)-date(1)) ) ;

yearly1_capital = realdailyly^365




daily=mean(price(2:end)./ price(1:end-1));

realdailyly = daily^( N / (date(end)-date(1)) ) ;

yearly_price = realdailyly^365


