function a = iir(a,N)
	
	for i=2:length(a)
	
		a(i) = a(i-1)*(1-1/N) + a(i)/N;
	
	end 
	
 
end

