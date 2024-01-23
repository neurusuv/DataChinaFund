
% [Date,NAV,ANAV,Buy,Sell,Dvd ] = DataChinaFund('510300'  , '2000-01-01' , '2024-10-11');


money = zeros(size(ANAV)); %现金
invst = zeros(size(ANAV)); %每轮已经投资的现金
stock = zeros(size(ANAV)); %基金份额
 
 
 
 
 
  EMA12 = movmean(ANAV,	12);
  EMA26 = movmean(ANAV,	26);
  DIF   = EMA12 - EMA26; 
  DEM   = movmean(DIF, 	 9);



 
   EMA12 = iir(ANAV,	13);
   EMA26 = iir(ANAV,	22);
   DIF   = EMA12 - EMA26; 
   DEM   = iir(DIF, 	 28);
 
 




 
MACD =  DIF - DEM; 


 

buyTime = find( (MACD(2:end) > 0) & (MACD(1:end-1) <=0) )+1;
sellTime = find( (MACD(2:end) <0) & (MACD(1:end-1) >=0) )+1;


money=ANAV*0;
share=ANAV*0;
capital=ANAV*0;
money(1)=0;
capital(1)=0;

buyena=ANAV*0;



for i = 2: length(ANAV)

	money(i) = money(i-1);
	share(i) = share(i-1);
	capital(i) = share(i)*ANAV(i) + money(i);
	buyena(i) = buyena(i-1);
	
	if sum(find(sellTime==i))==1
		buyena(i) = 1;
	end
	 
	if sum(find(buyTime==i))==1
		buyena(i) = 0; 
		i
	end 
	
	
	if buyena(i)==1
		share(i) = share(i) + 1/ANAV(i) ;
		money(i) = money(i) - 1;
	 
	 
	end 
 
	% disp([i, (capital(1:5)) ; ...
	 % i, (share(1:5)) ; ...
	 % i, (money(1:5)) ]) ;
end 
  
ax1 =subplot(2,1,1);  


plot(Date, ANAV , 'k.-'); hold on; 
plot(Date(buyTime), ANAV(buyTime) , 'm*'); hold on; 
plot(Date(sellTime), ANAV(sellTime) , 'mo'); hold on; 
plot(Date, capital , 'm'); hold on; 
plot(Date, money , 'm.'); hold on; 

plot(Date, EMA12 , 'b'); hold on; 

plot(Date, EMA26 , 'r'); hold on; 
 
 
 
datetick('x', 'yyyy','keeplimits');
grid on;
grid minor;
hold off;


ax2 =subplot(2,1,2);  
plot(Date, DEM , 'r'); hold on;   
plot(Date, DIF , 'b'); hold on;  

MACD = MACD  ;

bar(Date(MACD>0), MACD(MACD>0),'r');
bar(Date(MACD<0), MACD(MACD<0),'b');

datetick('x', 'yyyy','keeplimits');
grid on;
grid minor;
hold off;

linkaxes([ax1, ax2], 'x'); 