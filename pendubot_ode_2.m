function xdot = pendubot_ode_2(t,x,u)
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

	% Inertia Matrix H(q)
	H = [I1+I2+m2*l1*l1+2*m2*l1*lc2*cos(q2) I2+ m2*l1*lc2*cos(q2);...
		I2+m2*l1*lc2*cos(q2) I2];

	% Coriolis Matrix C(q,dq)
	C = [-2*m2*l1*lc2*sin(q2)*dq2, -m2*l1*lc2*sin(q2)*dq2;...
			m2*l1*lc2*sin(q2)*dq1,				0	];

	% Gravity Term g(q)
	G = [m1*lc1*g*sin(q1) + m2*l1*g*sin(q1) + m2*g*l2*sin(q1+q2);...
		m2*g*l2*sin(q1+q2)				];

	% Control Gain
	B = [1;0];

	% Inverse of Inertia Matrix
	Hinv = H\eye(2);

	ddq = Hinv*(C*[dq1;dq2] + G) + Hinv*B*u;


	% det(Dinv).*[t2*u(1); -(t2+t3*cos(q2))*u(1)] -...
	% 		Dinv*(C*[dq1;dq2] + G);
	% %  Inertia Matrix D(q)
	% D = [t1 + t2 + 2*t3*cos(q2), t2 + t3*cos(q2);...
	% 	 	t2 + t3*cos(q2),  t2];

	% %  Inverse of the inertia matrix
	% Dinv = [t2, -t2 - t3*cos(q2); -t2 - t3*cos(q2), t1+t2+2*t3*cos(q2)]./det(D);

	% % Coriolis Term C(q,dq)
	% C = t3.*sin(q2).*[-dq2, -dq2-dq1;...
	% 				   dq1,  0]; 

	% % Gravitational Term g(q)
	% g = [t4*g*cos(q1) + t5*g*cos(q1+q2) ; t5*g*cos(q1+q2)];

	% ddq = det(Dinv).*[t2*u(1); -(t2+t3*cos(q2))*u(1)] -...
	% 		Dinv*(C*[dq1;dq2] + g);

	xdot=zeros(13,1);

	xdot(1)=x(2);

	xdot(2)= ddq(1);

	xdot(3)=x(4);

	xdot(4)= ddq(2);