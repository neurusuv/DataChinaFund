function data= DataChinaFundCashed(fundcode,StartDate,EndDate)
	
	data=[];
	
	if isfile('dataCache.mat')
		load('dataCache.mat');
	end
	
	fundMem=['F',fundcode];
	
	if isfield(data, fundMem) % 结构体中包含成员 
		newStartDate = datenum(StartDate,'yyyy-mm-dd') ;
		newEndDate   = datenum(EndDate  ,'yyyy-mm-dd') ;
		
		oldStartDate =  min(data.(fundMem)(:,1)) ;
		oldEndDate   =	max(data.(fundMem)(:,1)) ;
		
		 
		
		if newStartDate < oldStartDate
			[Date,NAV,ANAV,Buy,Sell,Dvd ]= DataChinaFund(fundcode,StartDate,datestr(oldStartDate-1,'yyyy-mm-dd')    );
			tmp=[Date',ANAV'];
			
			data.(fundMem) = [   tmp   ; data.(fundMem) ];
		end
	
		if newEndDate > oldEndDate
			
			[Date,NAV,ANAV,Buy,Sell,Dvd ]= DataChinaFund(fundcode,datestr(oldEndDate+1,'yyyy-mm-dd'), EndDate   );
			tmp=[Date',ANAV'];
			data.(fundMem) = [ data.(fundMem);tmp ];
		end
	else					  % 结构体中不包含成员
		[Date,NAV,ANAV,Buy,Sell,Dvd ]= DataChinaFund(fundcode,StartDate,EndDate)
		
		data.(fundMem)=[Date',ANAV']
		 
	end
	
	 
	save('dataCache.mat', 'data'); 
	
end

