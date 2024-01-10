
% [Date,NAV,ANAV,Buy,Sell,Dvd ] = DataChinaFund('510300'  , '2000-01-01' , '2024-10-11');


money = zeros(size(ANAV)); %现金
invst = zeros(size(ANAV)); %每轮已经投资的现金
stock = zeros(size(ANAV)); %基金份额
 
 
 
EMA12 = movmean(ANAV,	12);
EMA26 = movmean(ANAV,	26);
DIF   = EMA12 - EMA26; 
DEM   = movmean(DIF, 	 9);
 
MACD =  DIF - DEM; 
  
ax1 =subplot(2,1,1);  


plot(Date, ANAV , 'k'); hold on; 
plot(Date, EMA12 , 'b'); hold on; 

plot(Date, EMA26 , 'r'); hold on; 
 
datetick('x', 'yyyy','keeplimits');
grid on;
grid minor;
hold off;


ax2 =subplot(2,1,2);  
plot(Date, DEM , 'r'); hold on;   
plot(Date, DIF , 'b'); hold on;  

bar(Date(MACD>0), MACD(MACD>0),'r');
bar(Date(MACD<0), MACD(MACD<0),'b');

datetick('x', 'yyyy','keeplimits');
grid on;
grid minor;
hold off;

 linkaxes([ax1, ax2], 'x'); 