% This file reads the system parameters for the pendubot system as global variables

global 		xinit
global 		xG
global 		EG
global 	 	kf 		k

% Parameters
l1t		= 	0.215		;
l1tp	= 	0.025		;
l1ts	= 	0.180		;
l1 		= 	l1ts - l1tp	;
m1 		= 	0.4306		; % Mass of the actuated link
m1l		=	0.13875		;
m1s 	= 	0.29185		;
m2 		= 	0.117		; % Mass of the non actuated link
lc1		= 	(0.5*m1l*l1t...
			+m1s*l1ts)/m1 - l1tp; % Length of the actuated link
l2 		= 	0.230		; % Length of the non actuated link
l2t		= 	0.255		; % 
l2tp	= 	l2t - l2	; % 
lc2		= 	l2t/2 - l2tp; % Length to the non actuated link COM
g 		= 	9.81		; % Gravitational Constant
w1 		=	0.038		; % Width of link 1
w2 		=	0.023		; % Width of link 2
I1 		= 	m1l*(w1*w1+l1t*l1t)/12 + m1l*(0.5*l1t - l1tp)^2 + m1s*l1*l1	; % Moment of Inertia of link 1
I2 		= 	m2*(w2*w2+l2t*l2t)/12 + m2*lc2*lc2; % Moment of Inertia of link 2
th1 	=	0			; % Initial anglular position of actuated link
th1dot	= 	0			; % Initial angular velocity of actuated link
th2 	=	0			; % Initial anglular position of non actuated link
th2dot	= 	0			; % Initial angular velocity of non actuated link

% Passivity controller parameters
k.ke 	= 	1.5			; % The gains for E_bar in the Lyapunov Function
k.kd 	= 	1			; % The gains for dq1 in the Lyapunov Function
k.kp 	= 	11			; % The gains for q_bar in the Lyapunov Function
k.kp1 	= 	0.88		; % Gain for the fuzzy PD linear controller
k.kd1 	= 	4.25		; % Gain for the fuzzy PD linear controller
k.kp2 	= 	21.66		; % Gain for the fuzzy PD linear controller
k.kd2 	= 	2.75		; % Gain for the fuzzy PD linear controller
k.l 	= 	0.75		;

% Fuzzy swing-up controller parameters
kf.k1 	= 	1			; % 
kf.k2 	= 	0.167		; % 
kf.k3 	= 	1			; % 
kf.k4 	= 	0.1			; % 
kf.mue 	= 	0.5			; % 
kf.mus 	= 	0.5			; % 
kf.l 	= 	0.325		; % 
kf.G 	= 	3			; % Gain for Torque

% Fuzzy PD based balancing controller
kf.kp1 	= 	0.88		;
kf.kd1 	= 	4.25		;
kf.kp2 	= 	21.66		;
kf.kd2 	= 	2.75		;
kf.lam 	= 	0.75		;

% Initial condition vector
xinit 	=	[th1;th1dot;th2;th2dot;g;m1;m2;l1;l2;...
			lc1;lc2;I1;I2]; % Initial condition to the ode
xG = [pi;pi];
EG = m1*g*lc1*cos(xG(1))-m2*g*(l1*cos(xG(1))+lc2*cos(xG(2))); % Energy of the goal state