
[Date,NAV,ANAV,By,Sell,Dvd ] = DataChinaFund('161017'  , '2003-01-01' , '2023-10-11');



figure;
plot(Date, ANAV, 'r');
xlabel('Date');
ylabel('Value');
title('Value vs. Date');

% 优化日期格式显示
datetick('x', 'yyyy-mm-dd');
grid on;
grid minor;