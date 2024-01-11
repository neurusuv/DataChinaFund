
% [Date,NAV,ANAV,Buy,Sell,Dvd ] = DataChinaFund('510300'  , '2000-01-01' , '2024-10-11');


money = zeros(size(ANAV)); %现金
invst = zeros(size(ANAV)); %每轮已经投资的现金
stock = zeros(size(ANAV)); %基金份额
 
 



 
  EMA12 = movmean(ANAV,	12);
  EMA26 = movmean(ANAV,	26);
  DIF   = EMA12 - EMA26; 
  DEM   = movmean(DIF, 	 19);



 
   EMA12 = iir(ANAV,	1);
   EMA26 = iir(ANAV,	50);
   DIF   = EMA12 - EMA26; 
   DEM   = iir(DIF, 	 9);
 
 
 
 

 
MACD =  DIF - DEM; 


 

buyTime = find( (MACD(2:end) > 0) & (MACD(1:end-1) <=0) )+1;
sellTime = find( (MACD(2:end) <0) & (MACD(1:end-1) >=0) )+1;

gain = ANAV*0;
money=ANAV*0;
share=ANAV*0;
capital=ANAV*0;
money(1)=1;
capital(1)=1;
 



for i = 2: length(ANAV)

	money(i) = money(i-1);
	share(i) = share(i-1);
	gain(i) = gain(i-1);
	capital(i) = share(i)*ANAV(i) + money(i) + gain(i);
	 
	if abs(share(i)*ANAV(i))> abs(money(i)*1.25)
		gain(i) = gain(i) + share(i)*ANAV(i)+money(i);
		share(i) = 0;
		money(i) = 0;
	end 
	
	if DIF(i)<0
		share(i) = share(i) + abs(1  )/ANAV(i) ;
		money(i) = money(i) - abs(1  );
	end 
 
	% disp([i, (capital(1:5)) ; ...
	 % i, (share(1:5)) ; ...
	 % i, (money(1:5)) ]) ;
end 
  
ax1 =subplot(3,1,1);  


plot(Date, ANAV , 'k.-'); hold on; 
plot(Date(buyTime), ANAV(buyTime) , 'm*'); hold on; 
plot(Date(sellTime), ANAV(sellTime) , 'mo'); hold on; 
plot(Date, EMA12 , 'b'); hold on; 

plot(Date, EMA26 , 'r'); hold on; 
 
 
xlabel('收盘价格 和 12红/26蓝 日均价, *-MACD传统买入点 o-MADC传统卖出点')
 
 
 
datetick('x', 'yyyy','keeplimits');
grid on;
grid minor;
hold off;


ax2 =subplot(3,1,2);  
plot(Date, DEM , 'r'); hold on;   
plot(Date, DIF , 'b'); hold on;  


xlabel('MACD')
 

MACD = MACD  ;

bar(Date(MACD>0), MACD(MACD>0),'r');
bar(Date(MACD<0), MACD(MACD<0),'b');

datetick('x', 'yyyy','keeplimits');
grid on;
grid minor;
hold off;








ax3 =subplot(3,1,3); 


plot(Date, capital , 'r.-'); hold on; 
 plot(Date, money+gain , 'b.-'); hold on; 



xlabel('红线总资产, 蓝线现金')

datetick('x', 'yyyy','keeplimits');
grid on;
grid minor;
hold off;



 
linkaxes([ax1, ax2,ax3], 'x'); 


