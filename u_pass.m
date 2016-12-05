function u = u_pass(t,x)
	% 
	% 
	% 		Energy Based Control of Pendubot
	% 
	% Ref: Energy Based Control of the Pendubot, Fantoni, Lozano, Spong
	% 		,IEEE Transactions on Automatic Control 2000
	% author:	Rahul Moghe
	% date:		Nov 23, 2016

	global 		xG	EG
	global 		k

	q1 = x(1); dq1 = x(2); q2 = x(3); dq2 = x(4);

	g=x(5); m1=x(6); m2=x(7); l1=x(8); l2=x(9);
	lc1=x(10); lc2=x(11); I1=x(12); I2=x(13);

	if abs(pi-mod(q1,2*pi))<0.8 && abs(pi-mod(q2,2*pi))<0.8
		ss = k.kp1*(pi-mod(q1,2*pi)) + k.kd1*(-dq1);
		es = k.kp2*(pi-mod(q2,2*pi)) + k.kd2*(-dq2);
		u = (k.l*es + (1-k.l)*ss);
		fprintf('t = %f\tq1 = %f\tq2 = %f\tu = %f\n',t,q1,q2,u);
		display('linear control...')
		return
	end

	%  Inertia Matrix D(q)
	D = [ I1 + m2*l1*l1 		,	m2*l1*lc2*cos(q2-q1);...
		  m2*l1*lc2*cos(q2-q1)	,	I2					];

	%  Inverse of the inertia matrix
	Dinv = D\eye(2);

	% Coriolis Term C(q,dq)
	C = [	0.002					,	-m2*l1*lc2*sin(q2-q1)*dq2;...
			m2*l1*lc2*sin(q2-q1)*dq1,	0.002					];

	% Gravitational Term G(q)
	G = [g*sin(q1)*(m1*lc1 + m2*l1) ;...
		 g*sin(q2)*m2*lc2			];

	fbl = Dinv*(G+C*[dq1;dq2]);

	% fprintf('Denominator of u = %f\n',k.ke*(E(t,x)-EG)+k.kd*Dinv(1,1));

	u = (-dq1+k.kd*fbl(1)-k.kp*(q1-xG(1)))/(k.ke*(E(t,x)-EG)+k.kd*Dinv(1,1));
end