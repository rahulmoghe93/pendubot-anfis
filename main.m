% 
% 			Pendubot Simulation Code
% 
% 		Applied Intel Class
% 		Instructor: Dr. Benito R. Fernandez
% 
% 		Run main
% author	:	Rahul Moghe
% date		:	Nov 23, 2016
clear all; close all; clc

% Load configuration file to load all the variables
config

% Simulate the double link pendulum for the given input
duration		=		300		; % duration of the simulation
fps				=		20		; % frames per second
mov 			= 		0		; % 1 => store the video & 0 => don't save video

% Play animation
pendubot
% pendubot(xinit, duration, fps, mov);