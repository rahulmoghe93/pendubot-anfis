function fis = create_fis()
	% fis = newfis(name,fistype,andMethod,orMethod,impMethod,aggMethod,defuzzMethod)
	
	% Initialize FIS
	fis = newfis('pendubotfis2','sugeno','min','max','min','max','centroid');
	
	% Add input-output names
	fis = addvar(fis,'input'	,'th1'		,[-pi pi]);
	fis = addvar(fis,'input'	,'th2'		,[-2*pi 2*pi]);
	fis = addvar(fis,'input'	,'th1dot'	,[-20 20]);
	fis = addvar(fis,'input'	,'th2dot'	,[-30 30]);
	fis = addvar(fis,'output'	,'u'		,[-4 4]);

	% Membership function names
	thname 	= ['vvn','vn','n','z','p','vp','vvp'];
	nummf		= length(thname);
	for i = 1:4
		r(i,:)		= getfis(fis,'input',i,'range');
	end
	r(5,:)		= getfis(fis,'output',1,'range');

	% Add membership functions
	for i = 1:nummf
		fis = addmf(fis,'input',1,thname(i),'gaussmf',[1.5 ((nummf-i)*r(1,1) + (i-1)*r(1,2))/(nummf-1)]);
		fis = addmf(fis,'input',2,thname(i),'gaussmf',[1.5 ((nummf-i)*r(2,1) + (i-1)*r(2,2))/(nummf-1)]);
		fis = addmf(fis,'input',3,thname(i),'gaussmf',[1.5 ((nummf-i)*r(3,1) + (i-1)*r(3,2))/(nummf-1)]);
		fis = addmf(fis,'input',4,thname(i),'gaussmf',[1.5 ((nummf-i)*r(4,1) + (i-1)*r(4,2))/(nummf-1)]);
		fis = addmf(fis,'output',1,thname(i),'gaussmf',[1.5 ((nummf-i)*r(5,1) + (i-1)*r(5,2))/(nummf-1)]);
	end

	% Rules for the Fuzzy System
	fis = addrule(fis,[]);

	% Save FIS to file
	writefis(fis,getfis(fis,'name'));