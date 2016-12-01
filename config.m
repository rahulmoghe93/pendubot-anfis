% This file reads the system parameters for the pendubot system as global variables

global 		xinit
global 		xG
global 		k

% Parameters
m1 		= 	0.4825		; % Mass of the actuated link
m2 		= 	0.2208		; % Mass of the non actuated link
l1 		= 	0.21		; % Length of the actuated link
lc1		= 	0.116		; % Length of the actuated link
l2 		= 	0.233		; % Length of the non actuated link
lc2		= 	0.134		; % Length of the non actuated link
g 		= 	9.81		; % Gravitational Constant
I1 		= 	0.00803		; % Gravitational Constant
I2 		= 	0.001812	; % Gravitational Constant
th1 	=	0			; % Initial anglular position of actuated link
th1dot	= 	0			; % Initial angular velocity of actuated link
th2 	=	pi/6		; % Initial anglular position of non actuated link
th2dot	= 	0			; % Initial angular velocity of non actuated link
k.ke 	= 	0.15		; % The gains for E_bar in the Lyapunov Function
k.kd 	= 	0.01		; % The gains for dq1 in the Lyapunov Function
k.kp 	= 	0.01		; % The gains for q_bar in the Lyapunov Function

% Initial condition vector
xinit 	=	[th1;th1dot;th2;th2dot;g;m1;m2;l1;l2;...
			lc1;lc2;I1;I2]; % Initial condition to the ode
xG = [pi/2;0];