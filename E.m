function E = E(t,x)
	% 
	% 
	% 		Energy of Pendubot
	% 
	% author:	Rahul Moghe
	% date:		Dec 2, 2016

	q1 = x(1); dq1 = x(2); q2 = x(3); dq2 = x(4);

	g=x(5); m1=x(6); m2=x(7); l1=x(8); l2=x(9);
	lc1=x(10); lc2=x(11); I1=x(12); I2=x(13);

	E = 0.5*I1*dq1*dq1 + 0.5*I2*dq2*dq2 + 0.5*m2*l1*l1*dq1*dq1+...
		m2*l1*lc2*cos(q2-q1)*dq1*dq2-m1*g*lc1*cos(q1)-...
		m2*g*(l1*cos(q1) + lc2*cos(q2));