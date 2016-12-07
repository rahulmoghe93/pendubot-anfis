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

global 		changeFlag 		tChange
% Load configuration file to load all the variables
config

% Simulate the double link pendulum for the given input
duration		=		2		; % duration of the simulation
fps				=		100		; % frames per second
mov 			= 		1		; % 1 => store the video & 0 => don't save video
changeFlag 		=		0		; % Change to Linear Controller permanently
tChange			=		0		; % Start of linear controller

% Play animation
tic
pendubot
% pendubot(xinit, duration, fps, mov);
toc