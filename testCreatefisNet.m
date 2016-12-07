close all; clear all; clc

global 	kf2
% ----------------------
% Data
% ----------------------
Nstates		=	4		; % Number of states of the system
T 			= 	0.001	; % Sampling TIme
Nsamples 	=	20000	; % Number of Samples to predict ahead

% ----------------------
% Create FIS Net
% ----------------------

fisNet = create_anfis_net(Nstates);

% ----------------------------
% Prepare Data for the FIS Net
% ----------------------------

xin = zeros(Nstates,Nsamples);
xin = mat2cell(xin,[4],ones(1,Nsamples));

xout = zeros(1,Nsamples);
xout = mat2cell(xout,[1],ones(1,Nsamples));

% ----------------------------
% Train FIS network
% ----------------------------

fprintf('starting to train...\n')
fisNet = train(fisNet,xin,xout);

% ----------------------------
% Simulate FIS network
% ----------------------------

xo = sim(fisNet,xin);
xo = cell2mat(xo);

% ----------------------------
% Simulate Pendubot
% ----------------------------

% Fuzzy swing-up controller parameters
K = sqrt(svd(fisNet.LW{2,1}));
kf2.k1 = K(1);
kf2.k2 = K(2);
kf2.k3 = K(3);
kf2.k4 = K(4);
kf2.l = sqrt(svd(fisNet.LW{7,6}));
kf2.l = (kf2.l(1) + kf2.l(2))/2;
mu = sqrt(svd(fisNet.LW{5,4}));
kf2.mue = (mu(1) + mu(2))/2;
kf2.mus = (mu(3) + mu(4))/2;
kf2.G 	= fisNet.LW{9,8};

% Fuzzy PD based balancing controller
kf2.kp1 	= 	0.88		;
kf2.kd1 	= 	4.25		;
kf2.kp2 	= 	21.66		;
kf2.kd2 	= 	2.75		;
kf2.lam 	= 	0.75		;

save swingupweights kf2