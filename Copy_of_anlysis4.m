
%DataChinaFundCached('001588'  , '2000-01-01' , '2024-10-11');
load('dataCache.mat');

%     F510300: [2856×2 double]
%     F510500: [2658×2 double]
%     F290010: [3077×2 double]  泰信中证200指数(290010.OF) 
%     F001588: [2084×2 double]  天弘中证800A 
%     F270042: [2755×2 double]  广发纳指100ETF联接人民币 



selData = data.F290010;




date = selData(:,1);

price = selData(:,2);


share = price*0;
invst = price*0;
money = price*0;

capital= money + share .*  price;
 

N=length(date);

% 做价格涨跌

dp    = price*0;
ddp  = price*0;
mdp   = price*0;

money(1)=1;

for i=2:N
	dp(i)=price(i)/price(i-1)-1;
	in=i-50;
	if (in<1) in=1; end
	 
	
	mdp(i)= mdp(i-1) + ( dp(i) * abs(dp(i))   -  mdp(i-1))/50;
	 
	share(i)=share(i-1);
	money(i)=money(i-1);
	
	
	capital(i)= money (i)+ share(i)*  price(i);
	
	if (i>100)
		if (mdp(i-1)>0 )
			if (money(i-1)>0)  
			 

				share(i)=4*money(i-1)/price(i);
				money(i)=0-3*money(i-1); 

			end
		else
			 
			share(i)=0;
			money(i)=money(i)+share(i-1) *price(i); 
        end
			
        
        
	end

end

 


capital= money + share .*  price;




subplot(2,1,1);
plot(date, price, 'k.-'); hold on; 
plot(date,mdp*10000/4+1, 'b.-'); hold on; 
plot(date(mdp>0), price(mdp>0), 'r*'); hold on; 
xlabel('Date');ylabel('资产/现金');
title('基金走势');
datetick('x', 'yyyy','keeplimits');
grid on;
grid minor;
hold off;



subplot(2,1,2);
% plot(date, price/mean(price), 'g.-'); hold on; 
% plot(date, money/mean(capital), 'r.-'); hold on; 
% plot(date, capital/mean(capital), 'k.-'); hold on;
plot(date, price/price(1), 'g.-'); hold on; 
plot(date, money/capital(1), 'r.-'); hold on; 
plot(date, capital/capital(1), 'k.-'); hold on;
xlabel('Date');
ylabel('ANAV');
title('个人总资产(黑色)和现金(红色)变化');
datetick('x', 'yyyy','keeplimits');
grid on;
grid minor;
hold off;
 
 %% 日平均资产增长率
 

daily=mean(capital(2:end)./ capital(1:end-1));

realdailyly = daily^( N / (date(end)-date(1)) ) ;

yearly1_capital = realdailyly^365




daily=mean(capital(2002:end)./ capital(2001:end-1));

realdailyly = daily^( 855 / (date(end)-date(2001)) ) ;

yearly1_capital = realdailyly^365










daily=mean(price(2:end)./ price(1:end-1));

realdailyly = daily^( N / (date(end)-date(1)) ) ;

yearly_price = realdailyly^365

