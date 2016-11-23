clear all; close all; clc

% Load configuration file to load all the variables
config

% Simulate the double link pendulum for the given input
duration		=		10		;
fps				=		50		;
mov 			= 		false	;

% Play animation
pendubot(xinit, duration, fps, mov);