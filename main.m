clear all; close all; clc

% Load configuration file to load all the variables
config

% Simulate the double link pendulum for the given input
duration		=		5		;
fps				=		100		;
mov 			= 		true	;

% Play animation
pendubot(xinit, duration, fps, mov);