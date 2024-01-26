
%DataChinaFundCached('290010'  , '2000-01-01' , '2024-10-11');
load('dataCache.mat');




 




date = data.F510300(:,1);

price = data.F510300(:,2);


share = price*0;
invst = price*0;
money = price*0;

capital= money + share .*  price;
 

N=length(date);

% 做价格涨跌

dp    = price*0;
ddp  = price*0;
mdp   = price*0;

money(1)=4;

for i=2:N
	dp(i)=price(i)-price(i-1);
	in=i-150;
	if (in<1) in=1; end
	 
	
	mdp(i)= mean (dp(in:i).*abs(dp(in:i)));
	%mdp(i)= mean (dp(in:i) );
	
	share(i)=share(i-1);
	money(i)=money(i-1);
	
	
	capital(i)= money (i)+ share(i)*  price(i);
	
	if (i>100)
		if (mdp(i-1)>0 )
			if (dp(i-1)>mdp(i-1))  
				t=abs(capital(i))/100;
				 
				share(i)=share(i-1) + t/price(i);
				money(i)=money(i)-t; 
			end
		else
			 
			share(i)=0;
			money(i)=money(i)+share(i-1) *price(i); 
		end
			
	end

end

 


capital= money + share .*  price;




subplot(2,1,1);
plot(date, price, 'k.'); hold on; 
plot(date(mdp>0), price(mdp>0), 'r*'); hold on; 
xlabel('Date');ylabel('资产/现金');
title('基金走势');
datetick('x', 'yyyy','keeplimits');
grid on;
grid minor;
hold off;



subplot(2,1,2);
plot(date, price/mean(price), 'g.-'); hold on; 
plot(date, money/mean(capital), 'r.-'); hold on; 
plot(date, capital/mean(capital), 'k.-'); hold on;
xlabel('Date');
ylabel('ANAV');
title('个人总资产(黑色)和现金(红色)变化');
datetick('x', 'yyyy','keeplimits');
grid on;
grid minor;
hold off;
 
 
 minMoney = abs(min(money));
 
 (capital(end)/ minMoney)^(365/(date(end)-date(1)))