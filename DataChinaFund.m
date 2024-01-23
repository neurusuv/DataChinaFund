function [Date,NAV,ANAV,Buy,Sell,Dvd ]= DataChinaFund(fundcode,StartDate,EndDate)
	
	Date = [];   % 日期
	NAV	 = [];   % 基金净值
	ANAV = [];   % 累计净值 (分红 合股折算后) 
	Buy  = {};   % 可否买 
	Sell = {};   % 可否卖
	Dvd	 = {};   % 分红信息
	
	
	
    page = 1;
	num  = 1;
	numPages =1;
	
	
	while (page<=numPages) 
	
		webUrl=['https://fundf10.eastmoney.com/F10DataApi.aspx?type=lsjz&code=', ...
				  fundcode				,...
				  '&sdate='				,... 
				  StartDate				,... 
				  '&edate='				,... 
				  EndDate				,...
				  '&per=50&page='		,...
				  num2str(page)			];
		
		
		webContent = webread(webUrl);	
		pause(1.8);  
		
		dataPages = webContent(strfind(webContent, 'pages:') + length('pages:')   :  end) ;
		dataPages = strrep(dataPages, 'curpage:' , ''); 
		dataPages = strrep(dataPages, '};' 		 , ''); 
		dataPages = strsplit(dataPages, ',');
		numPages	=  dataPages{1}; numPages = str2num(numPages);  
		
		
		disp([num2str(page),'/',num2str(numPages)]);
	

		% 找到关键词的位置 
		dataContent =  webContent(strfind(webContent, '<tbody><tr>') + length('<tbody>')   :  strfind(webContent, '</tbody>') - 1);
		
		

		
		dataContent= strrep(dataContent, '<td class=''tor bold''>'		, '<td>');
		dataContent= strrep(dataContent, '<td class=''tor bold red''>'	, '<td>');
		dataContent= strrep(dataContent, '<td class=''tor bold grn''>'	, '<td>');
		dataContent= strrep(dataContent, '<td class=''tor bold bck''>'	, '<td>');
		dataContent= strrep(dataContent, '<td class=''red unbold''>'	, '<td>'); 
		dataContent= strrep(dataContent, '</tr><tr>'					, '<r>');  
		dataContent= strrep(dataContent, '</td><td>'					, '<d>'); 
		dataContent= strrep(dataContent, '<tr>'							, '');  
		dataContent= strrep(dataContent, '</tr>'						, '');  
		dataContent= strrep(dataContent, '<td>'							, ''); 
		dataContent= strrep(dataContent, '</td>'						, ''); 
		dataContent= strrep(dataContent, '<d><d>'						, '<d> <d>');
		
		
		dataLines = strsplit(dataContent, '<r>');
		
		if contains(dataLines, '暂无数据') 
            
		else	 
			for i=1:length(dataLines)
				
				dataCols = dataLines{i}; 
				dataCols = strsplit(dataCols, '<d>'); 
				 
				newDate  = dataCols{1}; 	
				newDate = datenum(newDate,'yyyy-mm-dd') ;
				newNAV	 = dataCols{2};	
				newNAV	= str2num(newNAV);
				newANAV  = dataCols{3}; 
				newANAV = str2num(newANAV);
				newBuy   = dataCols{5};  
				newSell  = dataCols{6};
				newDvd	 = dataCols{7};	
				
				 
				
				
				Date(num) = newDate	;   
				NAV(num)  = newNAV	;   
				ANAV(num) = newANAV	;    
				Buy{num}  = newBuy	;    
				Sell{num} = newSell	;  
				Dvd{num}  = newDvd	; 
		
				num = num + 1;
				
			end
		end	
		
		page = page + 1;
		
    end
	
	
	
	Date  = flip(Date  );   
	NAV   = flip(NAV   );   
	ANAV  = flip(ANAV  );   
	Buy   = flip(Buy   );   
	Sell  = flip(Sell  );   
    Dvd   = flip(Dvd   ); 
end

