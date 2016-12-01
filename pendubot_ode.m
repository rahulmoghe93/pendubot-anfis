function xdot = pendubot_ode(t,x,u)
% pendubot_ode Ordinary differential equations for pendubot.
%
%   author:  Rahul Moghe (rahulmoghe93@gmail.com)
%
%   parameters:
%
%   t       Column vector of time points 
%   xdot    Solution array. Each row in xdot corresponds to the solution at a
%           time returned in the corresponding row of t.
%
%   This function calls is called by double_pendulum.
%
%   ---------------------------------------------------------------------

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

	%  Inertia Matrix D(q)
	D = [t1 + t2 + 2*t3*cos(q2), t2 + t3*cos(q2);...
		 	t2 + t3*cos(q2),  t2];

	%  Inverse of the inertia matrix
	Dinv = [t2, -t2 - t3*cos(q2); -t2 - t3*cos(q2), t1+t2+2*t3*cos(q2)]./det(D);

	% Coriolis Term C(q,dq)
	C = t3.*sin(q2).*[-dq2, -dq2-dq1;...
					   dq1,  0]; 

	% Gravitational Term g(q)
	g = [t4*g*cos(q1) + t5*g*cos(q1+q2) ; t5*g*cos(q1+q2)];

	ddq = det(Dinv).*[t2*u(1); -(t2+t3*cos(q2))*u(1)] -...
			Dinv*(C*[dq1;dq2] + g);

	xdot=zeros(13,1);

	xdot(1)=x(2);

	xdot(2)= ddq(1);

	xdot(3)=x(4);

	xdot(4)= ddq(2);