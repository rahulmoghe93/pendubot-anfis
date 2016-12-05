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

	q1 = x(1); dq1 = x(2); q2 = x(3); dq2 = x(4);

	g=x(5); m1=x(6); m2=x(7); l1=x(8); l2=x(9);
	lc1=x(10); lc2=x(11); I1=x(12); I2=x(13);

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

	ddq = Dinv*([u-0.02*tanh(dq1*1000);-0.001*tanh(dq2*1000)] - G - C*[dq1;dq2]);
	% ddq = Dinv*([u-0.02*tanh(dq1*1000);-0.001*tanh(dq2*1000)] - G - C*[dq1;dq2]);

	xdot=zeros(13,1);

	xdot(1)=x(2);

	xdot(2)= ddq(1);

	xdot(3)=x(4);

	xdot(4)= ddq(2);
	% fprintf('t = %f\tq1 = %f\tq2 = %f\tu = %f\n',t,q1,q2,u);
