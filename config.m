% This file reads the system parameters for the pendubot system as global variables

% Parameters
m1 		= 	0.4825		; % Mass of the actuated link
m2 		= 	0.2208		; % Mass of the non actuated link
l1 		= 	0.21		; % Length of the actuated link
l2 		= 	0.233		; % Length of the non actuated link
g 		= 	9.81		; % Gravitational Constant
th1 	=	1			; % Initial anglular position of actuated link
th1dot	= 	1			; % Initial angular velocity of actuated link
th2 	=	0			; % Initial anglular position of non actuated link
th2dot	= 	0			; % Initial angular velocity of non actuated link

% Initial condition vector
xinit 	=	[th1;th1dot;th2;th2dot;g;m1;m2;l1;l2]; % Initial condition to the ode