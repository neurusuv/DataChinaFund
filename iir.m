%DataChinaFundCached('001588'  , '2000-01-01' , '2024-10-11');
load('dataCache.mat');





selData = data.F510300;




date = selData(:,1);

price = selData(:,2);


share = price*0;
invst = price*0;
money = price*0;

N=length(price);

avg_x=price*0; 
avg_v=price*0;
avg_a=price*0;
new_x=price*0; 
new_v=price*0;
new_a=price*0;


for i=2:N
    new_x(i) = price(i);
    new_v(i) = new_x(i) - new_x(i-1);
    new_a(i) = new_v(i) - new_v(i-1);
    
    KN=10;
    avg_a(i) = avg_a(i-1) + ( new_a(i) - avg_a(i-1) )/KN;
    avg_v(i) = avg_v(i-1) + avg_a(i) + ( new_v(i) - avg_v(i-1) - avg_a(i))/KN;
    avg_x(i) = avg_x(i-1) + avg_v(i) + ( new_x(i) - avg_x(i-1) - avg_v(i))/KN;
 
end 






plot(new_x,'g')
hold on



plot(avg_x)






for i=2:N
    new_x(i) = price(i);
    new_v(i) = new_x(i) - new_x(i-1);
    new_a(i) = new_v(i) - new_v(i-1);
    
    KN=30;
    avg_a(i) = avg_a(i-1) + ( new_a(i) - avg_a(i-1) )/KN;
    avg_v(i) = avg_v(i-1) + avg_a(i) + ( new_v(i) - avg_v(i-1) - avg_a(i))/KN;
    avg_x(i) = avg_x(i-1) + avg_v(i) + ( new_x(i) - avg_x(i-1) - avg_v(i))/KN;
 
end 





plot(avg_x)





hold off