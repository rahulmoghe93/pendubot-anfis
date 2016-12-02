function u = u_pass(t,x)
	% 
	% 
	% 		Energy Based Control of Pendubot
	% 
	% Ref: Energy Based Control of the Pendubot, Fantoni, Lozano, Spong
	% 		,IEEE Transactions on Automatic Control 2000
	% author:	Rahul Moghe
	% date:		Nov 23, 2016
	
	global 		xG
	global 		k

	q1 = x(1); dq1 = x(2); q2 = x(3); dq2 = x(4);

	g=x(5); m1=x(6); m2=x(7); l1=x(8); l2=x(9);
	lc1=x(10); lc2=x(11); I1=x(12); I2=x(13);

	t1 = m1*lc1*lc1 + m2*l1*l1 + I1;
	t2 = m2*lc2*lc2 + I2;
	t3 = m2*l1*lc2;
	t4 = m1*lc1 + m2*l1;
	t5 = m2*lc2;

	F = t2*t3*sin(q2)*(dq1+dq2).^2 + t3*t3*cos(q2)*sin(q2)*dq1*dq1...
		- t2*t4*g*cos(q1) + t3*t5*g*cos(q2)*cos(q1+q2);
	u = (-k.kd*F - (t1*t2 - t3*t3*(cos(q2)).^2)*(dq1 + k.kp*(q1 - xG(1))))/...
		((t1*t2 - t3*t3*(cos(q2)).^2)*k.ke*2*g*min(t4,t5) + k.kd*t2);
	u = [u;0];
