function result= get_fund(fundcode,StartDate,EndDate)
    
    dateFormate='yyyy-mm-dd';
    file_url= [ 'http://data.funds.hexun.com/outxml/detail/openfundnetvalue.aspx?fundcode=', ...
                    num2str(fundcode, '%06u\n'), ...
                    '&startdate=',   ...
                    datestr(StartDate,dateFormate), ...
                    '&enddate=',    ...
                    datestr(EndDate,dateFormate)];
                
    file_name=[num2str(fundcode, '%06u\n'),'_',datestr(StartDate,dateFormate),'_',datestr(EndDate,dateFormate) ,'.xml'];
                
    websave(fullfile(pwd,'data',file_name),file_url);
    
    
    xml_data=dir(fullfile(pwd,'data',file_name));
    
    
    
    if (xml_data.bytes < 10) 
        result.ds=[];
        result.vs=[];
        result.FundCode= fundcode;
        result.FundName= '';
        result.length=0;
        
  
    else


        xDoc=xmlread(fullfile(pwd,'data',file_name));
        d_cells=xDoc.getElementsByTagName('fld_enddate');
        v_cells=xDoc.getElementsByTagName('fld_netvalue');
        fc=xDoc.getElementsByTagName('fundcode');
        fn=xDoc.getElementsByTagName('fundname');

        cell_length=min(d_cells.getLength,v_cells.getLength);

        DL=zeros(d_cells.getLength,1);
        VL=zeros(v_cells.getLength,1);

        for i=0:(cell_length-1)
            DL(i+1)  = datenum(char(d_cells.item(i).getFirstChild.getData),'yyyy-mm-dd');  
            VL(i+1)  = str2num(v_cells.item(i).getFirstChild.getData);
        end

        d_cells=xDoc.getElementsByTagName('fld_enddate');

        result.ds=flipud(DL);
        result.vs=flipud(VL);
        result.FundCode= str2num(fc.item(0).getFirstChild.getData);
        result.FundName=    char(fn.item(0).getFirstChild.getData);
        
        result.length=cell_length;
        
        
      
    
    end

end

