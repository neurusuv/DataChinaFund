l;\];kpojmopjmop\jjjopkok
date = data.F510300(:,1);

price = data.F510300(:,2);
 

N=length(date);








change = [0;diff(price)];

changeM100 = movmean(change,100);

findPos = find(changeM100>0);


plot(date,price/2-1,'k-');    hold on
plot(date,price/2-1,'g*');    hold on;
plot(date,change,'.');    hold on;
plot(date,changeM100,'k*-'); hold on;
plot(date(findPos),changeM100(findPos),'r*'); hold on;
plot(date(findPos),price(findPos)/2-1,'r*');    hold on;

mean(change)
mean(change(findPos))
datetick('x', 'yyyy','keeplimits');
grid on;
grid minor;
hold off;
 
 