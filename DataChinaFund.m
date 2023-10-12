function [Date,NAV,ANAV,Buy,Sell,Dvd ]= DataChinaFund(fundcode,StartDate,EndDate)
    page = 1;
	num  = 1;
	numPages =1;
	
	Date = [];   
	NAV	 = [];   
	ANAV = [];    
	Buy  = {};    
	Sell = {};  
	Dvd	 = {}; 
	
	while (page<=numPages) 
	
		webUrl=['https://fundf10.eastmoney.com/F10DataApi.aspx?type=lsjz&code=', ...
				  fundcode				,...
				  '&sdate='				,... 
				  StartDate				,... 
				  '&edate='				,... 
				  EndDate				,...
				  '&per=50&page='		,...
				  num2str(page)			]
		
		
		webContent = webread(webUrl);	
		  
		
		dataPages = webContent(strfind(webContent, 'pages:') + length('pages:')   :  end) ;
		dataPages = strrep(dataPages, 'curpage:' , ''); 
		dataPages = strrep(dataPages, '};' 		 , ''); 
		dataPages = strsplit(dataPages, ',');
		numPages	=  dataPages{1}; numPages = str2num(numPages);  
		
	
	

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
		
		 
		
		for i=1:length(dataLines)
			
			dataCols = dataLines{i}; 
			dataCols = strsplit(dataCols, '<d>'); 
           
            
			newDate  = dataCols{1};	newDate = datenum(newDate,'yyyy-mm-dd') ;
			newNAV	 = dataCols{2};	newNAV	= str2num(newNAV);
			newANAV  = dataCols{3}; newANAV = str2num(newANAV);
			newBuy   = dataCols{5};  
			newSell  = dataCols{6};
			newDvd	 = dataCols{7};	
			
			
			
			% dataCols 
			% dataCols 
			% newDate  
			% newNAV	 
			% newANAV  
			% newBuy   
			% newSell  
			% newDvd	 
			
			
			Date(num) = newDate	;   
			NAV(num)  = newNAV	;   
			ANAV(num) = newANAV	;    
			Buy{num}  = newBuy	;    
			Sell{num} = newSell	;  
			Dvd{num}  = newDvd	; 
	
			num = num + 1;
			
		end
		
		
		page = page + 1;
		
    end
	
	
	
	
	
	
	
	 

end

