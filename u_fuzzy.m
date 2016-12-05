function u = u_fuzzy(t,x)
% 
% 		Made by Rahul Moghe, UT Austin
% 		Date: Dec 4, 2016
% 
% 		Implementation of paper listed below
% 		Ref: THEORY AND IMPLEMENTATION OF A FUZZY CONTROL SCHEME FOR PENDUBOT
% 		Authors: Xiao Qing Ma and Chun-Yi Su
% 		IFAC, 2002, Barcelona, Spain
% 
	global 	xG 		kf

	q1 = x(1); dq1 = x(2); q2 = x(3); dq2 = x(4);
	g=x(5); m1=x(6); m2=x(7); l1=x(8); l2=x(9);
		lc1=x(10); lc2=x(11); I1=x(12); I2=x(13);

	if abs(pi-q1)<01 && abs(pi-q2)<01
		ss = kf.kp1*(pi-q1) - kf.kd1*(-dq1);
		es = kf.kp2*(pi-q2) + kf.kd2*(-dq2);
		u = -kf.lam*es + (1-kf.lam)*ss;
		display('linear control...')
		return
	end

	sep = sigmf((pi-q1),[2*kf.k1 0]);
	rsep = sigmf(-dq1,[2*kf.k2 0]);
	sen = sigmf((pi-q1),[-2*kf.k1 0]);
	rsen = sigmf(-dq1,[-2*kf.k2 0]);

	ssp = kf.mus*sep + (1-kf.mus)*rsep;
	ssn = kf.mus*sen + (1-kf.mus)*rsen;
	
	eep = sigmf((pi-q2),[2*kf.k3 0]);
	reep = sigmf(-dq2,[2*kf.k4 0]);
	een = sigmf((pi-q2),[-2*kf.k3 0]);
	reen = sigmf(-dq2,[-2*kf.k4 0]);

	esp = kf.mue*eep + (1-kf.mue)*reep;
	esn = kf.mue*een + (1-kf.mue)*reen;

	osp = kf.l*ssp + (1-kf.l)*esp;
	osn = kf.l*ssn + (1-kf.l)*esn;

	u = kf.G*(osp-osn);