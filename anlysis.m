clear
%DataChinaFundCached('510300'  , '2000-01-01' , '2024-10-11');
load('dataCache.mat');

date = data.F510300(:,1);

price = data.F510300(:,2);
share = price*0;
invst = price*0;
money = price*0;


N=length(date);


ma100 =movmean(price,100);

dtma100 = 1./movmean(1./price,100);


for i=101:N
    share(i) = share(i-1);
	invst(i) = invst(i-1);
	money(i) = money(i-1);
	
	%% 是否开始
	if (invst(i)<=0) 
		if (ma100(i)*0.99) > price(i) 
			share(i) = share(i) + 10/price(i);
			invst(i) = 10;
			money(i) = money(i)  - 10;
		end	
	end
	
	
	
	%% 是否定投
	if (invst(i)>0) 
		gainRate = ( share(i)*price(i) - invst(i) ) /   invst(i);
		if gainRate<(-0.00) %% 增量定投 
			newInvst = 1;%abs( share(i)*price(i) - invst(i) ) 
			share(i) = share(i) + newInvst/price(i);
			invst(i) = invst(i) + newInvst;
			money(i) = money(i) - newInvst;
		end		
		
		WIN = 0.55;
		
		if gainRate>(WIN) %% 止盈
		
			if ( share(i)*price(i) - invst(i) )>1
				% money(i) = money(i) + 0.2*share(i)*price(i);
				% share(i) = share(i) * 0.8;
				% invst(i) = invst(i) * 0.8;
				money(i) = money(i) + WIN*share(i)*price(i);
				share(i) = share(i) * (1-WIN);
				invst(i) = invst(i) * 1;
			else
				money(i) = money(i) + share(i)*price(i);
				share(i) = 0;
				invst(i) = 0;
			end
		end		
		
	
		
		
	end 
	

     
end 
 
  

%% 总资产统计

capital= money + share .*  price;




subplot(2,1,1);
plot(date, price, 'r.-'); hold on; 
plot(date, ma100, 'k.-'); hold on; 
xlabel('Date');ylabel('资产/现金');
title('基金走势');
datetick('x', 'yyyy','keeplimits');
grid on;
grid minor;
hold off;



subplot(2,1,2);
plot(date, price*30-30, 'g.-'); hold on; 
plot(date, money, 'r.-'); hold on; 
plot(date, capital, 'k.-'); hold on;
xlabel('Date');
ylabel('ANAV');
title('个人总资产(黑色)和现金(红色)变化');
datetick('x', 'yyyy','keeplimits');
grid on;
grid minor;
hold off;
 