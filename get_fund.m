
 [Date,NAV,ANAV,Buy,Sell,Dvd ] = DataChinaFund('510300'  , '2000-01-01' , '2024-10-11');


money = zeros(size(ANAV)); %现金
invst = zeros(size(ANAV)); %每轮已经投资的现金
stock = zeros(size(ANAV)); %基金份额
 
 
 

%% 初始现金 100 元
money(1) = 0;

%% 定投策略, 每天买1元, 赚到2元且赢率超10%就全部卖出, 假设允许资金可以为负(0利率借钱投资)
ivstUnit = 0.1;

for i=2:length(ANAV);
	
	money(i) = money(i-1);
	if (money(i)<0) 
		money(i)=money(i)*1.0001;
	end
	invst(i) = invst(i-1);
	stock(i) = stock(i-1);
	
	value 	 = stock(i) *  ANAV(i); 	%基金今天总市值
	
	abswin = value - invst(i); 		%盈利绝对金额
	ratwin = abswin / invst(i);
	if (invst(i)>100) && (ratwin>0.1) && (abswin>1)
	 
		
		money(i) = money(i) + value;
		invst(i) = 0;
		stock(i) = 0;
	elseif (ratwin>-0.32) &&  (ratwin<-0.2) % 没赚到 , 就持续定投
			
		
		money(i) = money(i) - ivstUnit*1000;
		invst(i) = invst(i) + ivstUnit*1000;
		stock(i) = stock(i) + ivstUnit*1000 / ANAV(i);
		
	else  % 没赚到 , 就持续定投
			
		
		money(i) = money(i) - ivstUnit;
		invst(i) = invst(i) + ivstUnit;
		stock(i) = stock(i) + ivstUnit / ANAV(i);
		
		
	end
  [abswin ivstUnit]
end

%% 总资产统计

capital= money + stock .*  ANAV;




subplot(2,1,1);
plot(Date, ANAV, 'r'); hold on; 
xlabel('Date');
ylabel('资产/现金');
title('基金走势');
datetick('x', 'yyyy','keeplimits');
grid on;
grid minor;
hold off;



subplot(2,1,2);
plot(Date, money, 'r'); hold on; 
plot(Date, capital, 'k'); hold on;
xlabel('Date');
ylabel('ANAV');
title('个人总资产(黑色)和现金(红色)变化');
datetick('x', 'yyyy','keeplimits');
grid on;
grid minor;
hold off;
 